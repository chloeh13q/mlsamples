mkdir -p output
papermill dataloader.ipynb output/dataloader_output_$EPOCHSECONDS.ipynb
papermill model.ipynb output/model_output_$EPOCHSECONDS.ipynb