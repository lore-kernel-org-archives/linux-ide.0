From: pacho baratta <pachox@evolinux.it>
Subject: /dev/hda problem with samsung hd
Date: 22 May 2003 14:08:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1053605323.1135.16.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.140.2.50] ([213.140.2.50]:57540 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S261788AbTEVLvx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 May 2003 07:51:53 -0400
Received: from [5.8.94.75] (5.8.94.75) by eta.fastwebnet.it (6.7.016)
        id 3EAF5CD20033331D for linux-ide@vger.kernel.org; Thu, 22 May 2003 14:04:57 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

i'm working with a disk (samsung sv1022d) that my system cannot see. i
have a live cd with kernel 2.4.20 and glibc-2.2.5.

now when i boot i find in dmesg:

hda samsung sv1022d my100 ata disk drive
hda: task_no_data_intr 0x51 {DriveRady SeekComplete Error}
hda: task_no_data_intr 0x04 {DriveStatusError}
hda: 1 sectors (0 mb) w/480KiB Cache CHS=1240/255/63

....

hda : hda : bad access : block 0 count 2
end request I/O error dev 03:030 (hda) sector 0


so i tried parted, this is the response:
/dev/hda disk label not recognized
the operating system think the geometry on dev/hda is 0/255/63

and doesn't give me acess to the disk.

same for fdisk:
it simply prints: impossible to read /dev/hda.

hdparm -iv /dev/hda says:
multcount	0 off
i/o_support		0	
unmaskirq	0
dma_supprt		1
keepsettings		0
readahead		8
readonly		0
geometry		1240/255/63 sectors 1 start 0

disk samsung v1022d my100
drive conform to ata-atapi-4


so i inserted my redhat sysadmin cd.
by that (it a kernel 2.4.14) i have access to the disk, fix the label by
parted, rebuild the partitions but when i reboot with lfs i see
everything as before. 
simply lfs system has not access to the disk

well i tried to change setting in bios and put CHS=1240/255/63 with same
results.

ideas?

pacho
-- 
pacho baratta			IT Consultant
tel. +39 347 078.51.31		www.evolinux.it
mail: pachox@evolinux.it

