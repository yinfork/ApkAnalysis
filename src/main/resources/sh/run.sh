#!/bin/bash
if [ ! -n "$1" ] 
  	then   
	  	echo "请输入工作路径!"
		echo "请输入工作路径!" >> $global_log_file
		echo "请输入工作路径!" >> $simple_log_file
		exit
  	else	
  		root_path=$1
fi

sh_path=$(cd `dirname $0`; pwd)"/"
input_path=${root_path}"input/"
output_path=${root_path}"output/"
log_path=${root_path}"log/"

cur_time=$(date +%Y%m%d%H%M%S)
global_log_file=${log_path}"analyze_apks_"${cur_time}"_global.log"
simple_log_file=${log_path}"analyze_apks_"${cur_time}"_simple.log"


#生成log文件夹
if [ ! -d $log_path ]
	then
	mkdir $log_path
fi

echo "=================================================="
echo "==================================================" >> $global_log_file
echo "==================================================" >> $simple_log_file


#如果不存在input文件夹 则直接退出
if [ ! -d $input_path ]
	then
	echo "没检测到Input文件夹 退出!"
	echo "没检测到Input文件夹 退出!" >> $global_log_file
	echo "没检测到Input文件夹 退出!" >> $simple_log_file
	exit
fi

#生成output文件夹
if [ ! -d $output_path ]
	then
	mkdir $output_path
fi


# 获取输入文件的相对路径
cd $input_path
filelist=$(find . -name *.apk)
cd $root_path


for file in $filelist
do
	echo "检测到文件: $file ..."
	echo "检测到文件: $file ..." >> $global_log_file
	echo "检测到文件: $file ..." >> $simple_log_file

	if [ -d ${output_path}${file}"_output" ]
	then
		echo ${file}"文件已检测!"
		echo ${file}"文件已检测!" >> $global_log_file
		echo ${file}"文件已检测!" >> $simple_log_file
	else
		echo ${file}"文件未检测，现开始检测"
		echo ${file}"文件未检测，现开始检测" >> $global_log_file
		echo ${file}"文件未检测，现开始检测" >> $simple_log_file

		# 创建输出文件夹
		mkdir -p ${output_path}"${file}"_output
		# 创建输出的代码文件夹
		mkdir -p ${output_path}"${file}"_output/code
		# 创建输出的so文件夹
		mkdir -p ${output_path}"${file}"_output/so
		# 创建输出的res文件夹
		mkdir -p ${output_path}"${file}"_output/res
		# 创建输出的assets文件夹
		mkdir -p ${output_path}"${file}"_output/assets
		# 创建输出的AndroidManifest文件夹
		mkdir -p ${output_path}"${file}"_output/AndroidManifest.xml
		# 创建输出的META-INF文件夹
		mkdir -p ${output_path}"${file}"_output/META-INF
		# 创建输出的resources.arsc文件夹
		mkdir -p ${output_path}"${file}"_output/resources.arsc

		# 创建输出的临时文件夹
		mkdir -p ${output_path}"${file}"_tmp
		
		echo "开始解压:"${file}
		echo "开始解压:"${file} >> $global_log_file
		unzip ${input_path}${file} -d ${output_path}${file}"_tmp" >> $global_log_file
		echo "解压完成:"${file}
		echo "解压完成:"${file} >> $global_log_file

		echo "开始把dex转jar:"${file}
		echo "开始把dex转jar:"${file} >> $global_log_file
		cp ${output_path}"${file}"_tmp/*.dex ${output_path}"${file}"_output/code/
		sh ${sh_path}"dex2jar.sh" ${output_path}"${file}"_output/code/*.dex >> $global_log_file
		rm ${output_path}"${file}"_output/code/*.dex
		echo "dex转jar完成:"${file}
		echo "dex转jar完成:"${file} >> $global_log_file

		echo "开始把jar转class:"${file}
		echo "开始把jar转class:"${file} >> $global_log_file
		cd ${output_path}"${file}"_output/code/
		find *.jar -exec jar -xvf {} \; >> ${global_log_file}
		rm *.jar
		cd $root_path
		echo "jar转dex完成:"${file}
		echo "jar转dex完成:"${file} >> $global_log_file

		echo "开始复制各类文件:"${file}
		echo "开始复制各类文件:"${file} >> $global_log_file
		cp -r ${output_path}"${file}"_tmp/lib/ ${output_path}"${file}"_output/so/
		cp -r ${output_path}"${file}"_tmp/res/ ${output_path}"${file}"_output/res/
		cp -r ${output_path}"${file}"_tmp/assets/ ${output_path}"${file}"_output/assets/
		cp -r ${output_path}"${file}"_tmp/META-INF/ ${output_path}"${file}"_output/META-INF/
		cp ${output_path}"${file}"_tmp/AndroidManifest.xml ${output_path}"${file}"_output/AndroidManifest.xml/
		cp ${output_path}"${file}"_tmp/resources.arsc ${output_path}"${file}"_output/resources.arsc/
		echo "复制各类文件完成:"${file}
		echo "复制各类文件完成:"${file} >> $global_log_file


		echo "开始清除临时文件夹:"${file}
		echo "开始清除临时文件夹:"${file} >> $global_log_file
		rm -rf ${output_path}${file}"_tmp"
		echo "清除临时文件夹完成:"${file}
		echo "清除临时文件夹完成:"${file} >> $global_log_file


		echo "开始统计"${file}"各目录大小:"
		echo "开始统计"${file}"各目录大小:" >> $global_log_file
		echo "开始统计"${file}"各目录大小:" >> $simple_log_file

		
		apk_k_size=$(du -sk ${input_path}${file} | awk '{print $1}')
		output_k_count_size=$(du -sk ${output_path}"${file}"_output/ | awk '{print $1}')
		code_k_size=$(du -sk ${output_path}"${file}"_output/code/ | awk '{print $1}')
		so_k_size=$(du -sk ${output_path}"${file}"_output/so/ | awk '{print $1}')
		res_k_size=$(du -sk ${output_path}"${file}"_output/res/ | awk '{print $1}')
		assets_k_size=$(du -sk ${output_path}"${file}"_output/assets/ | awk '{print $1}')
		META_INF_k_size=$(du -sk ${output_path}"${file}"_output/META-INF/ | awk '{print $1}')
		AndroidManifest_xml_k_size=$(du -sk ${output_path}"${file}"_output/AndroidManifest.xml/ | awk '{print $1}')
		resources_arsc_k_size=$(du -sk ${output_path}"${file}"_output/resources.arsc/ | awk '{print $1}')

		mb_size=1024
		apk_m_size=$(awk 'BEGIN{printf "%.2f\n",('$apk_k_size'/'$mb_size')}')
		output_m_count_size=$(awk 'BEGIN{printf "%.2f\n",('$output_k_count_size'/'$mb_size')}')
		code_m_size=$(awk 'BEGIN{printf "%.2f\n",('$code_k_size'/'$mb_size')}')
		so_m_size=$(awk 'BEGIN{printf "%.2f\n",('$so_k_size'/'$mb_size')}')
		res_m_size=$(awk 'BEGIN{printf "%.2f\n",('$res_k_size'/'$mb_size')}')
		assets_m_size=$(awk 'BEGIN{printf "%.2f\n",('$assets_k_size'/'$mb_size')}')
		META_INF_m_size=$(awk 'BEGIN{printf "%.2f\n",('$META_INF_k_size'/'$mb_size')}')
		AndroidManifest_xml_m_size=$(awk 'BEGIN{printf "%.2f\n",('$AndroidManifest_xml_k_size'/'$mb_size')}')
		resources_arsc_m_size=$(awk 'BEGIN{printf "%.2f\n",('$resources_arsc_k_size'/'$mb_size')}')


		echo "apk_size: "${apk_m_size}"MB "${apk_k_size}"KB"
		echo "output_count_size: "${output_m_count_size}"MB "${output_k_count_size}"KB"
		echo "code_size: "${code_m_size}"MB "${code_k_size}"KB"
		echo "so_size: "${so_m_size}"MB "${so_k_size}"KB"
		echo "res_size: "${res_m_size}"MB "${res_k_size}"KB"
		echo "assets_size: "${assets_m_size}"MB "${assets_k_size}"KB"
		echo "META-INF_size: "${META_INF_m_size}"MB "${META_INF_k_size}"KB"
		echo "AndroidManifest.xml_size: "${AndroidManifest_xml_m_size}"MB "${AndroidManifest_xml_k_size}"KB"
		echo "resources.arsc_size: "${resources_arsc_m_size}"MB "${resources_arsc_k_size}"KB"

		echo "apk_size: "${apk_m_size}"MB "${apk_k_size}"KB" >> $global_log_file
		echo "output_count_size: "${output_m_count_size}"MB "${output_k_count_size}"KB" >> $global_log_file
		echo "code_size: "${code_m_size}"MB "${code_k_size}"KB" >> $global_log_file
		echo "so_size: "${so_m_size}"MB "${so_k_size}"KB" >> $global_log_file
		echo "res_size: "${res_m_size}"MB "${res_k_size}"KB" >> $global_log_file
		echo "assets_size: "${assets_m_size}"MB "${assets_k_size}"KB" >> $global_log_file
		echo "META-INF_size: "${META_INF_m_size}"MB "${META_INF_k_size}"KB" >> $global_log_file
		echo "AndroidManifest.xml_size: "${AndroidManifest_xml_m_size}"MB "${AndroidManifest_xml_k_size}"KB" >> $global_log_file
		echo "resources.arsc_size: "${resources_arsc_m_size}"MB "${resources_arsc_k_size}"KB" >> $global_log_file

		echo "apk_size: "${apk_m_size}"MB "${apk_k_size}"KB" >> $simple_log_file
		echo "output_count_size: "${output_m_count_size}"MB "${output_k_count_size}"KB" >> $simple_log_file
		echo "code_size: "${code_m_size}"MB "${code_k_size}"KB" >> $simple_log_file
		echo "so_size: "${so_m_size}"MB "${so_k_size}"KB" >> $simple_log_file
		echo "res_size: "${res_m_size}"MB "${res_k_size}"KB" >> $simple_log_file
		echo "assets_size: "${assets_m_size}"MB "${assets_k_size}"KB" >> $simple_log_file
		echo "META-INF_size: "${META_INF_m_size}"MB "${META_INF_k_size}"KB" >> $simple_log_file
		echo "AndroidManifest.xml_size: "${AndroidManifest_xml_m_size}"MB "${AndroidManifest_xml_k_size}"KB" >> $simple_log_file
		echo "resources.arsc_size: "${resources_arsc_m_size}"MB "${resources_arsc_k_size}"KB" >> $simple_log_file

		echo "统计"${file}"各目录大小完成"
		echo "统计"${file}"各目录大小完成" >> $global_log_file
		echo "统计"${file}"各目录大小完成" >> $simple_log_file

		echo "文件检测完成"${file}
		echo "文件检测完成"${file} >> $global_log_file
		echo "文件检测完成"${file} >> $simple_log_file

		echo "=================================================="
		echo "==================================================" >> $global_log_file
		echo "==================================================" >> $simple_log_file
	fi
done