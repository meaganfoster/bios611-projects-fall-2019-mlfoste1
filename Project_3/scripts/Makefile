build_project3:
	docker build -t dockerbuild	.	-f scripts/Dockerfile && \
	touch $@
	
master.csv: build_project3
	python scripts/wrangling.py
	
results/master_df.html: master.csv
	Rscript -e "rmarkdown::render('scripts/master_df.rmd', 'html_document',output_dir = 'results/')"