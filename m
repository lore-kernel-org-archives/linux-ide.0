From: Sebastian Muniz <basurerosebita@gmail.com>
Subject: sil3132 eSATA problem
Date: Wed, 15 Feb 2012 04:02:29 -0300
Message-ID: <4F3B5885.4070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48545 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2BOHCc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2012 02:02:32 -0500
Received: by yhoo21 with SMTP id o21so485806yho.19
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2012 23:02:32 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello
Hello!
I am running
Linux ante 2.6.32.55sebita4-reiserfs4 #5 SMP Wed Feb 1 06:24:50 ART 2012 
x86_64 GNU/Linux
custom compiled with reiserfs4 patches on an IBM X3200 M3


I have a two port eSATA SIL3132:
10:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA 
Raid II Controller (rev 01)
         Subsystem: Silicon Image, Inc. Device 7132
         Flags: bus master, fast devsel, latency 0, IRQ 18
         Memory at 91b04000 (64-bit, non-prefetchable) [size=128]
         Memory at 91b00000 (64-bit, non-prefetchable) [size=16K]
         I/O ports at 3000 [size=128]
         Expansion ROM at 80600000 [disabled] [size=512K]
         Capabilities: [54] Power Management version 2
         Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
         Capabilities: [70] Express Legacy Endpoint, MSI 00
         Kernel driver in use: sata_sil24

This gives me this two ports:
[6]    sata_sil24
   cmd_per_lun=1    host_busy=0    sg_tablesize=253  unchecked_isa_dma=0
   dir: /sys/class/scsi_host//host6
   device dir: /sys/devices/pci0000:00/0000:00:1c.6/0000:10:00.0/host6
[7]    sata_sil24
   cmd_per_lun=1    host_busy=0    sg_tablesize=253  unchecked_isa_dma=0
   dir: /sys/class/scsi_host//host7
   device dir: /sys/devices/pci0000:00/0000:00:1c.6/0000:10:00.0/host7

On ata6 I have a Lian Li box with JM393PM with 5 disks:
[6:0:0:0]    disk    ATA      WDC WD20EARS-00S 0957  /dev/sdb
   state=running queue_depth=1 scsi_level=6 type=0 device_blocked=0 
timeout=30
   dir: /sys/bus/scsi/devices/6:0:0:0  
[/sys/devices/pci0000:00/0000:00:1c.6/0000:10:00.0/host6/target6:0:0/6:0:0:0]
[6:1:0:0]    disk    ATA      WDC WD20EARS-00S 80.0  /dev/sdc
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
   dir: /sys/bus/scsi/devices/6:1:0:0  
[/sys/devices/pci0000:00/0000:00:1c.6/0000:10:00.0/host6/target6:1:0/6:1:0:0]
[6:2:0:0]    disk    ATA      WDC WD20EARS-00S 80.0  /dev/sdd
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
   dir: /sys/bus/scsi/devices/6:2:0:0  
[/sys/devices/pci0000:00/0000:00:1c.6/0000:10:00.0/host6/target6:2:0/6:2:0:0]
[6:3:0:0]    disk    ATA      WDC WD20EARS-00M 51.0  /dev/sde
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
   dir: /sys/bus/scsi/devices/6:3:0:0  
[/sys/devices/pci0000:00/0000:00:1c.6/0000:10:00.0/host6/target6:3:0/6:3:0:0]
[6:4:0:0]    disk    ATA      WDC WD20EARS-00M 51.0  /dev/sdf
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
   dir: /sys/bus/scsi/devices/6:4:0:0  
[/sys/devices/pci0000:00/0000:00:1c.6/0000:10:00.0/host6/target6:4:0/6:4:0:0]

And ata7 is _unused_, nothing is connected to it.

However from time to time I see on the logs:
[904916.169177] ata7.00: failed to read SCR 1 (Emask=0x40)
[904916.169210] ata7.01: failed to read SCR 1 (Emask=0x40)
[904916.169239] ata7.02: failed to read SCR 1 (Emask=0x40)
[904916.169268] ata7.03: failed to read SCR 1 (Emask=0x40)
[904916.169293] ata7.04: failed to read SCR 1 (Emask=0x40)
[904916.169322] ata7.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[904916.169367] ata7.01: exception Emask 0x100 SAct 0x1 SErr 0x0 action 
0x6 frozen
[904916.169411] ata7.01: failed command: WRITE FPDMA QUEUED
[904916.169440] ata7.01: cmd 61/88:00:b7:e4:2e/03:00:4e:00:00/40 tag 0 
ncq 462848 out
[904916.169440]          res 90/7c:00:00:00:00/00:00:00:00:90/00 Emask 
0x2 (HSM violation)
[904916.169530] ata7.01: status: { Busy }
[904916.169554] ata7.01: error: { UNC IDNF ABRT }
[904916.169579] ata7.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[904916.169623] ata7.03: exception Emask 0x10 SAct 0x4 SErr 0x0 action 
0x6 frozen
[904916.169667] ata7.03: irq_stat 0x01060002, failed to transmit command FIS
[904916.169696] ata7.03: failed command: WRITE FPDMA QUEUED
[904916.169724] ata7.03: cmd 61/88:10:b7:e4:2e/03:00:4e:00:00/40 tag 2 
ncq 462848 out
[904916.169725]          res 90/7c:00:00:00:00/00:00:c0:21:90/00 Emask 
0x12 (ATA bus error)
[904916.169811] ata7.03: status: { Busy }
[904916.169834] ata7.03: error: { UNC IDNF ABRT }
[904916.169859] ata7.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 
0x6 frozen
[904916.169904] ata7.15: hard resetting link
[904916.169927] ata7: controller in dubious state, performing PORT_RST
[904918.396264] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[904918.396666] ata7.00: hard resetting link
[904918.731825] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[904918.731902] ata7.01: hard resetting link
[904919.067090] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[904919.067170] ata7.02: hard resetting link
[904919.402343] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[904919.402420] ata7.03: hard resetting link
[904919.753567] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[904919.753649] ata7.04: hard resetting link
[904920.104789] ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[904920.105952] ata7.00: configured for UDMA/100
[904920.118162] ata7.01: configured for UDMA/100
[904920.130177] ata7.02: configured for UDMA/100
[904920.138029] ata7.03: configured for UDMA/100
[904920.145862] ata7.04: configured for UDMA/100
[904920.145997] ata7: EH complete

This is the frequency:
root@ante:~# dmesg|grep "ata7: EH complete"
[409984.923590] ata7: EH complete
[415032.569957] ata7: EH complete
[420312.071009] ata7: EH complete
[421192.345587] ata7: EH complete
[875586.406464] ata7: EH complete
[904920.145997] ata7: EH complete


Questions:
- Is this a problem? Nothing looks wrong at the server, everything works 
as expected, but I receive a page from time time because of this error.
- Is there a way to keep the ata7 port down?  Kind of disable it.
- Is this the way to deal with this problem?


Thanks a lot in advance,
Sebastian

