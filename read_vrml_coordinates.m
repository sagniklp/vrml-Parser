function [coordinates]= read_vrml_coordinates( dir, filename)
    
    fp=fopen(strcat(dir,filename),'r');
    if fp == -1
        fclose all;
        sprintf('Cannot open file: %s \n', filename);
    end
    
    tempstr=' ';
    coordinates=[];
    while (tempstr ~= -1)
        tempstr=fgets(fp);
        if (strfind(tempstr,'coord Coordinate'))
            break;
        end
        %display(tempstr);
    end
    tempstr=fgets(fp);
    while true
        tempstr=fgets(fp);
        if (strfind(tempstr,']'))
            break;
        else
            point= sscanf(tempstr,'%f %f %f');
            %point_x=point(1);
            %point_y=point(2);
            %point_z=point(3);
            coordinates=[coordinates point(1) point(2) point(3)]; 
        end
    end
    fclose(fp);
end