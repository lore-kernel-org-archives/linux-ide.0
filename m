From: Lieven Marchand <mal@wyrd.be>
Subject: timeouts with SiI 4726/3531
Date: Sun, 07 Oct 2007 00:25:50 +0200
Message-ID: <87lkaf3moh.fsf@wyrd.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213.219.136.97.adsl.dyn.edpnet.net ([213.219.136.97]:57906 "EHLO
	black" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752147AbXJGK0Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Oct 2007 06:26:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi,

I have an external enclosure based on the SiI 4726 connected to the
3531 controller. It mostly works on a Debian 2.6.22 kernel patched
with libata-tj-2.6.22.1-20070808. But occasionally under high load
there are timeouts. Usually, the system recovers without a problem but
once a disk wasn't found after the reset. It took a power off/power on
of the device.

Another weird problem is that the SiI 4726 software doesn't find its
controller, although the config disk is found by the system. I was
going to use the device in JBOD mode anyway so this isn't a big deal.

Thanks for a great job. It's amazing how well this works already. I
see on the SiI site they distribute a kernel module for Suse/Redhat
for the 3531. Is the source available for it and does it work better
with it?

Oct  6 22:18:09 black kernel: ata1.03: exception Emask 0x0 SAct 0x2 SErr 0x0 act
ion 0x2 frozen
Oct  6 22:18:09 black kernel: ata1.03: cmd 60/40:08:5f:f1:c1/00:00:0e:00:00/40 t
ag 1 cdb 0x0 data 32768 in
Oct  6 22:18:09 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 E
mask 0x4 (timeout)
Oct  6 22:18:09 black kernel: ata1.15: hard resetting link
Oct  6 22:18:11 black kernel: ata1.15: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 0)
Oct  6 22:18:11 black kernel: ata1.00: hard resetting link
Oct  6 22:18:12 black kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 300)
Oct  6 22:18:12 black kernel: ata1.01: hard resetting link
Oct  6 22:18:13 black kernel: ata1.01: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 300)
Oct  6 22:18:13 black kernel: ata1.02: hard resetting link
Oct  6 22:18:13 black kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 300)
Oct  6 22:18:13 black kernel: ata1.03: hard resetting link
Oct  6 22:18:14 black kernel: ata1.03: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 300)
Oct  6 22:18:14 black kernel: ata1.04: hard resetting link
Oct  6 22:18:14 black kernel: ata1.04: SATA link down (SStatus 0 SControl 300)
Oct  6 22:18:14 black kernel: ata1.05: hard resetting link
Oct  6 22:18:15 black kernel: ata1.05: SATA link up 3.0 Gbps (SStatus 123 SContr
ol 0)
Oct  6 22:18:15 black kernel: ata1.06: hard resetting link
Oct  6 22:18:16 black kernel: ata1.06: SATA link up 1.5 Gbps (SStatus 113 SContr
ol 300)
Oct  6 22:18:16 black kernel: ata1.00: configured for UDMA/100
Oct  6 22:18:16 black kernel: ata1.01: configured for UDMA/100
Oct  6 22:18:16 black kernel: ata1.02: configured for UDMA/100
Oct  6 22:18:16 black kernel: ata1.03: configured for UDMA/100
Oct  6 22:18:16 black kernel: ata1.05: device is on DMA blacklist, disabling DMA
Oct  6 22:18:16 black kernel: ata1.05: configured for PIO4
Oct  6 22:18:16 black kernel: ata1: EH complete
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] 640 512-byte hardware sectors (0
 MB)
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Write cache: disabled, read cach

e: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:0:0:0: [sdf] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:1:0:0: [sdg] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:2:0:0: [sdh] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] 976773168 512-byte hardware sect
ors (500108 MB)
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:3:0:0: [sdi] Write cache: enabled, read cache
: enabled, doesn't support DPO or FUA
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] 640 512-byte hardware sectors (0
 MB)
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Write Protect is off
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Mode Sense: 00 3a 00 00
Oct  6 22:18:16 black kernel: sd 0:5:0:0: [sdj] Write cache: disabled, read cach
e: enabled, doesn't support DPO or FUA
