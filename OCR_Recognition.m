
%Part 1, image: A

im = imread('a.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
AFeatures = Features;
idA = ones(size(AFeatures(:,1)));

%Part 1, image: D

im = imread('d.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
DFeatures = Features;
idD = ones(size(DFeatures(:,1)))*2;

%Part 1, image: M

im = imread('m.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
MFeatures = Features;
idM = ones(size(MFeatures(:,1)))*3;

%Part 1, image: N

im = imread('n.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
NFeatures = Features;
idN = ones(size(NFeatures(:,1)))*4;

%Part 1, image: O

im = imread('o.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
OFeatures = Features;
idO = ones(size(OFeatures(:,1)))*5;

%Part 1, image: P

im = imread('p.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
PFeatures = Features;
idP = ones(size(PFeatures(:,1)))*6;

%Part 1, image: Q

im = imread('q.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
QFeatures = Features;
idQ = ones(size(QFeatures(:,1)))*7;

%Part 1, image: R

im = imread('r.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
RFeatures = Features;
idR = ones(size(RFeatures(:,1)))*8;

%Part 1, image: U

im = imread('u.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
UFeatures = Features;
idU = ones(size(UFeatures(:,1)))*9;

%Part 1, image: W

im = imread('w.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
BoundBox
WFeatures = Features;
idW = ones(size(WFeatures(:,1)))*10;

Features = [AFeatures; DFeatures; MFeatures; NFeatures; OFeatures; PFeatures; QFeatures; RFeatures; UFeatures; WFeatures];
id = [idA; idD; idM; idN; idO; idP; idQ; idR; idU; idW];
means = mean(Features);
stdDev = std(Features);

%For every item in column subtract, mean and divide by the standard deviation

for i=1:length(means)%size(means)
    Features(:,i) = Features(:,i) - means(:,i);
    Features(:,i) = Features(:,i) / stdDev(:,i);
end
D = dist2(Features,Features);
figure
imagesc(D);
title('Affinity Matrix')
sortMatrix = D;
Prediction = [];
for i=1:length(D)
    sortMatrix(i,:) = sort(sortMatrix(i,:));
    p = sortMatrix(i,2);
    idIndex = findIndex(D(i,:),p);
    predictionID = id(idIndex,1);
    Prediction = [Prediction; predictionID];
end
id = id';
predictionID = predictionID';
ConMat = ConfusionMatrix(id, Prediction, 10);
figure
imagesc(ConMat);
title('Confusion Matrix')
recogRate = (trace(ConMat))/(sum(sum(ConMat)))


%part 4 code for test1.bmp and test2.bmp

im = imread('test.bmp');
th = 200;
im2 = im;
im2(im>=th) = 0;
im2(im<th) = 1;
L = bwlabel(im2);
boundingBox
TestFeatures = Features;
idTestArray = [];

for i=1:10
    for j=1:7
        idTestArray = [idTestArray; i];
    end
end

arrayResults = [Results idTestArray];
	
	for ii = 1:size(arrayResults,1)
	fprintf(fileID,'%d, %d, %d, %d, %d',arrayResults(ii,:));
	fprintf(fileID,'\n');
	end
	
	fclose(fid);

%normalization for the test image

for i=1:size(means)%size(means)
    TestFeatures(:,i) = TestFeatures(:,i) - means(:,i);
    TestFeatures(:,i) = TestFeatures(:,i) / stdDev(:,i);
end

distanceTest = dist2(TestFeatures, Features);
figure
imagesc(distanceTest);
title(‘test image matrix’)
sortMatrixTest = distanceTest;
PredictionForTest = [];
for i=1:length(distanceTest)
    sortMatrixTest(i,:) = sort(sortMatrixTest(i,:));
    p = sortMatrixTest(i,2);
    idIndex = findIndex(distanceTest(i,:),p);
    predictionID = idTestArray(idIndex, 1);
    predictionForTest = [predictionForTest; predictionID];
end
idTestArray = reshape(idTestArray,70,1);
predictionForTest = predictionForTest';
ConMatrix = ConfusionMatrix(idTestArray, predictionForTest, 10);
figure
imagesc(ConMatrix);
recogRate = (trace(ConMatrix))/(sum(sum(ConMatrix)))