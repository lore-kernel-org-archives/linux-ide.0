From: Oliver Bausinger <bausi@bausi.org>
Subject: SIL 3114 problem
Date: Sun, 21 Nov 2004 18:38:42 +0100
Message-ID: <200411211838.42292.bausi@bausi.org>
Reply-To: bausi@bausi.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from everest.mathematik.uni-tuebingen.de ([134.2.62.220]:10372 "EHLO
	everest.mathematik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S261710AbUKURjI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Nov 2004 12:39:08 -0500
Received: from everest.mathematik.uni-tuebingen.de (p509183ED.dip0.t-ipconnect.de [80.145.131.237])
	by everest.mathematik.uni-tuebingen.de (Postfix) with ESMTP id 379A14B422
	for <linux-ide@vger.kernel.org>; Sun, 21 Nov 2004 18:39:06 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have strange problems with a SATA controller and harddisk.

Controller: Silicon Image SATA 3114 RAID
Harddisk: SAMSUNG SP1614C

The controller and disk get recognized, partitioned and formatted with ext3 
(or reiserfs) without problems.

I previously described a writing problem in   
http://bugme.osdl.org/show_bug.cgi?id=3751 
where - when trying to write on the disk - ext3 aborted.

This problem can no longer be reproduced with 2.6.10-rc2-bk6 which I'm 
currenty running.

Writing to a partition seems to work, but when I fsck.ext3 it (same for reiser 
and ext2) afterwards, I always get some kind of coruption like this:

root@ubuntu:~ # fsck.ext3 -f /dev/sda2
e2fsck 1.35 (28-Feb-2004)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  +(555012--555013) +(653315--653317) 
+(1603588--1603589) +1636356 +(1669123--1669125)
Fix<y>? yes

/dev/sda2: ***** FILE SYSTEM WAS MODIFIED *****
/dev/sda2: 140632/977280 files (0.2% non-contiguous), 890219/1953905 blocks

Running fsck again results in similar output. (Also similar happens with 
reiserfs)

When trying to put the root partition on the SATA disk random programs started 
to segfault as it doesn't seem to read correctly from the disk.

As none of this is reproducable on the IDE disks I'm working from it seems 
like a driver problem to me.

I tried to put the harddisk on the sil_blacklist for SIL_QUIRK_MOD15WRITE
in sata_sil.c which resulted in ext3 aborting the same way as described
in http://bugme.osdl.org/show_bug.cgi?id=3751 even with 2.6.10-rc2-bk6.

So, if anyone could help me or give me further debugging hints, I'd be 
thankful.

Greetings
Bausi
