APP = app-name
VERSION = 0.0.1
EMAIL = $(CYVERSEUSERNAME)@email.arizona.edu

clean:
	find . \( -name \*.conf -o -name \*.out -o -name \*.log -o -name \*.param -o -name launcher_jobfile_\* \) -exec rm {} \;

container:
	rm -f stampede/$(APP).img
	sudo singularity create --size 512 stampede/$(APP).img
	sudo singularity bootstrap singularity/$(APP).img stampede/$(APP).def
	sudo chown --reference=singularity/$(APP).def stampede/$(APP).img

iput-container:
	iput -K stampede/$(APP).img

iget-container:
	iget -K $(APP).img
	mv $(APP).img stampede/

test:
	sbatch test.sh

jobs-submit:
	jobs-submit -F stampede/job.json

files-delete:
	files-delete $(CYVERSEUSERNAME)/applications/$(APP)-$(VERSION)

files-upload:
	files-upload -F stampede/ $(CYVERSEUSERNAME)/applications/$(APP)-$(VERSION)

apps-addupdate:
	apps-addupdate -F stampede/app.json

deploy-app: clean files-delete files-upload apps-addupdate

share-app:
	systems-roles-addupdate -v -u <share-with-user> -r USER tacc-stampede-$(CYVERSEUSERNAME)
	apps-pems-update -v -u <share-with-user> -p READ_EXECUTE $(APP)-$(VERSION)
