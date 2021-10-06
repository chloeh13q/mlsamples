mkdir -p output
# stream logs to command line with papermill --log-output --log-level DEBUG --progress-bar
papermill dataloader.ipynb output/dataloader_output_$EPOCHSECONDS.ipynb
papermill model.ipynb output/model_output_$EPOCHSECONDS.ipynb