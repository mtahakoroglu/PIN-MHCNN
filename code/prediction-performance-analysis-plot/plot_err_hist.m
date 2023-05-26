clear all ;clc;
% trajectory 
filename = 'a-predicted-groundtruth.csv';
trajectory = readmatrix(filename);
cnnx=trajectory(:,1);
cnny=trajectory(:,2);
gtx=trajectory(:,3);
gty=trajectory(:,4);
t=1:length(trajectory);
% dyaw
filename1 = 'a-deltayaw.csv';
dyaw = readmatrix(filename1);
dyaw_mali_filtered=dyaw(:,1);
dyaw_predicted_cnn_filtered=dyaw(:,2);
dyaw_original_gt=dyaw(:,3);
dyaw_predicted_unfiltered=dyaw(:,4);

% dmag
filename2 = 'a-gtmag-predmag-filtpredmag.csv';
dmag = readmatrix(filename2);
dmag_mali_filtered_gt=dmag(:,1);
dmag_predicted_unfiltered=dmag(:,2);
dmag_predicted_cnn_filtered=dmag(:,3);
% yaw
filename3 = 'a-yaw.csv';
yaw = readmatrix(filename3);
yaw_from_traj_predicted_filtered_cnn=yaw(:,1);
yaw_from_traj_predicted_unfiltered_cnn=yaw(:,2);
yaw_original=yaw(:,3);
yaw_from_traj_mali_fitered=yaw(:,4);
%% --------------------plot-------------------------------------------------
%plot dyaw
figure;
plot(t,dyaw_mali_filtered,'g','LineWidth',1.2);
hold on;
plot(t,dyaw_predicted_cnn_filtered,'r','LineWidth',1.2);
set(gcf,'color','w');
legend('Heading Change of Ground Truth','Predicted Heading Change  ','fontweight','bold','fontsize',11)
xlabel('Sample','fontweight','bold','fontsize',11);
ylabel('Error','fontweight','bold','fontsize',11);
grid on;
%plot dmag
figure;
plot(t,dmag_mali_filtered_gt,'g','LineWidth',1.2)
set(gcf,'color','w');
hold on
plot(t,dmag_predicted_cnn_filtered,'r','LineWidth',1.2)
set(gcf,'color','w');
legend('Norm of Position Change of ground-truth','Predicted Norm of Position Change','fontweight','bold','fontsize',11)
grid on
xlabel('Sample','fontweight','bold','fontsize',11) 
ylabel('Error','fontweight','bold','fontsize',11) 
err_pos=dmag_mali_filtered_gt-dmag_predicted_cnn_filtered;
err_yaw=dyaw_mali_filtered-dyaw_predicted_cnn_filtered;

figure
histfit(err_yaw,30)
set(gcf,'color','w');
xlabel('Error in Heading Change','fontweight','bold','fontsize',11) 
ylabel('Frequency','fontweight','bold','fontsize',11) 
grid on

figure
set(gcf,'color','w');
qqplot(err_yaw)
xlabel('Standard Normal Quantiles','fontweight','bold','fontsize',11) 
ylabel('Quantiles of Input Sample','fontweight','bold','fontsize',11) 
grid on


figure
histfit(err_pos,30)
set(gcf,'color','w');
xlabel('Error in Norm of Position Change','fontweight','bold','fontsize',11) 
ylabel('Frequency','fontweight','bold','fontsize',11) 
grid on

figure
set(gcf,'color','w');
qqplot(err_pos)
xlabel('Standard Normal Quantiles','fontweight','bold','fontsize',11) 
ylabel('Quantiles of Input Sample','fontweight','bold','fontsize',11) 
grid on


std_err_pos=std(err_pos)
mean_err_pos=mean(err_pos)

std_err_yaw=std(err_yaw)
mean_err_yaw=mean(err_yaw)

[h,p]=kstest(err_pos)
[h,p]=kstest(err_yaw)
%% plot with subplots (for paper)
close all;
figure; set(gcf,'position',[20 70 1488 500], 'color', 'w');
lw = 1.2; fs = 11;
% heading change (dyaw) estimation
subplot(2,3,1);
plot(t, dyaw_mali_filtered,'g','LineWidth',lw);
hold on;
plot(t, dyaw_predicted_cnn_filtered, 'r', 'LineWidth', lw);
grid on; set(gca,'gridlinestyle','--','position',[0.027 0.58 0.35 0.38]);
h = legend('pseudo GT','MHCNN','fontsize', 13);
set(h,'location','northwest','interpreter','latex'); axis tight;
set(gca,'fontsize',fs);
xlabel('sample','fontsize',fs);
ylabel('heading change (radian)','fontsize',fs);
text(15300,0.0075,'(a)','FontSize',18,'interpreter','latex');
% displacement (dmag) estimation
subplot(2,3,4);
plot(t,dmag_mali_filtered_gt,'g','LineWidth',lw);
hold on;
plot(t,dmag_predicted_cnn_filtered,'r','LineWidth',lw);
grid on; set(gca,'gridlinestyle','--','position',[0.027 0.095 0.35 0.38]);
h = legend('pseudo GT','MHCNN','fontsize',13);
set(h,'location','south','interpreter','latex');
set(gca,'fontsize',fs);
axis([t(1) t(end) -0.001 0.008]);
xlabel('sample','fontsize',fs);
ylabel('displacement (m)','fontsize',fs);
text(15300,0.0068,'(b)','FontSize',18,'interpreter','latex');
err_yaw=dyaw_mali_filtered-dyaw_predicted_cnn_filtered;
err_pos=dmag_mali_filtered_gt-dmag_predicted_cnn_filtered;
% error histograms
subplot(2,3,2); % histogram of error in heading change
h = histfit(err_yaw,30);
h(1).FaceColor = [0.75,0.75,0.75];
xlabel('error (radian)','fontsize',fs); 
ylabel('number of samples','fontsize',fs);
grid on; set(gca,'gridlinestyle','--','position',[0.43 0.58 0.25 0.38]);
axis([-1e-3*4,1e-3*4,0,10000]);
set(gca,'fontsize',fs);
text(0.0032,8700,'(c)','FontSize',18,'interpreter','latex');
subplot(2,3,5); % histogram of error in position change
h = histfit(err_pos,30);
h(1).FaceColor = [0.75,0.75, 0.75];
set(gcf,'color','w');
xlabel('error (m)', 'fontsize',fs);
ylabel('number of samples','fontsize',fs);
grid on; set(gca,'gridlinestyle','--','position',[0.43 0.095 0.25 0.38]);
set(gca,'fontsize',fs);
text(0.0031,1300,'(d)','FontSize',18,'interpreter','latex');
% quantiles
subplot(2,3,3);
qqplot(err_yaw);
xlabel('standard normal quantiles','fontsize',fs);
ylabel('quantiles of input sample','fontsize',11);
grid on; set(gca,'gridlinestyle','--','position',[0.74 0.58 0.25 0.35]);
set(gca,'fontsize',fs);
text(4,0.008,'(e)','FontSize',18,'interpreter','latex');
subplot(2,3,6);
set(gcf,'color','w');
qqplot(err_pos);
xlabel('standard normal quantiles','fontsize',fs); 
ylabel('quantiles of input sample','fontsize',fs); 
grid on; set(gca,'gridlinestyle','--','position',[0.74 0.095 0.25 0.35]);
set(gca,'ytick',1e-3*[-5,0,5],'yticklabel',{'-0.005','0','0.005'});
set(gca,'fontsize',fs);
text(4,0.0045,'(f)','FontSize',18,'interpreter','latex');

std_err_pos=std(err_pos)
mean_err_pos=mean(err_pos)

std_err_yaw=std(err_yaw)
mean_err_yaw=mean(err_yaw)

[h,p]=kstest(err_pos)
[h,p]=kstest(err_yaw)
%% save results to file
print('-f1','quantitative-result','-dpng','-r600');
print('-f1','quantitative-result','-dpdf','-r600');