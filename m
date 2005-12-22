From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Interesting Performance with Marvell
Date: Wed, 21 Dec 2005 16:59:06 -0800
Message-ID: <43A9FA5A.7000704@physics.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newport.ucsd.edu ([132.239.73.89]:34690 "EHLO newport.ucsd.edu")
	by vger.kernel.org with ESMTP id S965027AbVLVA7L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2005 19:59:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: linux-ide@vger.kernel.org

So I am running a few tests with two Marvell chipset based systems now 
that I have a working driver. Thanks for all the help with that.  I am 
seeing some strange results though in performance. Basically my 4 port 
Marvell seems to be much faster on writes only than my 8 port.

Here are my bonie++ tests

I use a basic bonnie++ -u daemon -d bonnie on XFS file systems.
Where I change the scheduler from anticipatory I note it.

MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
4 disk raid 0
Linux software raid 0
mdadm --create /dev/md2 --chunk=256 --level=0 --raid-devices=4 /dev/sdc1 
/dev/sdd1 /dev/sde1 /dev/sdf1
ST3400832AS
3.2Ghz Xeon 4GB RAM Dual Socket
4GB RAM
Supermicro X6DVL-EG2
2.6.15-rc5
XFS
CFQ Scheduler
Version  1.03       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
/sec %CP
osg-fs1.local    8G 48009  99 56987  11 27792   7 50606  97 191749  19 
360.8   0
                    ------Sequential Create------ --------Random 
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
/sec %CP
                 16  3724  18 +++++ +++  2549  11  2543  15 +++++ +++  
1772   7
osg-fs1.local,8G,48009,99,56987,11,27792,7,50606,97,191749,19,360.8,0,16,3724,18,+++++,+++,2549,11,2543,15,+++++,+++,1772,7

Marvell Technology Group Ltd. MV88SX6041 4-port SATA II PCI-X Controller 
(rev 03)
2 Disk RAID0
ST3200826AS
3.2Ghz Xeon 4GB RAM Dual Socket
4GB RAM
Supermicro X6DHR-TG
2.6.15-rc5
XFS
mdadm --create /dev/md2 --chunk=256 --level=0 --raid-devices=2 /dev/sdc1 
/dev/sdd1
Version  1.03       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
/sec %CP
osg-gw-2.t2.ucsd 8G 48118  99 154782  36 45164  11 49961  96 133858  13 
371.7   0
                    ------Sequential Create------ --------Random 
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
/sec %CP
                 16  9288  46 +++++ +++  4842  19  5011  25 +++++ +++  
4061  21
osg-gw-2.t2.ucsd.edu,8G,48118,99,154782,36,45164,11,49961,96,133858,13,371.7,0,16,9288,46,+++++,+++,4842,19,5011,25,+++++,+++,4061,21

What I find interesting about these two runs is that the two disk RAID0 
is much faster on writes than the 4 disk RAID0 with much better balance. 
Memory, Kernel, CPU are all the same. The motherboards are different and 
I have noted them. The 4 port is onboard, the 8port is a PCI-X card in a 
PCI-X slot.

Here is the onboard Marvell with only one drive. Even with one drive I 
seem to be able to beat the write performance of the 4 drive raid0 on 
the PCI-X controller. I cannot imagine the 400 GB Seagates are slower on 
writes by that much over the 200GB seagates.

Marvell Technology Group Ltd. MV88SX6041 4-port SATA II PCI-X Controller 
(rev 03)
1 Disk no raid
ST3200826AS
3.2Ghz Xeon 4GB RAM Dual Socket
4GB RAM
Supermicro X6DHR-TG
2.6.15-rc5
XFS
Version  1.03       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
/sec %CP
osg-gw-2.t2.ucsd 8G 47861  99 75955  16 28891   6 35003  66 67958   6 
202.2   0
                    ------Sequential Create------ --------Random 
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
/sec %CP
                 16  5807  26 +++++ +++  5190  19  5460  25 +++++ +++  
3712  15
osg-gw-2.t2.ucsd.edu,8G,47861,99,75955,16,28891,6,35003,66,67958,6,202.2,0,16,5807,26,+++++,+++,5190,19,5460,25,+++++,+++,3712,15

Here is the 8 port again, this time with 2 disk raid0. I have also gone 
back to the default anticipatory scheduler.

MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
2 disk raid 0
Linux software raid 0
mdadm --create /dev/md2 --chunk=256 --level=0 --raid-devices=4 /dev/sdc1 
/dev/sdd1 /dev/sde1 /dev/sdf1
ST3400832AS
3.2Ghz Xeon 4GB RAM Dual Socket
4GB RAM
Supermicro X6DVL-EG2
2.6.15-rc5
XFS
Version  1.03       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
/sec %CP
osg-fs1.local    8G 29588  61 33894   7 21057   5 47502  91 134689  13 
397.5   0
                    ------Sequential Create------ --------Random 
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
/sec %CP
                 16  2236  10 +++++ +++  1492   6  1794   8 +++++ +++  
1175   5
osg-fs1.local,8G,29588,61,33894,7,21057,5,47502,91,134689,13,397.5,0,16,2236,10,+++++,+++,1492,6,1794,8,+++++,+++,1175,5

Again the read performance is very nice. The write performance though is 
not so good.

So is this driver? Hardware?

Sebastian what are the mfg of the Marvell controller you are using?

Terrence

