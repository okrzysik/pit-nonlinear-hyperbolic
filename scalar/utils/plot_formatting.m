% Basically just remove color bars and add some grid lines to a couple
% plots (I only used this for a couple figs in the supp matt.)

tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));

clc
clear 
close all 

save_fig = ~true;

upper_xlim = 20;


suf_fig = '-F(8)-MGRIT-F-FCF(8)-LU-10';
suf_new_fig = '-F(8)-DIRECT-MGRIT-ML';
open_fig_dir = '../figures/paper/inexact/multilevel/';



% Manyally choose legend location
leg_loc = 'SouthWest';
leg_loc = 'NorthEast';

pref = 'B(3)-LLF-lin(1)';  show_y_label = true;  show_legend = ~false;
%pref = 'BL(3)-LLF-lin(1)'; show_y_label = false; show_legend = false;


save_fig_name = sprintf('%s%s%s', open_fig_dir, pref, suf_new_fig);

fig_name = sprintf('%s%s%s', open_fig_dir, pref, suf_fig);
fh = openfig(fig_name);
l  = findall(get(fh, 'Number'), 'type','legend');

% FINDALL and not FINDOBJ because after saving the line properties of the
% figures are empty. 
copyobj(findall(get(fh, 'Number'), 'type', 'line'), findall(get(fh, 'Number'), 'type', 'axes'))

figure(fh)
if ~show_y_label
    ylabel('')
    yticklabels([])
end

if ~show_legend
    l = findall(get(fh, 'Number'), 'type','legend');
    delete(l)
else
   l.String(1:numel(l.String)/2) = '';
   set(l, 'Location', leg_loc)
end

if exist('upper_xlim','var')
   xlim([0 upper_xlim]) 
end

grid minor
grid on
grid minor
%set(gca,'YMinorTick','Off')
%grid minor
    
if save_fig
    figure_saver(figure(fh), save_fig_name)
end


% Save the figure
function figure_saver(fig, fig_name)
    fig.PaperPositionMode = 'auto';
    fig_pos = fig.PaperPosition;
    fig.PaperSize = [fig_pos(3) fig_pos(4)];
    set(gcf, 'Color', 'w'); % Otherwise saved fig will have grey background
    export_fig(strcat(fig_name, '.png'), '-m4')
    %saveas(gcf, strcat(fig_name, '.fig'));
end