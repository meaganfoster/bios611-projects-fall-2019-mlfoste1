build:
	docker build -t dockerbuild	.	-f scripts/Dockerfile && \
	touch $@
	
master.csv: wrangling.ipynb build
	python wrangling.ipynb $@

disability.csv: wrangling.ipynb build
	python wrangling.ipynb $@

results/master_df.html: disability.csv master.csv
	Rscript -e "rmarkdown::render('./scripts/master_df.rmd', 'html_document',output_dir = './results/')"