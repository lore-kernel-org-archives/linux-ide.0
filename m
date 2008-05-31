From: "Tuc at T-B-O-H.NET" <ml@t-b-o-h.net>
Subject: Correct partition table geometry?(Story included)
Date: Fri, 30 May 2008 22:38:43 -0400 (EDT)
Message-ID: <200805310238.m4V2chKZ034543@himinbjorg.tucs-beachin-obx-house.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vjofn.tucs-beachin-obx-house.com ([204.107.90.128]:1729 "EHLO
	vjofn.tucs-beachin-obx-house.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710AbYEaC7L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2008 22:59:11 -0400
Received: from himinbjorg.tucs-beachin-obx-house.com (cpe-24-161-6-139.hvc.res.rr.com [24.161.6.139])
	(authenticated bits=0)
	by vjofn.tucs-beachin-obx-house.com (8.14.2/8.14.2) with ESMTP id m4V2cpt7092461
	for <linux-ide@vger.kernel.org>; Fri, 30 May 2008 22:39:01 -0400 (EDT)
Received: from himinbjorg.tucs-beachin-obx-house.com (localhost.tucs-beachin-obx-house.com [127.0.0.1])
	by himinbjorg.tucs-beachin-obx-house.com (8.13.8/8.13.6) with ESMTP id m4V2ch4t034544
	for <linux-ide@vger.kernel.org>; Fri, 30 May 2008 22:38:45 -0400 (EDT)
	(envelope-from ml@t-b-o-h.net)
Received: (from tbohml@localhost)
	by himinbjorg.tucs-beachin-obx-house.com (8.13.8/8.13.6/Submit) id m4V2chKZ034543
	for linux-ide@vger.kernel.org; Fri, 30 May 2008 22:38:43 -0400 (EDT)
	(envelope-from tbohml)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

	An "acquaintance" runs a Wireless ISP with 2 Centos
servers. One of the servers disks (80G) is about to die, so he used
his limited Unix knowledge and :

	* Went out
	* Bought 500G drive
	* Installed it
	* Did dd if=/dev/hda of=/dev/hdb while the system was running
	* Rebooted
	* Had all SORTS of issues

	Once he took the drive out, and rebooted, everything was fine.
I found it was grub and /etc/fstab referencing LABEL= instead of
/dev/hda*. Ok, that fixed, he puts it back into the box, reboots,
everything is fine.

	I know that if he tries to run off the 500, he'll only
get 80 out of it since he's wrecked the partition table of the
500G with the info of it being an 80G.

	I pull up fdisk on the 500G and get :

Disk /dev/hdb: 500.1 GB, 500107862016 bytes
255 heads, 63 sectors/track, 60801 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1   *           1         127     1020096   83  Linux
/dev/hda2             128         185      465885   82  Linux swap
/dev/hda3             186         312     1020127+  83  Linux
/dev/hda4             313        9729    75642052+   5  Extended
/dev/hda5             313         439     1020096   83  Linux
/dev/hda6             440        1714    10241406   83  Linux


	I'm not paying much attention, but I see that the extended
ends at 9729, but his last partition ends at 1714. Not even thinking
I figure somehow Linux has realized the extended partition has alot
more room and compensated. Bully for Linux!

	So I delete hdb6, create a new one from 440 to 9729. 
I "mkfs.ext3 /dev/hdb6", mount it, and start to rsync the
/dev/hda6 content to it. In another window I pull up a "df" and
see :

Filesystem           1K-blocks      Used Available Use% Mounted on
		(etc)
/dev/hdb6             73449660    200128  69518440   1% /mnt/usr

	Somethings not making sense.... So I switch to "df -B G"..

[root@ports /]# df -B G
Filesystem           1G-blocks      Used Available Use% Mounted on
/dev/hda1                   1G        1G        1G  16% /
none                        1G        0G        1G   0% /dev/shm
/dev/hda5                   1G        1G        1G   2% /tmp
/dev/hda6                  10G        3G        7G  32% /usr
/dev/hda3                   1G        1G        1G  33% /var
/dev/hdb6                  71G        1G       67G   1% /mnt/usr


	So it looks like the guy didn't even configure all of the
80G he had available to him! It looks like he only used 14.5G
(1/2 G for swap)

	I'm wondering the best suggestions, hopefully with the
disk still in the case, that I can get the new 500G configured to
use the most amount of space, be bootable, etc. . 

	I first probably should just delete all the partitions,
they aren't worth anything. My next thing would be to correct
the number of cylinders. I've never had to correct cylinders
before, so not sure where to look or if I just delete all the partitions
will it come back properly? (I'm doubting it). Am I just kidding myself
that I can recover this easily with it still in a live system? I'll 
partition and create new partitions (If anyone knows the "default" 
mkfs2 line I'd appreciate it). I'll rsync the content. The final part I'm
guessing is to get grub active on it and willing to boot, something
I never did outside the confines of a CD install.

	Sorry for the diatribe.... And appreciate any help.
The disk shows up in dmesg as :

    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
hdb: ST3500630A, ATA DISK drive
hdb: max request size: 1024KiB
hdb: 976773168 sectors (500107 MB) w/16384KiB Cache, CHS=60801/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >

		Thanks, Tuc
