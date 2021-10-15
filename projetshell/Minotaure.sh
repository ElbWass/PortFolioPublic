#! /bin/bash
#0matrice

initialiser_mat()
{
	k=0


	for(( i=0;i<$H;i++ ))
	do
		for(( j=0;j<$L;j++ ))
		do
			if (( $i%2!=0 && $j%2!=0 ))
			then

				M[$i,$j]=$(($k))
				((k++))
			else
				M[$i,$j]=-1
			fi
		done
	done
}

afficher_mat()
{
	for(( i=0;i<$H;i++ ))
	do
		for(( j=0;j<$L;j++ ))
		do
			printf "%.d\t"${M[$i,$j]}
		done
		printf "\n"
	done

}

sortie()
{


	printf "$L $H:\033[30;47m" >$1
	for(( i=0;i<$H;i++ ))
	do
		for(( j=0;j<$L;j++ ))
		do
			if (( ${M[$i,$j]}!=-1 ))
			then
				if (( ${M[$i,$j]}==1 ))
				then
					printf "\033[34mD \033[30;47m" >>$1
				elif (( ${M[$i,$j]}==2 ))
				then
					printf "\033[35mT \033[30;47m" >>$1
				elif (( ${M[$i,$j]}==3 ))
				then
					printf "\033[31m🐮\033[30;47m" >>$1
				else
					printf "  " >>$1
				fi
			else
				printf "██" >>$1
			fi

		done
		printf ":" >>$1
	done
	printf "\033[0m" >>$1
}

etalement()
{
	for(( i=0;i<$H;i++ ))
	do
		for(( j=0;j<$L;j++ ))
		do
			if(( ${M[$i,$j]}==$1 ))
			then
				M[$i,$j]=$2
			fi
		done
	done

}

min()
{
	if(( $1>$2 ))
	then
		min=$2
	else
		min=$1
	fi

}

detruire_mur()
{
	min ${M[$x1,$y1]} ${M[$x2,$y2]}


	M[$x3,$y3]=$min

	if(( $min==${M[$x1,$y1]} ))
	then
		etalement ${M[$x2,$y2]} $min #transforme tout les case contenant ${M[$x2,$y2]} en $min
	else
		etalement ${M[$x1,$y1]} $min #transforme tout les case contenant ${M[$x1,$y1]} en $min
	fi

}

test_coord() # x y
{
	if(( $2<$L &&  $1<$H && $1>0 && $2>0 && $1%2!=0 && $2%2!=0))
	then
		return 0
	fi
	return 1
}

detruire_case()
{
	x1=1
	y1=1
	x2=1
	y2=1
	x3=0
	y3=0

	while(( ${M[$x3,$y3]}!=-1 || ${M[$x1,$y1]} == ${M[$x2,$y2]} )) #ajouter le test sur les chiffre
	do

		x1=$((($RANDOM%(($H-1)/2))*2+1))
		y1=$((($RANDOM%(($L-1)/2))*2+1))

		x2=$x1
		y2=$y1

		case $(($RANDOM%4)) in
			0) x2=$(($x1+2));; # bas
			1) x2=$(($x1-2));; # haut
			2) y2=$(($y1+2));; # droite
			3) y2=$(($y1-2));; # gauche
		esac

		x3=$((($x1+$x2)/2))
		y3=$((($y1+$y2)/2))

		test_coord $x2 $y2 #pour detruire que les mur interieur. si en fait le test x3 y3 en peut detruire les mure exterieur

		if(( $?==1 ))
		then
			x2=$x1
			y2=$y1
		fi
	done

}

detruire_fin()
{
	for(( a=0;$a<$H;a++ ))
	do
		for(( b=0;$b<$L;b++ ))
		do
			if(( $a%2!=0 && $b%2!=0 && ${M[$a,$b]}!=0 ))
			then
				return 0
			fi
		done
	done

	return 1
}

creer_labyrinthe()
{
	initialiser_mat
	detruire_fin
	while(( $?!=1 ))
	do
		detruire_case
		detruire_mur
		detruire_fin
	done

	sortie $1
}


#0
#1generlaby
creer_niveau()
{
	w=0

	if [[ -e  "l_labyrinthe" ]]
	then
		rm -r "l_labyrinthe"
	fi

	mkdir "l_labyrinthe"

	for(( v=1;v<11;v=$v+2 ))
	do
		L=$((20+$v))
		H=$((10+$v))

		creer_labyrinthe "./l_labyrinthe/niv$w"

		((w++))
	done

}

afficher_liste_niveaux()
{
	resize -s 40 150




min()
{
	if(( $1>$2 ))
	then
		min=$2
	else
		min=$1
	fi

}

detruire_mur()
{
	min ${M[$x1,$y1]} ${M[$x2,$y2]}


	M[$x3,$y3]=$min

	if(( $min==${M[$x1,$y1]} ))
	then
		etalement ${M[$x2,$y2]} $min #transforme tout les case contenant ${M[$x2,$y2]} en $min
	else
		etalement ${M[$x1,$y1]} $min #transforme tout les case contenant ${M[$x1,$y1]} en $min
	fi

}

test_coord() # x y
{
	if(( $2<$L &&  $1<$H && $1>0 && $2>0 && $1%2!=0 && $2%2!=0))
	then
		return 0
	fi
	return 1
}

detruire_case()
{
	x1=1
	y1=1
	x2=1
	y2=1
	x3=0
	y3=0

	while(( ${M[$x3,$y3]}!=-1 || ${M[$x1,$y1]} == ${M[$x2,$y2]} )) #ajouter le test sur les chiffre
	do

		x1=$((($RANDOM%(($H-1)/2))*2+1))
		y1=$((($RANDOM%(($L-1)/2))*2+1))

		x2=$x1
		y2=$y1

		case $(($RANDOM%4)) in
			0) x2=$(($x1+2));; # bas
			1) x2=$(($x1-2));; # haut
			2) y2=$(($y1+2));; # droite
			3) y2=$(($y1-2));; # gauche
		esac

		x3=$((($x1+$x2)/2))
		y3=$((($y1+$y2)/2))

		test_coord $x2 $y2 #pour detruire que les mur interieur. si en fait le test x3 y3 en peut detruire les mure exterieur

		if(( $?==1 ))
		then
			x2=$x1
			y2=$y1
		fi
	done

}

detruire_fin()
{
	for(( a=0;$a<$H;a++ ))
	do
		for(( b=0;$b<$L;b++ ))
		do
			if(( $a%2!=0 && $b%2!=0 && ${M[$a,$b]}!=0 ))
			then
				return 0
			fi
		done
	done

	return 1
}





	clear


	printf "\033[38;52H\033[30m < Choisissez votre labyrinthe avec Q & D >\n\033[m"

	awk -f lv_gen.awk "l_labyrinthe/niv$1"

}

choisir_niveaux()
{
	_NIVEAU=0
	_KEY=a

	while [[ $_KEY != "" ]]
	do
		afficher_liste_niveaux $_NIVEAU

		read -s -n 1 _KEY

		case $_KEY in
			"D" | "d") (( _NIVEAU++ ))
					if (( $_NIVEAU==5 ))
					then
						_NIVEAU=0
					fi ;;
			"Q" | "q") (( _NIVEAU-- ))
					if (( $_NIVEAU==-1 ))
					then
						_NIVEAU=4
					fi ;;
		esac


	done


}

#1
#2menu
menu()
{

	printf "\n\n	██████████████████████████████████████████████\n"
printf "\033[$1m	██                 Jouer                    ██\033[0m\n"
printf "\033[$2m	██                Quitter                   ██\033[0m\n"
	printf "	██████████████████████████████████████████████\n"
	printf "	██Commande :				    ██\n"
	printf "	██                Z = Haut                  ██\n"
	printf "	██                Q = Gauche                ██\n"
	printf "	██                S = Bas                   ██\n"
	printf "	██                D = Droite                ██\n"
	printf "	██████████████████████████████████████████████\n"
}

afficher_menu()
{
	_choix="a"
	_select=1

	resize -s 18 105
	clear
	menu 47 0

	while [[ $_choix != "" ]]
	do

		read -s -n 1 _choix

		case $_choix in
			"z") ((_select--))
				if(( $_select<=0 ))
				then
					_select=2
				fi
			;;
			"s") ((_select++))
				if(( $_select>2 ))
				then
					_select=1
				fi
			;;
		esac

		case $_select in
			1) clear;menu 47 0 ;;
			2) clear;menu 0 47 ;;
		esac

	done

	if (( $_select==2 ))
	then
		exit
	fi
}

Attente()
{
	resize -s 18 105

	clear

	_cmp=`ls l_labyrinthe/ | wc -w`

	q=0
	_C=40

	printf "\033[8;44H\033[30m Votre labyrinthe est en cours de construction... (Cela peut durer jusqu'à 30 secondes) \033[m\n"

	while (( $_cmp < 5 ))
	do


		_cmp=`ls l_labyrinthe/ | wc -w`
	done

}

#2
#3partie
declare -a temp


import_niveaux()
{
	if [[ -e  "partie" ]]
	then
		rm -r "partie"
	fi

	mkdir partie

	ifs=$IFS

	IFS=":"

	read -a temp <l_labyrinthe/niv$_NIVEAU



	L=${temp[0]:0:2}
	H=${temp[0]:2:4}

	for (( i=1;i<=$H;i++ ))
	do
		for (( j=0;j<=(2*$L);j+=2 ))
		do
			if [[ ${temp[$i]:$j:2} != "  " ]]
			then
				M[$(($i-1)),$(($j/2))]=-1
			else
				M[$(($i-1)),$(($j/2))]=0
			fi
		done
	done
	IFS="$ifs"

	sortie partie/niv$_NIVEAU
}

creer_sotrie()
{

	sortie_x=0
	sortie_y=0

	case $(( $RANDOM%4 )) in
		0)	sortie_x=0
			sortie_y=$(( ($RANDOM%(($L-1)/2))*2+1 ))
			;;
		1)	sortie_x=$(( $H-1 ))
			sortie_y=$(( ($RANDOM%(($L-1)/2))*2+1 ))
			;;
		2)	sortie_x=$(( ($RANDOM%(($H-1)/2))*2+1 ))
			sortie_y=0
			;;
		3)	sortie_x=$(( ($RANDOM%(($H-1)/2))*2+1 ))
			sortie_y=$(( $L-1 ))
			;;
		esac

	M[$sortie_x,$sortie_y]=0

	sortie partie/niv$_NIVEAU


}

placer_personnage()
{
	Dedale_x=$sortie_x
	Dedale_y=$sortie_y

	Minotaure_x=$(( ($RANDOM%(($H-1)/2))*2+1 ))
	Minotaure_y=$(( ($RANDOM%(($L-1)/2))*2+1 ))


	Thesee_x=$Minotaure_x
	Thesee_y=$Minotaure_y


	def_x=0
	def_y=0

	while (( $def_x < 5 || $def_y < 10 ))
	do

		def_x=$(($Thesee_x-$Minotaure_x))
		def_y=$(($Thesee_y-$Minotaure_y))

		if (( $def_x < 0 ))
		then
			def_x=$(( -1*$def_x ))
		fi


		if (( $def_y < 0 ))
		then
			def_y=$(( -1*$def_y ))
		fi

		Thesee_x=$(( ($RANDOM%(($H-1)/2))*2+1 ))
		Thesee_y=$(( ($RANDOM%(($L-1)/2))*2+1 ))
	done

	M[$Dedale_x,$Dedale_y]=1
	M[$Thesee_x,$Thesee_y]=2
	M[$Minotaure_x,$Minotaure_y]=3

	sortie partie/niv$_NIVEAU

}

creer_partie()
{
	import_niveaux

	creer_sotrie

	placer_personnage


}

test_fin_partie()
{

	test_fin_x=$(( $Dedale_x-$Minotaure_x ))
	test_fin_y=$(( $Dedale_y-$Minotaure_y ))

	if (( $test_fin_x < 0 ))
	then
		test_fin_x=$(( -1*$test_fin_x ))
	fi

	if (( $test_fin_y < 0 ))
	then
		test_fin_y=$(( -1*$test_fin_y ))
	fi



	if (( ( $test_fin_x==0 && $test_fin_y==1 ) || ( $test_fin_x==1 && $test_fin_y==0 ) ))
	then
		printf "Perdu\n"
		return 0
	fi




	test_fin_x=$(( $Thesee_x-$Minotaure_x ))
	test_fin_y=$(( $Thesee_y-$Minotaure_y ))

	if (( $test_fin_x < 0 ))
	then
		test_fin_x=$(( -1*$test_fin_x ))
	fi

	if (( $test_fin_y < 0 ))
	then
		test_fin_y=$(( -1*$test_fin_y ))
	fi

	if (( ( $test_fin_x==0 && $test_fin_y==1 ) || ( $test_fin_x==1 && $test_fin_y==0 ) ))
	then
		printf "Perdu\n"
		return 0
	fi




	test_fin_x=$(( $Thesee_x-$Dedale_x ))
	test_fin_y=$(( $Thesee_y-$Dedale_y ))

	if (( $test_fin_x < 0 ))
	then
		test_fin_x=$(( -1*$test_fin_x ))
	fi

	if (( $test_fin_y < 0 ))
	then
		test_fin_y=$(( -1*$test_fin_y ))
	fi


	if (( ( $test_fin_x==0 && $test_fin_y==1 ) || ( $test_fin_x==1 && $test_fin_y==0 ) ))
	then
		printf "Gagné\n"
		return 2
	fi


	return 1

}



#3
#4deplacement
dep_dedale()
{
	dep_d=a


	while [[ $dep_d != [zZqQsSdD] ]]
	do
		read -s -n 1 dep_d
	done

	case $dep_d in
		"z" | "Z")
				if (( ${M[$(( $Dedale_x-1 )),$Dedale_y]} == 0 ))
				then
					M[$(( $Dedale_x-1 )),$Dedale_y]=1
					M[$Dedale_x,$Dedale_y]=0
					(( Dedale_x-- ))
				fi
			;;
		"s" | "S")
				if (( ${M[$(( $Dedale_x+1 )),$Dedale_y]} == 0 ))
				then
					M[$(( $Dedale_x+1 )),$Dedale_y]=1
					M[$Dedale_x,$Dedale_y]=0
					(( Dedale_x++ ))
				fi
			;;
		"q" | "Q")
				if (( ${M[$Dedale_x,$(( $Dedale_y-1 ))]} == 0 ))
				then
					M[$Dedale_x,$(( $Dedale_y-1 ))]=1
					M[$Dedale_x,$Dedale_y]=0
					(( Dedale_y-- ))
				fi
			;;
		"d" | "D")
				if (( ${M[$Dedale_x,$(( $Dedale_y+1 ))]} == 0 ))
				then
					M[$Dedale_x,$(( $Dedale_y+1 ))]=1
					M[$Dedale_x,$Dedale_y]=0
					(( Dedale_y++ ))
				fi
			;;
	esac

	sortie partie/niv$_NIVEAU
}

dep_minotaure()
{
	dep_m=a
	dep_init_m=a
	bool=0

	#mov="printf \"\033[%.d;%.dH\033[31m%s\033[0m\" $(( (41-$H)/2+$Minotaure_x )) $(( (150/2)-$L+$Minotaure_y ))"

	Minotaure_init_x=$Minotaure_x
	Minotaure_init_y=$Minotaure_y

	while (( $Minotaure_x == $Minotaure_init_x &&  $Minotaure_init_y == $Minotaure_y && $bool == 0 ))
	do
		bool=0

		case $(( $RANDOM%6 )) in
			4 | 0)
				dep_m=z
			;;
			1)
				dep_m=s
			;;
			5 | 2)
				dep_m=q
			;;
			3)
				dep_m=d
			;;
		esac

		case $dep_m in
			"z")

					if [[ $dep_init_t != "s" ]]
					then
						bool=1
					fi

					if (( ${M[$(( $Minotaure_x-1 )),$Minotaure_y]} == 0 && $bool != 0 ))
					then
						M[$(( $Minotaure_x-1 )),$Minotaure_y]=3
						M[$Minotaure_x,$Minotaure_y]=0
						(( Minotaure_x-- ))
					fi
				;;
			"s")

					if [[ $dep_init_t != "z" ]]
					then
						bool=1
					fi

					if (( ${M[$(( $Minotaure_x+1 )),$Minotaure_y]} == 0 && $bool != 0 ))
					then
						M[$(( $Minotaure_x+1 )),$Minotaure_y]=3
						M[$Minotaure_x,$Minotaure_y]=0
						(( Minotaure_x++ ))
					fi
				;;
			"q")

					if [[ $dep_init_t != "d" ]]
					then
						bool=1
					fi

					if (( ${M[$Minotaure_x,$(( $Minotaure_y-1 ))]} == 0 && $bool != 0))
					then
						M[$Minotaure_x,$(( $Minotaure_y-1 ))]=3
						M[$Minotaure_x,$Minotaure_y]=0
						(( Minotaure_y-- ))
					fi
				;;
			"d")

					if [[ $dep_init_t != "q" ]]
					then
						bool=1
					fi

					if (( ${M[$Minotaure_x,$(( $Minotaure_y+1 ))]} == 0 && $bool != 0 ))
					then
						M[$Minotaure_x,$(( $Minotaure_y+1 ))]=3
						M[$Minotaure_x,$Minotaure_y]=0
						(( Minotaure_y++ ))
					fi
				;;
		esac

		dep_init_t=$dep_t

	done



}

dep_thesee()
{
	dep_t="a"
	dep_init_t="a"
	bool=0

	Thesee_init_x=$Thesee_x
	Thesee_init_y=$Thesee_y

	while (( $Thesee_x == $Thesee_init_x &&  $Thesee_init_y == $Thesee_y && $bool == 0 ))
	do

		bool=0

		case $(( $RANDOM%6 )) in
			4 | 0)
				dep_t=z
			;;
			1)
				dep_t=s
			;;
			5 | 2)
				dep_t=q
			;;
			3)
				dep_t=d
			;;
		esac

		case $dep_t in
			"z")
					if [[ $dep_init_t != "s" ]]
					then
						bool=1
					fi

					if (( ${M[$(( $Thesee_x-1 )),$Thesee_y]} == 0 && $bool != 0 ))
					then
						M[$(( $Thesee_x-1 )),$Thesee_y]=2
						M[$Thesee_x,$Thesee_y]=0
						(( Thesee_x-- ))
					fi
				;;
			"s")

					if [[ $dep_init_t != "z" ]]
					then
						bool=1
					fi


					if (( ${M[$(( $Thesee_x+1 )),$Thesee_y]} == 0 && $bool != 0 ))
					then
						M[$(( $Thesee_x+1 )),$Thesee_y]=2
						M[$Thesee_x,$Thesee_y]=0
						(( Thesee_x++ ))
					fi
				;;
			"q")

					if [[ $dep_init_t != "d" ]]
					then
						bool=1
					fi

					if (( ${M[$Thesee_x,$(( $Thesee_y-1 ))]} == 0 && $bool != 0 ))
					then
						M[$Thesee_x,$(( $Thesee_y-1 ))]=2
						M[$Thesee_x,$Thesee_y]=0
						(( Thesee_y-- ))
					fi
				;;
			"d")

					if [[ $dep_init_t != "q" ]]
					then
						bool=1
					fi

					if (( ${M[$Thesee_x,$(( $Thesee_y+1 ))]} == 0 && $bool != 0 ))
					then
						M[$Thesee_x,$(( $Thesee_y+1 ))]=2
						M[$Thesee_x,$Thesee_y]=0
						(( Thesee_y++ ))
					fi
				;;
		esac

		dep_init_t=$dep_t
	done



}
#4jouer

declare -A M




afficher_menu

creer_niveau &

Attente

choisir_niveaux

creer_partie

clear


awk -f lv_gen.awk "partie/niv$_NIVEAU"



test_fin_partie


while (( $? != 0 && $? != 2 ))
do


	#printf "%d;%d\n" $Minotaure_x $((75-$L+$Minotaure_y))

	dep_minotaure
	#printf "\033[%d;%dH12" $Minotaure_x $((75-$L+$Minotaure_y))

	printf "La partie commence !\n"

	dep_thesee

	dep_dedale

	clear

	awk -f lv_gen.awk "partie/niv$_NIVEAU"
	test_fin_partie



done
