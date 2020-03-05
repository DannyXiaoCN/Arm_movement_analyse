%% chosen direction  (1:up; 2:right; 3:left )
SpatialInfo = zeros(size(BHV.AnalogData,2),4);
SpatialInfo(:,1) = TOD_M.Choice; % choice
SpatialInfo(:,2) = BHV.ConditionNumber; % condition number
SpatialInfo(:,3) =TOD_M.TOD(:,5); % spatial configuration

for ii = 1:length(SpatialInfo)
   
   if SpatialInfo(ii,3)>3
      SpatialInfo(ii,2) = SpatialInfo(ii,2)-3;
   end
  
   % chosen location (1:up/ 2:right/ 3:left)
   if SpatialInfo(ii,1) == 0
      SpatialInfo(ii,4) = 0;
   elseif SpatialInfo(ii,1) == 1
          if SpatialInfo(ii,2) == 1
             if SpatialInfo(ii,3) < 5
                SpatialInfo(ii,4) =1;
             else
                SpatialInfo(ii,4) =2;
             end
          elseif SpatialInfo(ii,2) == 2
             if SpatialInfo(ii,3) < 5
                SpatialInfo(ii,4) =2;
             else
                SpatialInfo(ii,4) =3;
             end
          elseif SpatialInfo(ii,2) == 3
             if SpatialInfo(ii,3) < 5
                SpatialInfo(ii,4) =3;
             else
                SpatialInfo(ii,4) =1;
             end
          end
   elseif SpatialInfo(ii,1) == 2
          if SpatialInfo(ii,2) == 1
             if SpatialInfo(ii,3) < 5
                SpatialInfo(ii,4) =2;
             else
                SpatialInfo(ii,4) =1;
             end
          elseif SpatialInfo(ii,2) == 2
             if SpatialInfo(ii,3) < 5
                SpatialInfo(ii,4) =3;
             else
                SpatialInfo(ii,4) =2;
             end
          elseif SpatialInfo(ii,2) == 3
             if SpatialInfo(ii,3) < 5
                SpatialInfo(ii,4) =1;
             else
                SpatialInfo(ii,4) =3;
             end
          end  
   end
   
end