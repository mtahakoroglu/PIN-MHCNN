clearvars, 
% trajectory 
filename = 'a-predicted-groundtruth.csv';
trajectory = readmatrix(filename);
cnnx=trajectory(:,1);
cnny=trajectory(:,2);
gtx=trajectory(:,3);
gty=trajectory(:,4);
t=0:0.004:(length(trajectory)*0.004)-0.004;
% dyaw
filename = 'a-deltayaw.csv';
dyaw = readmatrix(filename);
dyaw_mali_filtered=dyaw(:,1);
dyaw_predicted_cnn_filtered=dyaw(:,2);
dyaw_original_gt=dyaw(:,3);
dyaw_predicted_unfiltered=dyaw(:,4);

% dmag
filename = 'a-gtmag-predmag-filtpredmag.csv';
dmag = readmatrix(filename);
dmag_mali_filtered_gt=dmag(:,1);
dmag_predicted_unfiltered=dmag(:,2);
dmag_predicted_cnn_filtered=dmag(:,3);
% yaw
filename = 'a-yaw.csv';
yaw = readmatrix(filename);
yaw_from_traj_predicted_filtered_cnn=yaw(:,1);
yaw_from_traj_predicted_unfiltered_cnn=yaw(:,2);
yaw_original=yaw(:,3);
yaw_from_traj_mali_fitered=yaw(:,4);
%--------------------plot-------------------------------------------------
%plot trajectory
figure
plot(gty,gtx,'b')
hold on
plot(cnny,cnnx,'r')
legend('gt','predicted gt')

%plot dyaw
figure
plot(t,dyaw_mali_filtered,'b')
hold on
plot(t,dyaw_predicted_cnn_filtered,'r')
plot(t,dyaw_original_gt,'g')
plot(t,dyaw_predicted_unfiltered,'c')
legend('dyaw mali filtered','dyaw predicted cnn filtered','dyaw original','dyaw predicted unfiltered')


%plot dmag
figure
plot(t,dmag_mali_filtered_gt,'b')
hold on
plot(t,dmag_predicted_cnn_filtered,'r')
plot(t,dmag_predicted_unfiltered,'c')
legend('dmag mali filtered gt','dmag predicted cnn filtered','dmag predicted unfiltered')
%plot yaw
figure(2)
plot(t,yaw_from_traj_predicted_filtered_cnn,'b')
hold on
plot(t,yaw_from_traj_predicted_unfiltered_cnn,'r')
plot(t,yaw_original,'g')
plot(t,yaw_from_traj_mali_fitered,'c')

legend('yaw from traj predicted filtered cnn','yaw from traj predicted unfiltered cnn','yaw original','yaw from traj mali fitered')
%%
err=yaw_original-yaw_from_traj_predicted_filtered_cnn;
figure
histfit(err,30)
[acf,lags] = autocorr(err)
figure
autocorr(err,length(err)-1)
grid on;
std_err=std(err)
mean_err=mean(err)
figure
qqplot(yaw_original,yaw_from_traj_predicted_filtered_cnn);
figure
qqplot(err)
[h,p]=kstest(err)







