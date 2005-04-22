From: tmp <skrald@amossen.dk>
Subject: Whole SATA system stalls on Promise TX4
Date: Fri, 22 Apr 2005 18:40:18 +0200
Message-ID: <1114188018.893.21.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero0.cybercity.dk ([212.242.40.52]:18193 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S262063AbVDVQkU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Apr 2005 12:40:20 -0400
Received: from user5.cybercity.dk (user5.cybercity.dk [212.242.41.51])
	by cicero0.cybercity.dk (Postfix) with ESMTP id DAD2C29568
	for <linux-ide@vger.kernel.org>; Fri, 22 Apr 2005 18:40:18 +0200 (CEST)
Received: from [10.0.0.100] (port265.ds1-vbr.adsl.cybercity.dk [212.242.116.18])
	by user5.cybercity.dk (Postfix) with ESMTP id 710293A19EB
	for <linux-ide@vger.kernel.org>; Fri, 22 Apr 2005 18:40:18 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Can somebody help me decoding the behavior described below? I can
apparently stall the whole SATA bus.

I run kernel-2.6.11.7 and have just bought a Promise SATA TX4 controler
and runs software raid1 on it. According to
   http://linux.yyz.us/sata/sata-status.html#tx2
libata should support hotplug on this card.

Now, when I mark all partitions on /dev/sdb as faulty and do a
   mdadm -r /dev/md0 /dev/sdb*
the disc disappears from the arrays just fine.

Now I unplug the disc without shutting down first (I have two icy dock
MB123 SK docking stations) which should work just fine according to the
above link.
However, the arrays just completely stalls:

  * When I try to mount them, the mount command hangs
    Shouldn't the RAID system just continue working?

  * When I try to "fdisk /dev/sdb*", fdisk also hangs

  * Also "fdisk /dev/sdc*" hangs. Strange!

  * As far as I can see, something is quite wrong, according to
/var/log/syslog (why isn't the interrupt caught and some
"disc-removal-action" performed?):

Apr 22 01:14:32 server kernel: irq 10: nobody cared!
Apr 22 01:14:32 server kernel:  [__report_bad_irq+42/160]
__report_bad_irq+0x2a/0xa0
Apr 22 01:14:32 server kernel:  [handle_IRQ_event+48/112]
handle_IRQ_event+0x30/0x70
Apr 22 01:14:32 server kernel:  [note_interrupt+112/176]
note_interrupt+0x70/0xb0
Apr 22 01:14:32 server kernel:  [__do_IRQ+325/352] __do_IRQ+0x145/0x160
Apr 22 01:14:32 server kernel:  [do_IRQ+35/64] do_IRQ+0x23/0x40
Apr 22 01:14:32 server kernel:  [common_interrupt+26/32]
common_interrupt+0x1a/0x20
Apr 22 01:14:32 server kernel:  [__do_softirq+46/144] __do_softirq
+0x2e/0x90
Apr 22 01:14:32 server kernel:  [do_softirq+38/48] do_softirq+0x26/0x30
Apr 22 01:14:32 server kernel:  [irq_exit+53/64] irq_exit+0x35/0x40
Apr 22 01:14:32 server kernel:  [do_IRQ+40/64] do_IRQ+0x28/0x40
Apr 22 01:14:32 server kernel:  [common_interrupt+26/32]
common_interrupt+0x1a/0x20
Apr 22 01:14:32 server kernel:  [default_idle+35/48] default_idle
+0x23/0x30
Apr 22 01:14:32 server kernel:  [cpu_idle+80/96] cpu_idle+0x50/0x60
Apr 22 01:14:32 server kernel:  [start_kernel+329/368]
start_kernel+0x149/0x170
Apr 22 01:14:32 server kernel:  [unknown_bootoption+0/480]
unknown_bootoption+0x0/0x1e0
Apr 22 01:14:32 server kernel: handlers:
Apr 22 01:14:32 server kernel: [pdc_interrupt+0/464]
(pdc_interrupt+0x0/0x1d0)
AApr 22 00:58:16 server kernel: ata4: command timeout
Apr 22 00:58:16 server kernel: ata4: status=0x51 { DriveReady
SeekComplete
Error }
Apr 22 00:58:16 server kernel: ata4: called with no error (51)!
Apr 22 00:58:16 server kernel: SCSI error : <4 0 0 0> return code =
0x8000002
Apr 22 00:58:16 server kernel: sdc: Current: sense key=0x3
Apr 22 00:58:16 server kernel:     ASC=0x11 ASCQ=0x4
Apr 22 00:58:16 server kernel: end_request: I/O error, dev sdc, sector
4199
Apr 22 00:58:16 server kernel: raid1: Disk failure on sdc1, disabling
device.
Apr 22 00:58:16 server kernel: ^IOperation continuing on 1 devices
Apr 22 00:58:16 server kernel: raid1: sdc1: rescheduling sector 4136
Apr 22 01:14:32 server kernel: Disabling IRQ #10
Apr 22 00:58:46 server kernel: ata2: command timeout
Apr 22 00:58:46 server kernel: ATA: abnormal status 0xFF on port
0xCA81429C
Apr 22 00:58:46 server kernel: ata2: status=0xff { Busy }
Apr 22 00:58:46 server kernel: SCSI error : <2 0 0 0> return code =
0x8000002
Apr 22 00:58:46 server kernel: sdb: Current: sense key=0xb
Apr 22 00:58:46 server kernel:     ASC=0x47 ASCQ=0x0
Apr 22 00:58:46 server kernel: end_request: I/O error, dev sdb, sector
38491583
Apr 22 00:58:46 server kernel: md: write_disk_sb failed for device sdb1
Apr 22 00:58:46 server kernel: md: errors occurred during superblock
update, repeating
Apr 22 00:59:16 server kernel: ata2: command timeout
Apr 22 00:59:16 server kernel: ATA: abnormal status 0xFF on port
0xCA81429C
Apr 22 00:59:16 server kernel: ata2: status=0xff { Busy }
Apr 22 00:59:16 server kernel: SCSI error : <2 0 0 0> return code =
0x8000002
Apr 22 00:59:16 server kernel: sdb: Current: sense key=0xb
Apr 22 00:59:16 server kernel:     ASC=0x47 ASCQ=0x0
Apr 22 00:59:16 server kernel: end_request: I/O error, dev sdb, sector
38491583
Apr 22 00:59:16 server kernel: md: write_disk_sb failed for device sdb1
Apr 22 00:59:16 server kernel: md: errors occurred during superblock
update, repeating



