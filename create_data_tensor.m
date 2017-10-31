function T= create_data_tensor(folder)
    scan_folders=dir(folder);
    l=[];
    vertices=31998; %max vertices%
    expr=6;         %total expressions%
    identity=35;    %total %
    T=ones(vertices,expr,identity);
    id_indx=1;
    for k=1:length(scan_folders)
       folder_name=scan_folders(k).name;
       if (length(folder_name)>2)
            search_directory=strcat(folder,folder_name);
            directory=strcat(search_directory,'\*_F3D.wrl');
            files=dir(directory);
            %length(files)
            expr_indx=1;
            for i=1:length(files)
                if ~isempty(regexp(string(files(i).name),'01.._','match'))
                    cc=read_vrml_coordinates(strcat(search_directory,'\'),files(i).name);
                    %display(files(i).name);
                    l=length(cc);
                    T(1:l,expr_indx,id_indx)=cc;
                    if(l<vertices)
                        j=l+1;
                        while j<=vertices-2
                            T(j,expr_indx,id_indx)=T(l-2,expr_indx,id_indx);
                            T(j+1,expr_indx,id_indx)=T(l-1,expr_indx,id_indx);
                            T(j+2,expr_indx,id_indx)=T(l,expr_indx,id_indx);
                            j=j+3;
                        end
                    end
                    expr_indx=expr_indx+1;
                end
                %files(i).name
            end
            id_indx=id_indx+1;
        end
    end
end