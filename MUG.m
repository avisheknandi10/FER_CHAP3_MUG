PATH = 'E:\MUG\points';
FILES = dir([PATH,'\*.pts']);

% lmrk = [18,20,22,23,25,27,37,38,41,40,43,44,47,46,32,34,36,49,55,52,58];
%     
leyebrow = 18:22;
reyebrow = 23:27;
leye = 37:42;
reye = 43:48;
nose = 31:36;
mouth = 49:68;
overall = [18,20,22,23,25,27,37,38,41,40,43,44,47,46,32,34,36,49,55,52,58];

% lenT = nchoosek(length(lmrk),3);
% % Fuzzy Tringel Sinature
% TSS = zeros(length(FILES),lenT);
% % Fuzzy Tringel Sinature
% FTS = zeros(length(FILES),lenT,5);
% % Centroid Distance Signature
% CDS = zeros(length(FILES),lenT,6);
TSS_leyebrow = zeros(length(FILES),nchoosek(length(leyebrow),3),11);
TSS_reyebrow = zeros(length(FILES),nchoosek(length(reyebrow),3),11);
TSS_leye = zeros(length(FILES),nchoosek(length(leye),3),11);
TSS_reye = zeros(length(FILES),nchoosek(length(reye),3),11);
TSS_nose = zeros(length(FILES),nchoosek(length(nose),3),11);
TSS_mouth = zeros(length(FILES),nchoosek(length(mouth),3),11);
TSS_overall = zeros(length(FILES),nchoosek(length(overall),3),11);


emotions = {'an','di','fe','ha','sa','su'}; 
EMO = zeros(1,length(FILES));
% Centroid Distance Signature
%CDS = zeros(length(FILES),lenT,8);
% no of images --> length(FILES)
% no of tringels --> lenT
% no of fuzzy measures --> 5

%EXP = zeros(length(FILES),1);

h = waitbar(0,'Please wait computing Signatures ...');

for i = 1:length(FILES)
    disp(i)
    
    name = FILES(i).name;
    folder = FILES(i).folder;
    foldername = [folder,'\',name];
    %EXP(i) = dlmread(foldername);
    
    % Get Emotions
    for j = 1:length(emotions)
        if contains(name,emotions{j})
            EMO(i) = j;
        end
    end
    
    points = dlmread(foldername);
        
    TSS_leyebrow(i,:,:) = triangle_side_signature(points(leyebrow,:));
    TSS_reyebrow(i,:,:) = triangle_side_signature(points(reyebrow,:));
    TSS_leye(i,:,:) = triangle_side_signature(points(leye,:));
    TSS_reye(i,:,:) = triangle_side_signature(points(reye,:));
    TSS_nose(i,:,:) = triangle_side_signature(points(nose,:));
    TSS_mouth(i,:,:) = triangle_side_signature(points(mouth,:));
    TSS_overall(i,:,:) = triangle_side_signature(points(overall,:));
    
    waitbar(i / length(FILES))
    
end
TSS = {TSS_leyebrow,TSS_reyebrow,TSS_leye,...
    TSS_reye,TSS_nose,TSS_mouth,TSS_overall};




TSS2 = cell2mat(TSS);
close(h)

I = eye(7);
EMO2 = I(EMO+1,:);


        
        