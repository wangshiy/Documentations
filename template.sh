read -p "What is the index?" n 
read -p "What is the question number on leetcode?" i
read -p "What is the question url?" url
read -p "What is the title for this question?" title
read -p "What is the content for this question?" content
read -p "What is the filename to insert the template?" filename
result="\n#### $n. [Leetcode#$i]($url) $title ?\n- $content\n\`\`\`javascript\n\`\`\`"
echo $result >> $filename
echo "succeed!"