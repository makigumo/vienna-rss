FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��
    Vienna to Mastodon.scpt
    Vienna plug in
  
    Created by Barijaona Ramaholimihaso on April 20th, 2025
    Copyright (c) 2025 Barijaona Ramaholimihaso. All rights reserved.
  
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
  
    http://www.apache.org/licenses/LICENSE-2.0
  
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
      � 	 	� 
         V i e n n a   t o   M a s t o d o n . s c p t 
         V i e n n a   p l u g   i n 
     
         C r e a t e d   b y   B a r i j a o n a   R a m a h o l i m i h a s o   o n   A p r i l   2 0 t h ,   2 0 2 5 
         C o p y r i g h t   ( c )   2 0 2 5   B a r i j a o n a   R a m a h o l i m i h a s o .   A l l   r i g h t s   r e s e r v e d . 
     
         L i c e n s e d   u n d e r   t h e   A p a c h e   L i c e n s e ,   V e r s i o n   2 . 0   ( t h e   " L i c e n s e " ) ; 
         y o u   m a y   n o t   u s e   t h i s   f i l e   e x c e p t   i n   c o m p l i a n c e   w i t h   t h e   L i c e n s e . 
         Y o u   m a y   o b t a i n   a   c o p y   o f   t h e   L i c e n s e   a t 
     
         h t t p : / / w w w . a p a c h e . o r g / l i c e n s e s / L I C E N S E - 2 . 0 
     
         U n l e s s   r e q u i r e d   b y   a p p l i c a b l e   l a w   o r   a g r e e d   t o   i n   w r i t i n g ,   s o f t w a r e 
         d i s t r i b u t e d   u n d e r   t h e   L i c e n s e   i s   d i s t r i b u t e d   o n   a n   " A S   I S "   B A S I S , 
         W I T H O U T   W A R R A N T I E S   O R   C O N D I T I O N S   O F   A N Y   K I N D ,   e i t h e r   e x p r e s s   o r   i m p l i e d . 
         S e e   t h e   L i c e n s e   f o r   t h e   s p e c i f i c   l a n g u a g e   g o v e r n i n g   p e r m i s s i o n s   a n d 
         l i m i t a t i o n s   u n d e r   t h e   L i c e n s e . 
     
  
 l     ��������  ��  ��        l      ��  ��    r l
	you can modify the server which will be used
	by launching the plug-in while pressing the Option/Alt key
      �   � 
 	 y o u   c a n   m o d i f y   t h e   s e r v e r   w h i c h   w i l l   b e   u s e d 
 	 b y   l a u n c h i n g   t h e   p l u g - i n   w h i l e   p r e s s i n g   t h e   O p t i o n / A l t   k e y 
        l     ��������  ��  ��        l          j     �� �� 0 prefkey prefKey  m        �   . M a s t o d o n P l u g i n S e r v e r U R L  D > identifier used by this particular plugin in preferences file     �   |   i d e n t i f i e r   u s e d   b y   t h i s   p a r t i c u l a r   p l u g i n   i n   p r e f e r e n c e s   f i l e      l           j    �� !�� $0 defaultserverurl defaultServerURL ! m     " " � # # & h t t p s : / / e x a m p l e . o r g  W Q an example to show as a placeholder, instead of the conventional mastodon.social      � $ $ �   a n   e x a m p l e   t o   s h o w   a s   a   p l a c e h o l d e r ,   i n s t e a d   o f   t h e   c o n v e n t i o n a l   m a s t o d o n . s o c i a l   % & % j    �� '�� &0 selectedserverurl selectedServerURL ' m    ��
�� 
msng &  ( ) ( l     ��������  ��  ��   )  * + * x   	 �� ,����   , 2  
 ��
�� 
osax��   +  - . - l      / 0 1 / x     �� 2����   2 4    �� 3
�� 
frmk 3 m     4 4 � 5 5  F o u n d a t i o n��   0   for NSEvent    1 � 6 6    f o r   N S E v e n t .  7 8 7 l     ��������  ��  ��   8  9 : 9 l      �� ; <��   ; D > returns 'true' if the Option key is pressed during execution     < � = = |   r e t u r n s   ' t r u e '   i f   t h e   O p t i o n   k e y   i s   p r e s s e d   d u r i n g   e x e c u t i o n   :  > ? > i     # @ A @ I      �������� (0 isoptionkeypressed isOptionKeyPressed��  ��   A k      B B  C D C r      E F E ?      G H G l     I���� I `      J K J l     L���� L _      M N M l     O���� O n     P Q P I    �������� 0 modifierflags modifierFlags��  ��   Q n     R S R o    ���� 0 nsevent NSEvent S m     ��
�� misccura��  ��   N l 	   T���� T l    U���� U c     V W V n   
 X Y X o    
���� 60 nseventmodifierflagoption NSEventModifierFlagOption Y m    ��
�� misccura W m   
 ��
�� 
long��  ��  ��  ��  ��  ��   K m    ���� ��  ��   H m    ����   F o      ���� 0 optionkeystat optionKeyStat D  Z�� Z L     [ [ o    ���� 0 optionkeystat optionKeyStat��   ?  \ ] \ l     ��������  ��  ��   ]  ^ _ ^ l      �� ` a��   ` . ( retrieve / store into Preferences file     a � b b P   r e t r i e v e   /   s t o r e   i n t o   P r e f e r e n c e s   f i l e   _  c d c i   $ ' e f e I      �������� 	0 setup  ��  ��   f k     � g g  h i h r      j k j c      l m l n      n o n 1    ��
�� 
ID   o m      p p�                                                                                  Vnna  alis    �  Macintosh HD               ���BD ����
Vienna.app                                                     �����)~�        ����  
 cu             Development   J/:Users:barijaon:gitdirs:vienna-rss:Build:Products:Development:Vienna.app/   
 V i e n n a . a p p    M a c i n t o s h   H D  GUsers/barijaon/gitdirs/vienna-rss/Build/Products/Development/Vienna.app   /    ��   m m    ��
�� 
TEXT k o      ���� 0 appid appID i  q r q l   �� s t��   s * $ retrieve current setup if available    t � u u H   r e t r i e v e   c u r r e n t   s e t u p   i f   a v a i l a b l e r  v w v Q    ; x y z x k    $ { {  | } | r      ~  ~ I   �� ���
�� .sysoexecTEXT���     TEXT � b     � � � b     � � � b     � � � m     � � � � �  d e f a u l t s   r e a d   � o    ���� 0 appid appID � m     � � � � �    � o    ���� 0 prefkey prefKey��    o      ���� &0 selectedserverurl selectedServerURL }  ��� � r   ! $ � � � m   ! "��
�� boovfals � o      ���� 0 	needsetup 	needSetup��   y R      ������
�� .ascrerr ****      � ****��  ��   z k   , ; � �  � � � r   , 7 � � � o   , 1���� $0 defaultserverurl defaultServerURL � o      ���� &0 selectedserverurl selectedServerURL �  ��� � r   8 ; � � � m   8 9��
�� boovtrue � o      ���� 0 	needsetup 	needSetup��   w  � � � l  < <��������  ��  ��   �  � � � Z   < � � ����� � G   < G � � � o   < =���� 0 	needsetup 	needSetup � I   @ E�������� (0 isoptionkeypressed isOptionKeyPressed��  ��   � Q   J � � � � � l  M � � � � � k   M � � �  � � � r   M Z � � � l  M X ����� � I  M X�� � �
�� .sysodlogaskr        TEXT � m   M N � � � � � R W h a t   i s   t h e   U R L   o f   y o u r   M a s t o d o n   s e r v e r   ? � �� ���
�� 
dtxt � o   O T���� &0 selectedserverurl selectedServerURL��  ��  ��   � o      ���� 0 	theanswer 	theAnswer �  ��� � Z   [ � � ����� � l  [ ` ����� � =  [ ` � � � n   [ ^ � � � 1   \ ^��
�� 
bhit � o   [ \���� 0 	theanswer 	theAnswer � m   ^ _ � � � � �  O K��  ��   � k   c � � �  � � � r   c l � � � n   c f � � � 1   d f��
�� 
ttxt � o   c d���� 0 	theanswer 	theAnswer � o      ���� &0 selectedserverurl selectedServerURL �  ��� � I  m ��� ���
�� .sysoexecTEXT���     TEXT � b   m � � � � b   m � � � � b   m � � � � b   m | � � � b   m v � � � b   m r � � � m   m p � � � � �  d e f a u l t s   w r i t e   � o   p q���� 0 appid appID � m   r u � � � � �    � o   v {���� 0 prefkey prefKey � m   |  � � � � �    ' � l  � � ����� � c   � � � � � o   � ����� &0 selectedserverurl selectedServerURL � m   � ���
�� 
TEXT��  ��   � m   � � � � � � �  '��  ��  ��  ��  ��   � ( " get ready to handle Cancel button    � � � � D   g e t   r e a d y   t o   h a n d l e   C a n c e l   b u t t o n � R      ������
�� .ascrerr ****      � ****��  ��   � L   � � � � m   � ���
�� boovfals��  ��   �  � � � l  � ���������  ��  ��   �  ��� � L   � � � � m   � ���
�� boovtrue��   d  � � � l     ��������  ��  ��   �  � � � l      �� � ���   � C = retrieve relevant info from Vienna active tab and selection     � � � � z   r e t r i e v e   r e l e v a n t   i n f o   f r o m   V i e n n a   a c t i v e   t a b   a n d   s e l e c t i o n   �  � � � i   ( + � � � I      ����~�� 0 preparetext prepareText�  �~   � O     � � � � k    � � �  � � � r    	 � � � 1    �}
�} 
dSmU � o      �|�| 0 article_url article_URL �  � � � l  
 
�{�z�y�{  �z  �y   �  � � � Z   
 9 � ��x � � l  
  ��w�v � >  
  � � � o   
 �u�u 0 article_url article_URL � m     � � � � �  �w  �v   � r     � � � 1    �t
�t 
dSmT � o      �s�s 0 article_title  �x   � l   9 �  � k    9  r     1    �r
�r 
cuAR o      �q�q 0 the_article   �p Z    9	�o
 =   ! o    �n�n 0 the_article   m     �m
�m 
msng	 k   $ +  r   $ ' m   $ % �   o      �l�l 0 article_url article_URL �k r   ( + m   ( ) �   o      �j�j 0 article_title  �k  �o  
 k   . 9  r   . 3 l  . 1�i�h n   . 1  1   / 1�g
�g 
arLK  o   . /�f�f 0 the_article  �i  �h   o      �e�e 0 article_url article_URL !�d! r   4 9"#" l  4 7$�c�b$ n   4 7%&% 1   5 7�a
�a 
arTL& o   4 5�`�` 0 the_article  �c  �b  # o      �_�_ 0 article_title  �d  �p    . ( we probably are on Vienna's primary tab    �'' P   w e   p r o b a b l y   a r e   o n   V i e n n a ' s   p r i m a r y   t a b � ()( l  : :�^�]�\�^  �]  �\  ) *+* r   : ?,-, n  : =./. 1   ; =�[
�[ 
txdl/ 1   : ;�Z
�Z 
ascr- o      �Y�Y 0 astid ASTID+ 010 r   @ E232 m   @ A44 �55  :3 n     676 1   B D�X
�X 
txdl7 1   A B�W
�W 
ascr1 898 r   F I:;: m   F G<< �==  ; o      �V�V 0 	thescheme 	theScheme9 >?> Q   J \@A�U@ r   M SBCB l  M QD�T�SD n   M QEFE 4   N Q�RG
�R 
citmG m   O P�Q�Q F o   M N�P�P 0 article_url article_URL�T  �S  C o      �O�O 0 	thescheme 	theSchemeA R      �N�M�L
�N .ascrerr ****      � ****�M  �L  �U  ? HIH r   ] bJKJ o   ] ^�K�K 0 astid ASTIDK n     LML 1   _ a�J
�J 
txdlM 1   ^ _�I
�I 
ascrI NON l  c c�H�G�F�H  �G  �F  O PQP r   c jRSR 1   c h�E
�E 
cuSES o      �D�D 0 theselection theSelectionQ TUT l  k k�C�B�A�C  �B  �A  U VWV Z   k �XY�@ZX l  k |[�?�>[ G   k |\]\ =  k p^_^ o   k l�=�= 0 	thescheme 	theScheme_ m   l o`` �aa  h t t p] =  s xbcb o   s t�<�< 0 	thescheme 	theSchemec m   t wdd �ee 
 h t t p s�?  �>  Y k    �ff ghg l   �;ij�;  i R L build text : article/tab title, selected text and URL separated by newlines   j �kk �   b u i l d   t e x t   :   a r t i c l e / t a b   t i t l e ,   s e l e c t e d   t e x t   a n d   U R L   s e p a r a t e d   b y   n e w l i n e sh lml r    �non o    ��:�: 0 article_title  o o      �9�9 0 thetext theTextm pqp Z   � �rs�8�7r l  � �t�6�5t >  � �uvu o   � ��4�4 0 theselection theSelectionv m   � �ww �xx  �6  �5  s r   � �yzy b   � �{|{ b   � �}~} o   � ��3�3 0 thetext theText~ 1   � ��2
�2 
lnfd| o   � ��1�1 0 theselection theSelectionz o      �0�0 0 thetext theText�8  �7  q �/ r   � ���� b   � ���� b   � ���� o   � ��.�. 0 thetext theText� 1   � ��-
�- 
lnfd� o   � ��,�, 0 article_url article_URL� o      �+�+ 0 thetext theText�/  �@  Z r   � ���� o   � ��*�* 0 theselection theSelection� o      �)�) 0 thetext theTextW ��� l  � ��(�'�&�(  �'  �&  � ��� L   � ��� o   � ��%�% 0 thetext theText� ��$� l  � ��#�"�!�#  �"  �!  �$   � m     ���                                                                                  Vnna  alis    �  Macintosh HD               ���BD ����
Vienna.app                                                     �����)~�        ����  
 cu             Development   J/:Users:barijaon:gitdirs:vienna-rss:Build:Products:Development:Vienna.app/   
 V i e n n a . a p p    M a c i n t o s h   H D  GUsers/barijaon/gitdirs/vienna-rss/Build/Products/Development/Vienna.app   /    ��   � ��� l     � ���   �  �  � ��� i   , /��� I     ���
� .aevtoappnull  �   � ****�  �  � Z     (����� I     ���� 	0 setup  �  �  � k    $�� ��� r    ��� b    ��� b    ��� o    �� &0 selectedserverurl selectedServerURL� m    �� ���  / s h a r e ? t e x t =� I    ���� 0 preparetext prepareText�  �  � o      �� 0 theurl theURL� ��� O   $��� I   #���
� .VnnanwTbnull��� ��� null�  � ���
� 
urlT� o    �� 0 theurl theURL�  � m    ���                                                                                  Vnna  alis    �  Macintosh HD               ���BD ����
Vienna.app                                                     �����)~�        ����  
 cu             Development   J/:Users:barijaon:gitdirs:vienna-rss:Build:Products:Development:Vienna.app/   
 V i e n n a . a p p    M a c i n t o s h   H D  GUsers/barijaon/gitdirs/vienna-rss/Build/Products/Development/Vienna.app   /    ��  �  �  �  � ��
� l     �	���	  �  �  �
       
��  "�������  � ����� ������� 0 prefkey prefKey� $0 defaultserverurl defaultServerURL� &0 selectedserverurl selectedServerURL
� 
pimr�  (0 isoptionkeypressed isOptionKeyPressed�� 	0 setup  �� 0 preparetext prepareText
�� .aevtoappnull  �   � ****
� 
msng� ����� �  ��� �����
�� 
cobj� ��   ��
�� 
osax��  � �����
�� 
cobj� ��   �� 4
�� 
frmk��  � �� A���������� (0 isoptionkeypressed isOptionKeyPressed��  ��  � ���� 0 optionkeystat optionKeyStat� ����������
�� misccura�� 0 nsevent NSEvent�� 0 modifierflags modifierFlags�� 60 nseventmodifierflagoption NSEventModifierFlagOption
�� 
long�� ��,j+ ��,�&"l#jE�O�� �� f���������� 	0 setup  ��  ��  � �������� 0 appid appID�� 0 	needsetup 	needSetup�� 0 	theanswer 	theAnswer�  p���� � ����������� ������� ��� � � � �
�� 
ID  
�� 
TEXT
�� .sysoexecTEXT���     TEXT��  ��  �� (0 isoptionkeypressed isOptionKeyPressed
�� 
bool
�� 
dtxt
�� .sysodlogaskr        TEXT
�� 
bhit
�� 
ttxt�� ���,�&E�O �%�%b   %j Ec  OfE�W X  b  Ec  OeE�O�
 	*j+ �& Y L��b  l E�O��,�  2��,Ec  Oa �%a %b   %a %b  �&%a %j Y hW 	X  fY hOe� �� ����������� 0 preparetext prepareText��  ��  � ���������������� 0 article_url article_URL�� 0 article_title  �� 0 the_article  �� 0 astid ASTID�� 0 	thescheme 	theScheme�� 0 theselection theSelection�� 0 thetext theText� ��� ���������������4<��������`d��w��
�� 
dSmU
�� 
dSmT
�� 
cuAR
�� 
msng
�� 
arLK
�� 
arTL
�� 
ascr
�� 
txdl
�� 
citm��  ��  
�� 
cuSE
�� 
bool
�� 
lnfd�� �� �*�,E�O�� 
*�,E�Y #*�,E�O��  �E�O�E�Y ��,E�O��,E�O��,E�O���,FO�E�O ��k/E�W X  hO���,FO*a ,E�O�a  
 �a  a & (�E�O�a  �_ %�%E�Y hO�_ %�%E�Y �E�O�OPU� �����������
�� .aevtoappnull  �   � ****��  ��  �  � �������������� 	0 setup  �� 0 preparetext prepareText�� 0 theurl theURL
�� 
urlT
�� .VnnanwTbnull��� ��� null�� )*j+   !b  �%*j+ %E�O� 	*��l UY h ascr  ��ޭ