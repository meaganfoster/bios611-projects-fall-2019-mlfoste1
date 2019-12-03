build_project3:
	docker build -t dockerbuild	.	-f scripts/Dockerfile && \
	touch $@
	
master.csv: build_project3
	python scripts/wrangling.py
	git:
    git add .
    git commit -m "$m"
	make git m="master.csv added"
    git push -u origin master
	

disability.csv: build_project3
	python scripts/wrangling.py
	git:
    git add .
    git commit -m "$m"
	make git m="master.csv added"
    git push -u origin master

	
results/master_df.html: disability.csv master.csv
	Rscript -e "rmarkdown::render('scripts/master_df.rmd', 'html_document',output_dir = 'results/')"