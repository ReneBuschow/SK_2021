dir = getDirectory("Choose a Folder");
print(dir);
setForegroundColor(255, 255, 255);
image=getFileList(dir);

for(k=0;k<image.length;k++)
{ 
	
	open(dir+image[k]);
	name=getTitle();
	setTool("line");
	waitForUser("Please add Profile");
	roiManager("Add");
	roiManager("Deselect");
	roiManager("Save", ""+dir+name+"RoiSet.zip");
	
		
selectWindow(name);
	roiManager("Select", 0);
	setSlice(1);
	profile = getProfile();
  	for (i=0; i<profile.length; i++)
      setResult("CH1", i, profile[i]);
	  updateResults;

	  
	setSlice(2);
//	roiManager("Select", 0);
  	profile = getProfile();
  	for (i=0; i<profile.length; i++)
      setResult("CH2", i, profile[i]);
	  updateResults;

	setSlice(3);
//	roiManager("Select", 0);
  	profile = getProfile();
  	for (i=0; i<profile.length; i++)
      setResult("CH3", i, profile[i]);
	  updateResults;

	
				selectWindow("Results");
				saveAs("Text", ""+dir+name+"_profile.txt");
				run("Clear Results");


run("Stack to Images");
close();	

rename("PHF13");
run("Put Behind [tab]");
rename("DNA");
run("Merge Channels...", "c1=PHF13 c5=DNA keep");
rename("Merge");

selectWindow("DNA");
run("Cyan");
run("RGB Color");
roiManager("Select", 0);
run("Properties... ", "  width=5");
run("Fill", "slice");

selectWindow("PHF13");
run("Red");
run("RGB Color");

run("Images to Stack", "name=Stack title=[] use");
setForegroundColor(255, 255, 255);
run("Make Montage...", "columns=3 rows=1 scale=1 border=5 use");
saveAs("Tiff", dir+"montage"+image[k]);
close();	
selectWindow("Stack");
close();
roiManager("Delete");
	
}
