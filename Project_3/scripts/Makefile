build_project3:
	docker build -t dockerbuild	.	-f scripts/Dockerfile && \
	touch $@
	
master.csv: build_project3
	wrangling.py

disability.csv: build_project3
	wrangling.py

results/master_df.html: disability.csv master.csv
	Rscript -e "rmarkdown::render('master_df.rmd', 'html_document',output_dir = 'results/')"