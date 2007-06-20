From: Mark <mark@runuo.com>
Subject: Re: =?utf-8?b?c2F0YV9wcm9taXNl?= error handling
Date: Wed, 20 Jun 2007 05:03:00 +0000 (UTC)
Message-ID: <loom.20070620T064715-435@post.gmane.org>
References: <200706191859.07050.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:34913 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434AbXFTFLF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 01:11:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I0sSA-0000tW-Of
	for linux-ide@vger.kernel.org; Wed, 20 Jun 2007 07:10:03 +0200
Received: from ip68-108-205-250.ph.ph.cox.net ([68.108.205.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 20 Jun 2007 07:10:02 +0200
Received: from mark by ip68-108-205-250.ph.ph.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 20 Jun 2007 07:10:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> I'm making a backup of some disks with dd (disk image) and sata_promise 
reported these errors:
> 
> ------------------------------------------------------------------------------
----------------------------------------
> ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata8.00: cmd c8/00:08:40:83:7a/00:00:00:00:00/e4 tag 0 cdb 0x0 data 4096 in
>          res 50/00:00:47:83:7a/00:00:00:00:00/e4 Emask 0x1 (device error)
> ata8.00: configured for UDMA/133
> ata8: EH complete
> sd 7:0:0:0: [sdh] 488397168 512-byte hardware sectors (250059 MB)
> sd 7:0:0:0: [sdh] Write Protect is off
> sd 7:0:0:0: [sdh] Mode Sense: 00 3a 00 00
> sd 7:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata5.00: cmd 25/00:08:e8:af:02/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
>          res 50/00:00:ef:af:02/00:00:10:00:00/e0 Emask 0x1 (device error)
> ata5.00: configured for UDMA/133
> ata5: EH complete
> sd 4:0:0:0: [sde] 488397168 512-byte hardware sectors (250059 MB)
> sd 4:0:0:0: [sde] Write Protect is off
> sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
> sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
> ------------------------------------------------------------------------------
----------------------------------------
> 
> Can I ignore them (EH handled them) or do i have to worry that the dd images 
are corrupted
> (don't wanna make an md5sum of a 250gb disk and image)?
> 
> Theo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


I get the same errors with my Promise SATA300 TX4 with 3 Samsung SATA II 
drives. I've been playing with it for a few days and I couldn't get to work 
reliably in anything but 2.6.22-rc5.

Now that I use 2.6.22-rc5, I get those errors for a few minutes then the driver 
hard resets and locks at 1.5 Gb/s. It seems reliable after that but I do get 
those errors every now and then under heavy I/O.

I read in another thread by a developer those errors are handled and no loss of 
data was occuring, they make me uneasy though.

After a fresh reboot, I get these errors for a while:

Jun 19 13:28:15 phoenix ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:28:15 phoenix ata2.00: (port_status 0x20080000)
Jun 19 13:28:15 phoenix ata2.00: cmd c8/00:00:3f:7a:08/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 131072 in
Jun 19 13:28:15 phoenix res 50/00:00:3e:7b:08/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:28:15 phoenix ata2: soft resetting port
Jun 19 13:28:15 phoenix ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:28:15 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:28:15 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:28:15 phoenix ata2.00: configured for UDMA/133
Jun 19 13:28:15 phoenix ata2: EH complete
Jun 19 13:28:15 phoenix sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:28:15 phoenix sd 1:0:0:0: [sdb] Write Protect is off
Jun 19 13:28:15 phoenix sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jun 19 13:28:15 phoenix sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:28:16 phoenix ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:28:16 phoenix ata2.00: (port_status 0x20080000)
Jun 19 13:28:16 phoenix ata2.00: cmd c8/00:48:bf:68:09/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 36864 in
Jun 19 13:28:16 phoenix res 50/00:00:06:69:09/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:28:17 phoenix ata2: soft resetting port
Jun 19 13:28:17 phoenix ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:28:17 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:28:17 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:28:17 phoenix ata2.00: configured for UDMA/133
Jun 19 13:28:17 phoenix ata2: EH complete
Jun 19 13:28:17 phoenix sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:28:17 phoenix sd 1:0:0:0: [sdb] Write Protect is off
Jun 19 13:28:17 phoenix sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jun 19 13:28:17 phoenix sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:28:20 phoenix ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:28:20 phoenix ata2.00: (port_status 0x20080000)
Jun 19 13:28:20 phoenix ata2.00: cmd c8/00:58:67:a2:0c/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 45056 in
Jun 19 13:28:20 phoenix res 50/00:00:be:a2:0c/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:28:20 phoenix ata2: soft resetting port
Jun 19 13:28:21 phoenix ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:28:21 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:28:21 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:28:21 phoenix ata2.00: configured for UDMA/133
Jun 19 13:28:21 phoenix ata2: EH complete
Jun 19 13:28:21 phoenix sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:28:21 phoenix sd 1:0:0:0: [sdb] Write Protect is off
Jun 19 13:28:21 phoenix sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jun 19 13:28:21 phoenix sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:28:24 phoenix ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:28:24 phoenix ata3.00: (port_status 0x20080000)
Jun 19 13:28:24 phoenix ata3.00: cmd c8/00:80:bf:79:0f/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 65536 in
Jun 19 13:28:24 phoenix res 50/00:00:3e:7a:0f/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:28:24 phoenix ata3: soft resetting port
Jun 19 13:28:24 phoenix ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:28:24 phoenix ata3.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:28:24 phoenix ata3.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:28:24 phoenix ata3.00: configured for UDMA/133
Jun 19 13:28:24 phoenix ata3: EH complete
Jun 19 13:28:24 phoenix sd 2:0:0:0: [sdc] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:28:24 phoenix sd 2:0:0:0: [sdc] Write Protect is off
Jun 19 13:28:24 phoenix sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Jun 19 13:28:24 phoenix sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:29:51 phoenix ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:29:51 phoenix ata3.00: (port_status 0x20080000)
Jun 19 13:29:51 phoenix ata3.00: cmd c8/00:58:e7:2d:06/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 45056 in
Jun 19 13:29:51 phoenix res 50/00:00:3e:2e:06/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:29:51 phoenix ata3: soft resetting port
Jun 19 13:29:51 phoenix ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:29:51 phoenix ata3.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:51 phoenix ata3.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:51 phoenix ata3.00: configured for UDMA/133
Jun 19 13:29:51 phoenix ata3: EH complete
Jun 19 13:29:51 phoenix sd 2:0:0:0: [sdc] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:29:51 phoenix sd 2:0:0:0: [sdc] Write Protect is off
Jun 19 13:29:51 phoenix sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Jun 19 13:29:51 phoenix sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:29:52 phoenix ata2: limiting SATA link speed to 1.5 Gbps
Jun 19 13:29:52 phoenix ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6
Jun 19 13:29:52 phoenix ata2.00: (port_status 0x20080000)
Jun 19 13:29:52 phoenix ata2.00: cmd c8/00:80:3f:c9:10/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 65536 in
Jun 19 13:29:52 phoenix res 50/00:00:be:c9:10/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:29:52 phoenix ata2: hard resetting port
Jun 19 13:29:52 phoenix ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Jun 19 13:29:52 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:52 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:52 phoenix ata2.00: configured for UDMA/133
Jun 19 13:29:52 phoenix ata2: EH complete
Jun 19 13:29:52 phoenix sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:29:52 phoenix sd 1:0:0:0: [sdb] Write Protect is off
Jun 19 13:29:52 phoenix sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jun 19 13:29:52 phoenix sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:29:55 phoenix ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:29:55 phoenix ata3.00: (port_status 0x20080000)
Jun 19 13:29:55 phoenix ata3.00: cmd c8/00:58:e7:8f:13/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 45056 in
Jun 19 13:29:55 phoenix res 50/00:00:3e:90:13/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:29:56 phoenix ata3: soft resetting port
Jun 19 13:29:56 phoenix ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:29:56 phoenix ata3.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:56 phoenix ata3.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:56 phoenix ata3.00: configured for UDMA/133
Jun 19 13:29:56 phoenix ata3: EH complete
Jun 19 13:29:56 phoenix sd 2:0:0:0: [sdc] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:29:56 phoenix sd 2:0:0:0: [sdc] Write Protect is off
Jun 19 13:29:56 phoenix sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Jun 19 13:29:56 phoenix sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:29:56 phoenix ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:29:56 phoenix ata1.00: (port_status 0x20080000)
Jun 19 13:29:56 phoenix ata1.00: cmd c8/00:80:bf:9e:13/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 65536 in
Jun 19 13:29:56 phoenix res 50/00:00:3e:9f:13/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:29:56 phoenix ata1: soft resetting port
Jun 19 13:29:56 phoenix ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:29:57 phoenix ata1.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:57 phoenix ata1.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:57 phoenix ata1.00: configured for UDMA/133
Jun 19 13:29:57 phoenix ata1: EH complete
Jun 19 13:29:57 phoenix sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:29:57 phoenix sd 0:0:0:0: [sda] Write Protect is off
Jun 19 13:29:57 phoenix sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jun 19 13:29:57 phoenix sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:29:57 phoenix ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:29:57 phoenix ata1.00: (port_status 0x20080000)
Jun 19 13:29:57 phoenix ata1.00: cmd c8/00:f8:3f:0f:14/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 126976 in
Jun 19 13:29:57 phoenix res 50/00:00:36:10:14/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:29:57 phoenix ata1: soft resetting port
Jun 19 13:29:57 phoenix ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:29:57 phoenix ata1.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:57 phoenix ata1.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:57 phoenix ata1.00: configured for UDMA/133
Jun 19 13:29:57 phoenix ata1: EH complete
Jun 19 13:29:57 phoenix sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:29:57 phoenix sd 0:0:0:0: [sda] Write Protect is off
Jun 19 13:29:57 phoenix sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jun 19 13:29:57 phoenix sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:29:58 phoenix ata3: limiting SATA link speed to 1.5 Gbps
Jun 19 13:29:58 phoenix ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6
Jun 19 13:29:58 phoenix ata3.00: (port_status 0x20080000)
Jun 19 13:29:58 phoenix ata3.00: cmd c8/00:e0:5f:5e:14/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 114688 in
Jun 19 13:29:58 phoenix res 50/00:00:3e:5f:14/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:29:58 phoenix ata3: hard resetting port
Jun 19 13:29:58 phoenix ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Jun 19 13:29:58 phoenix ata3.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:58 phoenix ata3.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:29:58 phoenix ata3.00: configured for UDMA/133
Jun 19 13:29:58 phoenix ata3: EH complete
Jun 19 13:29:58 phoenix sd 2:0:0:0: [sdc] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:29:58 phoenix sd 2:0:0:0: [sdc] Write Protect is off
Jun 19 13:29:58 phoenix sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Jun 19 13:29:58 phoenix sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:30:02 phoenix ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 13:30:02 phoenix ata1.00: (port_status 0x20080000)
Jun 19 13:30:02 phoenix ata1.00: cmd c8/00:00:3f:63:17/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 131072 in
Jun 19 13:30:02 phoenix res 50/00:00:3e:64:17/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:30:02 phoenix ata1: soft resetting port
Jun 19 13:30:02 phoenix ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 13:30:02 phoenix ata1.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:30:02 phoenix ata1.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:30:02 phoenix ata1.00: configured for UDMA/133
Jun 19 13:30:02 phoenix ata1: EH complete
Jun 19 13:30:02 phoenix sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:30:02 phoenix sd 0:0:0:0: [sda] Write Protect is off
Jun 19 13:30:02 phoenix sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jun 19 13:30:02 phoenix sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
Jun 19 13:30:08 phoenix ata1: limiting SATA link speed to 1.5 Gbps
Jun 19 13:30:08 phoenix ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6
Jun 19 13:30:08 phoenix ata1.00: (port_status 0x20080000)
Jun 19 13:30:08 phoenix ata1.00: cmd c8/00:00:bf:b3:1c/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 131072 in
Jun 19 13:30:08 phoenix res 50/00:00:be:b4:1c/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 13:30:08 phoenix ata1: hard resetting port
Jun 19 13:30:08 phoenix ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Jun 19 13:30:08 phoenix ata1.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:30:08 phoenix ata1.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 13:30:08 phoenix ata1.00: configured for UDMA/133
Jun 19 13:30:08 phoenix ata1: EH complete
Jun 19 13:30:08 phoenix sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 13:30:08 phoenix sd 0:0:0:0: [sda] Write Protect is off
Jun 19 13:30:08 phoenix sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Jun 19 13:30:08 phoenix sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA

After they all lock at 1.5 Gb/s, it stays quiet for a while until periods of 
extremely heavy I/O. In previous kernel versions, they would lower DMA modes 
until they reached PIO. I'd rather resync to 1.5 Gb/s than be in PIO mode, 
though I would prefer to have a 3.0 Gb/s link and no errors at all. SMART 
reports no drive errors (they are all brand new, as is the controller).

During heavy I/O, I will see these messages:

Jun 19 21:25:16 phoenix ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x2
Jun 19 21:25:16 phoenix ata2.00: (port_status 0x20080000)
Jun 19 21:25:16 phoenix ata2.00: cmd c8/00:80:3f:12:52/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 65536 in
Jun 19 21:25:16 phoenix res 50/00:00:be:12:52/00:00:00:00:00/e0 Emask 0x2 (HSM 
violation)
Jun 19 21:25:16 phoenix ata2: soft resetting port
Jun 19 21:25:16 phoenix ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Jun 19 21:25:16 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 21:25:16 phoenix ata2.00: ata_hpa_resize 1: sectors = 781422768, 
hpa_sectors = 781422768
Jun 19 21:25:16 phoenix ata2.00: configured for UDMA/133
Jun 19 21:25:16 phoenix ata2: EH complete
Jun 19 21:25:16 phoenix sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors 
(400088 MB)
Jun 19 21:25:16 phoenix sd 1:0:0:0: [sdb] Write Protect is off
Jun 19 21:25:16 phoenix sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Jun 19 21:25:16 phoenix sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA

I'd really like to see this working in 3.0 Gb/s without any errors and I'd be 
more than happy to help test any possibly solutions.

I'm guessing the root of this issue lies in libata or some implementation of 
sata_promise.

I hope this helps someone, I've been searching for days.



