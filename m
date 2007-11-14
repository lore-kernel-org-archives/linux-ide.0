From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: sata_mv: hard resetting port
Date: Wed, 14 Nov 2007 10:43:39 +0100
Message-ID: <473AC34B.8000709@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:55720 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280AbXKNJnq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 04:43:46 -0500
Received: from postfix1.syneticon.net (postfix1.syneticon.net [192.168.112.6])
	by mail2.syneticon.net (Postfix) with ESMTP id DC6543C2A9
	for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 10:43:43 +0100 (CET)
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by postfix1.syneticon.net (Postfix) with ESMTP id 389DF9382
	for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 10:43:43 +0100 (CET)
Received: from postfix1.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id qKs5i0t1jg8K for <linux-ide@vger.kernel.org>;
	Wed, 14 Nov 2007 10:43:41 +0100 (CET)
Received: from [192.168.10.145] (xdsl-87-79-216-119.netcologne.de [87.79.216.119])
	by postfix1.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 10:43:41 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

This are the log entries I saw as I started e2fsck on a 5-disk Linux 
RAID-5 array; all disks connected to a sata_mv controller:

Nov 13 18:57:33 superthecus kernel: ata6.00: exception Emask 0x1 SAct 
0x0 SErr 0x100000 action 0x6 frozen
Nov 13 18:57:34 superthecus kernel: ata6.00: edma_err 0x00000084, EDMA 
self-disable
Nov 13 18:57:34 superthecus kernel: ata6.00: cmd 
25/00:00:bf:09:24/00:02:1c:00:00/e0 tag 0 cdb 0x0 data 262144 in
Nov 13 18:57:34 superthecus kernel:          res 
51/84:00:bf:09:24/84:02:1c:00:00/e0 Emask 0x10 (ATA bus error)
Nov 13 18:57:34 superthecus kernel: ata6: hard resetting port
Nov 13 18:57:34 superthecus kernel: ata6: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Nov 13 18:57:34 superthecus kernel: ata6.00: configured for UDMA/133
Nov 13 18:57:34 superthecus kernel: ata6: EH complete
Nov 13 18:57:34 superthecus kernel: sd 5:0:0:0: [sde] 781422768 512-byte 
hardware sectors (400088 MB)
Nov 13 18:57:34 superthecus kernel: sd 5:0:0:0: [sde] Write Protect is off
Nov 13 18:57:34 superthecus kernel: sd 5:0:0:0: [sde] Mode Sense: 00 3a 
00 00
Nov 13 18:57:34 superthecus kernel: sd 5:0:0:0: [sde] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Nov 13 18:57:37 superthecus kernel: ata6: exception Emask 0x10 SAct 0x0 
SErr 0x180000 action 0x6 frozen
Nov 13 18:57:37 superthecus kernel: ata6: edma_err 0x00000020
Nov 13 18:57:37 superthecus kernel: ata6: hard resetting port
Nov 13 18:57:37 superthecus kernel: ata6: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Nov 13 18:57:37 superthecus kernel: ata6.00: configured for UDMA/133
Nov 13 18:57:37 superthecus kernel: ata6: EH pending after completion, 
repeating EH (cnt=4)
Nov 13 18:57:37 superthecus kernel: ata6: exception Emask 0x10 SAct 0x0 
SErr 0x4010000 action 0x7
Nov 13 18:57:37 superthecus kernel: ata6: edma_err 0x00000010, dev connect
Nov 13 18:57:37 superthecus kernel: ata6: hard resetting port
Nov 13 18:57:37 superthecus kernel: ata6: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Nov 13 18:57:38 superthecus kernel: ata6.00: configured for UDMA/133
Nov 13 18:57:38 superthecus kernel: ata6: EH complete
Nov 13 18:57:38 superthecus kernel: sd 5:0:0:0: [sde] 781422768 512-byte 
hardware sectors (400088 MB)
Nov 13 18:57:38 superthecus kernel: sd 5:0:0:0: [sde] Write Protect is off
Nov 13 18:57:38 superthecus kernel: sd 5:0:0:0: [sde] Mode Sense: 00 3a 
00 00
Nov 13 18:57:38 superthecus kernel: sd 5:0:0:0: [sde] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA
Nov 13 18:57:38 superthecus kernel: sd 5:0:0:0: [sde] 781422768 512-byte 
hardware sectors (400088 MB)
Nov 13 18:57:38 superthecus kernel: sd 5:0:0:0: [sde] Write Protect is off
Nov 13 18:57:38 superthecus kernel: sd 5:0:0:0: [sde] Mode Sense: 00 3a 
00 00
Nov 13 18:57:38 superthecus kernel: sd 5:0:0:0: [sde] Write cache: 
enabled, read cache: enabled, doesn't support DPO or FUA



That's the Marvell controller:

01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)


smartctl didn't show any errors.



-- 
Tomasz Chmielewski
http://lists.wpkg.org
