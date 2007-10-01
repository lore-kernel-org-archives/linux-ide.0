From: "Jonathan Bell" <doggs.lay.eggs@googlemail.com>
Subject: Strange arbitrary port resets on ICH9R with Seagate drives
Date: Mon, 01 Oct 2007 01:30:59 +0100
Message-ID: <op.tzhs1xqexci36i@akima.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:43843 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbXJAAaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Sep 2007 20:30:55 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1783982ugc
        for <linux-ide@vger.kernel.org>; Sun, 30 Sep 2007 17:30:53 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello

I've just purchased a brand spanking new G33/ICH9R based system for use as  
a home fileserver with 4x ST3750840AS Seagate SATA drives as the main  
grunt drives.

The problem is that all of the seagate drives keep resetting, as this  
dmesg excerpt shows:

[ 2114.613486] ata5: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action  
0x2 frozen
[ 2114.613494] ata5: (irq_stat 0x00400040, connection status changed)
[ 2115.188869] ata5: waiting for device to spin up (8 secs)
[ 2116.832307] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action  
0x2 frozen
[ 2116.832314] ata6: (irq_stat 0x00400040, connection status changed)
[ 2117.405372] ata6: waiting for device to spin up (8 secs)
[ 2123.316046] ata5: soft resetting port
[ 2123.487789] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2123.529172] ata5.00: ata_hpa_resize 1: sectors = 1465149168,  
hpa_sectors = 1465149168
[ 2123.587389] ata5.00: ata_hpa_resize 1: sectors = 1465149168,  
hpa_sectors = 1465149168
[ 2123.587395] ata5.00: configured for UDMA/133
[ 2123.587400] ata5: EH complete
[ 2123.587628] SCSI device sdb: 1465149168 512-byte hdwr sectors (750156  
MB)
[ 2123.587862] sdb: Write Protect is off
[ 2123.587866] sdb: Mode Sense: 00 3a 00 00
[ 2123.588054] SCSI device sdb: write cache: enabled, read cache: enabled,  
doesn't support DPO or FUA
[ 2125.532548] ata6: soft resetting port
[ 2125.704290] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 2125.751647] ata6.00: ata_hpa_resize 1: sectors = 1465149168,  
hpa_sectors = 1465149168
[ 2125.809858] ata6.00: ata_hpa_resize 1: sectors = 1465149168,  
hpa_sectors = 1465149168
[ 2125.809865] ata6.00: configured for UDMA/133
[ 2125.809869] ata6: EH complete
[ 2125.810182] SCSI device sdc: 1465149168 512-byte hdwr sectors (750156  
MB)
[ 2125.810338] sdc: Write Protect is off
[ 2125.810342] sdc: Mode Sense: 00 3a 00 00
[ 2125.810527] SCSI device sdc: write cache: enabled, read cache: enabled,  
doesn't support DPO or FUA

Hardware:

00:00.0 Host bridge: Intel Corporation Unknown device 29c0 (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Unknown device 29c2  
(rev 02)
00:03.0 Communication controller: Intel Corporation Unknown device 29c4  
(rev 02)
00:1a.0 USB Controller: Intel Corporation Unknown device 2937 (rev 02)
00:1a.1 USB Controller: Intel Corporation Unknown device 2938 (rev 02)
00:1a.2 USB Controller: Intel Corporation Unknown device 2939 (rev 02)
00:1a.7 USB Controller: Intel Corporation Unknown device 293c (rev 02)
00:1b.0 Audio device: Intel Corporation Unknown device 293e (rev 02)
00:1c.0 PCI bridge: Intel Corporation Unknown device 2940 (rev 02)
00:1c.3 PCI bridge: Intel Corporation Unknown device 2946 (rev 02)
00:1c.4 PCI bridge: Intel Corporation Unknown device 2948 (rev 02)
00:1d.0 USB Controller: Intel Corporation Unknown device 2934 (rev 02)
00:1d.1 USB Controller: Intel Corporation Unknown device 2935 (rev 02)
00:1d.2 USB Controller: Intel Corporation Unknown device 2936 (rev 02)
00:1d.7 USB Controller: Intel Corporation Unknown device 293a (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
00:1f.0 ISA bridge: Intel Corporation Unknown device 2916 (rev 02)
00:1f.2 SATA controller: Intel Corporation Unknown device 2922 (rev 02)
00:1f.3 SMBus: Intel Corporation Unknown device 2930 (rev 02)
02:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363  
AHCI Controller (rev 02)
02:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363 AHCI  
Controller (rev 02)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B  
PCI Express Gigabit Ethernet controller (rev 01)

CPU is a Core2Duo E4400

The ICH9R is being run in AHCI mode, which is pretty much a necessity as I  
want hotplugging.
NO accesses are being performed on the drives, the problems happened as  
soon as they were plugged in. Interestingly more information is dumped on  
boot when I think mdadm tries to access the drives - even though I only  
abortively tried to set up an array on them it still thinks there's raid  
superblocks on there or something.

[   45.673182] ata6.00: exception Emask 0x50 SAct 0x1 SErr 0x4890800  
action 0x2 frozen
[   45.673186] ata6.00: (irq_stat 0x08400040, interface fatal error,  
connection status changed)
[   45.673192] ata6.00: cmd 60/58:00:30:00:00/00:00:00:00:00/40 tag 0 cdb  
0x0 data 45056 in
[   45.673193]          res 40/00:00:30:00:00/00:00:00:00:00/40 Emask 0x50  
(ATA bus error)

ATA bus error... riiight...

I also have an older Maxtor 6L300S0 that is acting as the OS/backup drive  
for the system. Plugging it in with exactly the same wires to the same  
ports = no errors. The Maxtor is completely happy running with NCQ. The  
SATA CDROM is completely happy. I limited the drives to 1.5Gbps, no  
difference in the results with or without.

In a limited attempt at bugfixing, I disabled NCQ by executing the  
following:

echo 1 > /sys/block/sd[bcde]/device/queue_depth

previously the file contained 31. The errors still occur even with no IO  
at all. They seem completely independent of IO transactions anyway: I can  
cat /dev/urandom > /dev/sd[bcde] quite happily without the kernel spewing  
errors at me, and similarly a read of the drives to /dev/null doesn't  
result in anything too dramatic.


Any ideas?
