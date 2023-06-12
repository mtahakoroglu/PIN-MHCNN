<h3>Pedestrian Inertial Navigation with Multi-Head CNN</h3>

<figure>
    <img src=figure/gait_cycle.png alt="human gait" width=80% height=auto>
    <caption>Fig 1. Pedestrian gait cycle</caption>
</figure>

<figure>
    <img src=figure/mhcnn-structure.png alt="MHCNN model" width=100% height=auto>
    <caption>Fig 2. Proposed Multi-Head CNN (MHCNN) prediction model</caption>
</figure>


<figure>
    <img src=figure/MHCNN-trajectory.png alt="MHCNN trajectory" width=80% height=auto>
    <caption>Fig 3. Pedestrian trajectory estimations</caption>
</figure>

<p align="justify">The error-state KF pedestrian INS (MATLAB) implementation can be found at <a href="http://www.openshoe.org/">OpenShoe</a> webpage.</p>
<p align="justify">If you like to cite this work, please use the BibTeX info</p>

```
@INPROCEEDINGS
{
    PIN-MHCNN,
    author={Cetin, Gokhan and Kucuk, Mehmet Ali and Koroglu, Muhammed Taha},
    booktitle={$6^{th}$ IEEE International Workshop on Metrology for Industry 4.0 \& IoT},
    title={Pedestrian Inertial Navigation with Multi-Head {C}{N}{N}},
    year={2023},
    volume={},
    number={},
    pages={1-6},
    doi={},
    ISSN={},
    month={June},
}
```

or the following plain text.

<p align="justify">G. Cetin, M. A. Kucuk, and M. T. Koroglu, "Pedestrian inertial navigation with multi-head CNN," in <em>$6^{th}$ IEEE International Workshop on Metrology for Industry 4.0 & IoT</em>, pp. 1–6, Brescia, Italy, 2023.</p>

<p align="justify">The trained network (the file with <b>h5</b> extension) is not in the repo: Github rejected uploading the model file due to large size and while using <b>rm</b> command in git to remove the model file from the added files, the model is accidentally deleted. Yet, one can reproduce it by training the model from scratch (just run <b>code/mhcnn-training/imu-localization.ipynb</b> - training takes approximately 11 hours with the machine mentioned in the paper).</p>
