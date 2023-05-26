clearvars, clc; close all;
% (displacement, yaw, displacement, yaw) of CNN and pseudo-GT, respectively.
trajectory = load('a-predicted-groundtruth.csv');
MHCNN = trajectory(:,1:2)';
pseudoGT = trajectory(:,3:4)';
ESKF = load('KFtrajectory.csv')';
%% trajectory visualization
rotAngle = (0/180)*pi; % counter-clockwise
R = [cos(rotAngle), -sin(rotAngle);sin(rotAngle), cos(rotAngle)];
MHCNN = (MHCNN'*R)';
figure(1); set(gcf,'Position',[90 427 624 305]); lw = 1.2;
plot(pseudoGT(2,:),pseudoGT(1,:),'r-','LineWidth',lw);
hold on;
plot(ESKF(2,:),ESKF(1,:),'g-','LineWidth',lw);
plot(MHCNN(2,:),MHCNN(1,:),'b-','LineWidth',lw);
hold off;
grid on; set(gca, 'gridlinestyle', '--', 'linewidth', 1, 'FontSize',13);
set(gca,'ytick',[-6:3:6],'XTickLabel',{'-6','-3','0','3','6'});
set(gca,'position', [0.0891, 0.1559, 0.8760, 0.8093]);
xlabel('x (m)','FontSize',14); ylabel('y (m)','FontSize',15);
h = legend('pseudo GT', 'error-state KF', 'MHCNN');
set(h,'location','northwest','fontsize', 13,'interpreter','latex');
axis equal; axis([-8,23,-8,6]);
print('-f1','MHCNN-trajectory','-dpng','-r300');
print('-f1','trajectory','-dpdf','-r50');
%% sample-wise positioning errors
error = pseudoGT - MHCNN;
errorPosition = sqrt(sum(error.^2));
figure(2); clf; set(gcf,'position',[721.8, 442.6, 708, 267.2]);
stem(errorPosition,'k.','linewidth',lw,'Color',[0.5,0.5,0.5]);
grid on; set(gca, 'gridlinestyle', '--', 'linewidth', 1,'FontSize',18);
xlabel('sample', 'fontsize', 18); ylabel('error (m)', 'fontsize', 18);
axis([0 length(errorPosition) 0 2]);
print('-f2','sample-wise-displacement-error','-dpng','-r300');
% print('-f2','sample-wise-displacement-error','-dpdf','-r100');
set(gca,'position',[0.0719, 0.2725, 0.9202, 0.6826]);
%% yaw signal
load('yaw.txt');
yawGT = yaw(:,1); yawMHCNN = yaw(:,2); yawMHCNNfiltered = yaw(:,3);
figure(3); clf;
plot(1:length(yaw), yawGT','r-','linewidth',lw); hold on;
plot(1:length(yaw), yawMHCNN','b-','linewidth',lw); hold off;
grid on; set(gca, 'gridlinestyle', '--','FontSize',18);
xlabel('sample', 'fontsize', 18); ylabel('heading (radian)', 'fontsize', 18);
h = legend('pseudo GT', 'MHCNN');
set(h,'location','southeast','fontsize', 18,'interpreter','latex');
axis([0 length(yawGT) -5 2]);
print('-f3','sample-wise-heading','-dpng','-r500');
print('-f3','sample-wise-heading','-dpdf','-r100');