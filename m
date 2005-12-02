From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: sata performance with 2.4.32 + latest libata
Date: Fri, 2 Dec 2005 17:28:35 +0100
Message-ID: <200512021728.35130.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750815AbVLBQ2t@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

I just tried kernel 2.4.32 + latest libata patches from 2005-12-01
after my performance problems described here:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D113171290329839

Now the machine is performing very fast :-)

Results with 2.4.32 + libata latest:
Version  1.03       ------Sequential Output------ --Sequential Input- -=
-Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- -=
-Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  =
/sec %CP
proliant         2G 33294  91 57592  20 26778   5 30885  77 56081   5 1=
74.2   0
                    ------Sequential Create------ --------Random Create=
--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -=
Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  =
/sec %CP
                 16 27313 100 +++++ +++ 26421  99 27285 101 +++++ +++ 2=
1477  89
proliant,2G,33294,91,57592,20,26778,5,30885,77,56081,5,174.2,0,16,27313=
,100,+++++,+++,26421,99,27285,101,+++++,+++,21477,89

Previous results with kernel 2.4.32-rc3:
Version =A01.03 =A0 =A0 =A0 ------Sequential Output------ --Sequential =
Input- --Random-
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -Per Chr- --Block-- -Rewrite- -=
Per Chr- --Block-- --Seeks--
Machine =A0 =A0 =A0 =A0Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/s=
ec %CP =A0/sec %CP
proliant =A0 =A0 =A0 =A0 2G 10523 =A028 11532 =A0 3 =A07162 =A0 1 24271=
 =A060 53495 =A0 5 164.3 =A0 0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ------Sequential Create------ -=
-------Random Create--------
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -Create-- --Read--- -Delete-- -=
Create-- --Read--- -Delete--
=A0 =A0 =A0 =A0 =A0 =A0 =A0 files =A0/sec %CP =A0/sec %CP =A0/sec %CP =A0=
/sec %CP =A0/sec %CP =A0/sec %CP
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016 30498 100 +++++ +++ 27244 =A098 2=
9630 =A099 +++++ +++ 11587 =A046
proliant,2G,10523,28,11532,3,7162,1,24271,60,53495,5,164.3,0,16,30498,1=
00,+++++,+++,27244,98,29630,99,+++++,+++,11587,46

A RAID1 rebuild went from 6-8 mb/s to this:
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>...]  recovery =3D=
 85.9% (2202816/2562240) finish=3D0.1min speed=3D56280K/sec


Thanks Jeff, you rock.

Thomas
