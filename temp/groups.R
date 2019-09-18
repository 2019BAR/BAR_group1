pacman::p_load(googlesheets, dplyr, stringr)
Q = gs_title("2019BAR期初問卷 (回應)") %>% gs_read() %>% setNames(c(
  'time','name','id','dept','tel','status','gsuite','g_datacamp','g_github',
  'prob','stat','econ','r','rStudio','dplyr','rmarkdown','github','python',
  'DataCamp','edX','Coursera','morning','afternoon','evening'))
sapply(Q[22:24], function(v){strsplit(v, ', ') %>% unlist %>% table}) %>% 
  {.[c(1:3,7,4:6),]} 

# check distribution
substr(Q$dept,1,2) %>% table %>% sort %>% data.frame
substr(Q$id,1,1) %>% table %>% sort %>% data.frame
table(Q$status)
table(Q$rStudio)

# random blocking
Q = Q %>% arrange(desc(r), desc(id))
g = replicate(8, sample(1:10)) %>% as.vector
Q$group = g[1:nrow(Q)]
select(Q, group, name, id, dept) %>% 
  arrange(group, id) %>% 
  write.table('clipboard',quote=F,sep='\t',row.names=F)

# check group balance
table(Q$group,Q$r)
table(Q$group,substr(Q$id,1,1))

##################
dir("G:/我的雲端硬碟/2019BAR/main/01課程簡介/AS01A_R語言導論") %>% 
  str_subset("pdf$") %>% str_remove("_.*$")
dir("G:/我的雲端硬碟/2019BAR/main/01課程簡介/AS01B_資料框整理技巧") %>% 
  str_subset("pdf$") %>% str_remove("_.*$")

