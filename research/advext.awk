BEGIN{FS="\t"; ALIAS["Daimonion"]="Daimoinon"; ALIAS["Quietus Hematus"]="Quietus"; ALIAS["Quietus Cruscitus"]="Quietus"}
NR==FNR{ D[$0]=1; next }
{
  t=$2
  h=t; sub(/^Advanced /,"",h)
  if (h in ALIAS) h=ALIAS[h]
  if ((h in D) && length(t)<40) { cur=h; next }
  if (t ~ /^[*][*][*][*][*][* ]*[*][ ]+[A-Z]/) {
     n=0; i=1
     while (i<=length(t) && substr(t,i,1) ~ /[* ]/) { if (substr(t,i,1)=="*") n++; i++ }
     name=substr(t,i)
     if (n>=6 && n<=9 && cur!="" && length(name)>2 && length(name)<50)
        print cur "\t" n "\t" name "\t" $1
  }
}
