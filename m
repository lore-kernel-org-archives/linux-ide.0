From: "kyle" <kylewong@southa.com>
Subject: trouble with seagate 1.5TB - 2.6.27.4
Date: Fri, 31 Oct 2008 11:40:48 +0800
Message-ID: <000901c93b0a$774ff3d0$b902a8c0@kyle>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.southa.com ([125.215.237.177]:44721 "HELO southa.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751313AbYJaDQt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Oct 2008 23:16:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Please cc me if possible.

I just built a new server with some seagate 1.5TB harddisks with mirrored
/boot and root partition , The system sometime degrade the root partition
with error message as follow, this happened 4 times within 2 days.

Oct 30 22:41:20 rsync2 kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6 frozen
Oct 30 22:41:20 rsync2 kernel: ata2.00: cmd
ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Oct 30 22:41:20 rsync2 kernel:         res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct 30 22:41:20 rsync2 kernel: ata2.00: status: { DRDY }
Oct 30 22:41:20 rsync2 kernel: ata2: hard resetting link
Oct 30 22:41:21 rsync2 kernel: ata2: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Oct 30 22:41:21 rsync2 kernel: ata2.00: configured for UDMA/133
Oct 30 22:41:21 rsync2 kernel: ata2: EH complete
Oct 30 22:41:21 rsync2 kernel: sd 1:0:0:0: [sdb] 2930277168 512-byte
hardware sectors (1500302 MB)
Oct 30 22:41:21 rsync2 kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 30 22:41:21 rsync2 kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
Oct 30 22:41:21 rsync2 kernel: end_request: I/O error, dev sdb, sector
20691533
Oct 30 22:41:21 rsync2 kernel: md: super_written gets error=-5, uptodate=0
Oct 30 22:41:21 rsync2 kernel: raid1: Disk failure on sdb2, disabling
device.
Oct 30 22:41:21 rsync2 kernel: raid1: Operation continuing on 1 devices.
Oct 30 22:41:21 rsync2 kernel: RAID1 conf printout:
Oct 30 22:41:21 rsync2 kernel: --- wd:1 rd:2
Oct 30 22:41:21 rsync2 kernel: disk 0, wo:0, o:1, dev:sda2
Oct 30 22:41:21 rsync2 kernel: disk 1, wo:1, o:0, dev:sdb2
Oct 30 22:41:21 rsync2 kernel: RAID1 conf printout:
Oct 30 22:41:21 rsync2 kernel: --- wd:1 rd:2
Oct 30 22:41:21 rsync2 kernel: disk 0, wo:0, o:1, dev:sda2
Oct 30 22:42:29 rsync2 xinetd[2278]: START: telnet pid=20246
from=192.168.2.1
Oct 30 22:43:17 rsync2 kernel: md: unbind<sdb2>
Oct 30 22:43:17 rsync2 kernel: md: export_rdev(sdb2)
Oct 30 22:43:22 rsync2 kernel: md: bind<sdb2>
Oct 30 22:43:22 rsync2 kernel: RAID1 conf printout:
Oct 30 22:43:22 rsync2 kernel: --- wd:1 rd:2
Oct 30 22:43:22 rsync2 kernel: disk 0, wo:0, o:1, dev:sda2
Oct 30 22:43:22 rsync2 kernel: disk 1, wo:1, o:1, dev:sdb2
Oct 30 22:43:22 rsync2 kernel: md: recovery of RAID array md1
Oct 30 22:43:22 rsync2 kernel: md: minimum _guaranteed_  speed: 1000
KB/sec/disk.
Oct 30 22:43:22 rsync2 kernel: md: using maximum available idle IO bandwidth
(but not more than 200000 KB/sec) for recovery.
Oct 30 22:43:22 rsync2 kernel: md: using 128k window, over a total of
10241344 blocks.
Oct 30 22:44:51 rsync2 xinetd[2278]: EXIT: telnet status=0 pid=20158
duration=251(sec)
Oct 30 22:45:50 rsync2 kernel: md: md1: recovery done.
Oct 30 22:45:50 rsync2 kernel: RAID1 conf printout:
Oct 30 22:45:50 rsync2 kernel: --- wd:2 rd:2
Oct 30 22:45:50 rsync2 kernel: disk 0, wo:0, o:1, dev:sda2
Oct 30 22:45:50 rsync2 kernel: disk 1, wo:0, o:1, dev:sdb2

Regards,
Kyle


