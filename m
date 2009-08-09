From: Miah Gregory <mace@darksilence.net>
Subject: SATA errors
Date: Sun, 09 Aug 2009 11:36:40 +0100
Message-ID: <1249814200.13927.65.camel@meteotsunami.darksilence.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from n01.darksilence.net ([80.68.91.227]:34786 "EHLO
	n01.darksilence.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZHIKnz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 06:43:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by n01.darksilence.net (Postfix) with ESMTP id 0C32766AC0
	for <linux-ide@vger.kernel.org>; Sun,  9 Aug 2009 11:36:47 +0100 (BST)
Received: from n01.darksilence.net ([127.0.0.1])
	by localhost (n01.darksilence.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IUFa1GO-cXa8 for <linux-ide@vger.kernel.org>;
	Sun,  9 Aug 2009 11:36:46 +0100 (BST)
Received: from meteotsunami (cpc1-john1-0-0-cust917.renf.cable.ntl.com [82.3.111.150])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by n01.darksilence.net (Postfix) with ESMTPSA id 4FB0D66ABE
	for <linux-ide@vger.kernel.org>; Sun,  9 Aug 2009 11:36:46 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

One of my servers has started to log slightly odd errors following one
of the software RAID arrays having been degraded due to an error on sdb.

ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         res 40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
end_request: I/O error, dev sdb, sector 976767834
md: super_written gets error=-5, uptodate=0
raid1: Disk failure on sdb3, disabling device.
raid1: Operation continuing on 1 devices.
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sda3
 disk 1, wo:1, o:0, dev:sdb3
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sda3

I tried running various smart tests and have run badblocks in R/W mode
across the whole surface of sdb, but did not find any obvious cause.

Do the following error logs point at anything specifically, all of which
have been seen since the above:

-snip-
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
         res 40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-snip-

-snip-
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata4.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
         res 40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-snip-

-snip-
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata3.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
         res 40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.00: status: { DRDY }
ata3: hard resetting link
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: configured for UDMA/133
sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-snip-

-snip-
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata5.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
         res 40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: status: { DRDY }
ata5: hard resetting link
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: configured for UDMA/133
sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-snip-

All of these errors might possibly related to smart self checking which
I've now set to run more regularly - although I wouldn't really expect a
reset being required to get the disk to respond during one.

I'm running a 2.6.28.2 kernel in a machine with 4 WDC WD5000AACS-0 500GB
disks.

I'm unable to check how the disks are physically wired at the moment,
however they're probably all on the promise controller:

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
01:04.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)

Any assistance greatfully received - please let me know if further
information is needed.

-- 
Miah Gregory

