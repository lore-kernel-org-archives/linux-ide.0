From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: ahci port hangs while hard resetting link
Date: Mon, 23 Aug 2010 00:10:48 +0300
Message-ID: <201008230010.48355.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:36225 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab0HVVSF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Aug 2010 17:18:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by saarni.dnainternet.net (Postfix) with ESMTP id C7D1CE62DD
	for <linux-ide@vger.kernel.org>; Mon, 23 Aug 2010 00:10:50 +0300 (EEST)
Received: from saarni.dnainternet.net ([83.102.40.136])
	by localhost (saarni.dnainternet.net [127.0.0.1]) (amavisd-new, port 10041)
	with ESMTP id KUkwZn83Usc7 for <linux-ide@vger.kernel.org>;
	Mon, 23 Aug 2010 00:10:50 +0300 (EEST)
Received: from kirsikkapuu.dnainternet.net (kirsikkapuu.dnainternet.net [83.102.40.214])
	by saarni.dnainternet.net (Postfix) with ESMTP id 6C260E618C
	for <linux-ide@vger.kernel.org>; Mon, 23 Aug 2010 00:10:50 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by kirsikkapuu.dnainternet.net (Postfix) with ESMTP id 630792BAD8
	for <linux-ide@vger.kernel.org>; Mon, 23 Aug 2010 00:10:49 +0300 (EEST)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id C99AB10DE0E5
	for <linux-ide@vger.kernel.org>; Mon, 23 Aug 2010 00:10:48 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all!

I was testing an apparently dead drive on my laptop's (T510) e-sata port. 
However, it somehow manages to get the port stalled, and trying
'echo "- - -" scan' hangs as well.

I could accept that maybe the controller becomes so confused that a reboot is 
needed to get the port working again, but I'd really think it should be 
possible to at least fail gracefully in that case (timeout or something). Or 
am I wrong, and there is simply nothing that could be done? :)

Note that I'm going to return this drive very soon (probably Monday), so I 
unfortunately won't be able to test any patches after that.

This is on a 2.6.35.1 system.

00:1f.2 SATA controller [0106]: Intel Corporation 5 Series/3400 Series Chipset 
6 port SATA AHCI Controller [8086:3b2f] (rev 06)

Below is more information from log:
=============================
Messages during boot - nothing connected to ata6
=============================
SCSI subsystem initialized
libata version 3.00 loaded.
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 16 (level, low) -> IRQ 16
ahci 0000:00:1f.2: irq 45 for MSI/MSI-X
ahci: SSS flag set, parallel bus scan disabled
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x33 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led clo pmp pio slum 
part ems sxs apst
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xf2427000 port 0xf2427100 irq 45
ata2: SATA max UDMA/133 abar m2048@0xf2427000 port 0xf2427180 irq 45
ata3: DUMMY
ata4: DUMMY
ata5: SATA max UDMA/133 abar m2048@0xf2427000 port 0xf2427300 irq 45
ata6: SATA max UDMA/133 abar m2048@0xf2427000 port 0xf2427380 irq 45
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
ata1.00: ATA-8: ST9320423AS, 0003LVM1, max UDMA/100
ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
ata1.00: configured for UDMA/100
ata1.00: configured for UDMA/100
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      ST9320423AS      0003 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sda: sda1 sda2 sda3 < sda5
 sda6 >
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
ata2.00: ATAPI: HL-DT-STDVDRAM GT30N, LT09, max UDMA/66
ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
ata2.00: configured for UDMA/66
scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GT30N     LT09 PQ: 0 ANSI: 5
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)

==================
A drive is connected to ata6 - it works normally
==================
08:59:13 : ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe 
frozen
08:59:13 : ata6: irq_stat 0x00400040, connection status changed
08:59:13 : ata6: SError: { PHYRdyChg CommWake DevExch }
08:59:13 : ata6: hard resetting link
08:59:23 : ata6: softreset failed (device not ready)
08:59:23 : ata6: hard resetting link
08:59:26 : ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
08:59:26 : ata6.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
08:59:26 : ata6.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) 
filtered out
08:59:26 : ata6.00: ATA-8: ST31500541AS, CC32, max UDMA/133
08:59:26 : ata6.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
08:59:26 : ata6.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
08:59:26 : ata6.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) 
filtered out
08:59:26 : ata6.00: configured for UDMA/133
08:59:26 : ata6.00: configured for UDMA/133
08:59:26 : ata6: EH complete
08:59:26 : scsi 5:0:0:0: Direct-Access     ATA      ST31500541AS     CC32 PQ: 
0 ANSI: 5
08:59:26 : sd 5:0:0:0: Attached scsi generic sg2 type 0
08:59:26 : sd 5:0:0:0: [sdb] 2930277168 512-byte logical blocks: (1.50 TB/1.36 
TiB)
08:59:26 : sd 5:0:0:0: [sdb] Write Protect is off
08:59:26 : sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
08:59:26 : sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
08:59:26 : sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
08:59:26 : sd 5:0:0:0: [sdb] Attached SCSI disk
08:59:26 : md: bind<sdb1>
08:59:26 : md: bind<sdb2>
====================
IIRC below I reconnected the drive once and then disconnected it. Anyway, it 
worked normally.
====================
09:17:45 : ata6: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe 
frozen
09:17:45 : ata6: irq_stat 0x00400040, connection status changed
09:17:45 : ata6: SError: { HostInt PHYRdyChg 10B8B DevExch }
09:17:45 : ata6: hard resetting link
09:17:46 : ata6: SATA link down (SStatus 0 SControl 300)
09:17:51 : ata6: hard resetting link
09:17:51 : ata6: SATA link down (SStatus 0 SControl 300)
09:17:51 : ata6: limiting SATA link speed to 1.5 Gbps
09:17:52 : ata6: hard resetting link
09:18:02 : ata6: softreset failed (device not ready)
09:18:02 : ata6: hard resetting link
09:18:02 : ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
09:18:02 : ata6.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
09:18:02 : ata6.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) 
filtered out
09:18:02 : ata6.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
09:18:02 : ata6.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) 
filtered out
09:18:02 : ata6.00: configured for UDMA/133
09:18:02 : ata6.00: configured for UDMA/133
09:18:02 : ata6: EH complete
09:18:07 : ata6: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action 0xe 
frozen
09:18:07 : ata6: irq_stat 0x00400040, connection status changed
09:18:07 : ata6: SError: { PHYRdyChg 10B8B DevExch }
09:18:07 : ata6: hard resetting link
09:18:08 : ata6: SATA link down (SStatus 0 SControl 310)
09:18:13 : ata6: hard resetting link
09:18:13 : ata6: SATA link down (SStatus 0 SControl 310)
09:18:18 : ata6: hard resetting link
09:18:18 : ata6: SATA link down (SStatus 0 SControl 310)
09:18:18 : ata6.00: disabled
09:18:18 : ata6: EH complete
09:18:18 : ata6.00: detaching (SCSI 5:0:0:0)
09:18:18 : sd 5:0:0:0: [sdb] Synchronizing SCSI cache
09:18:18 : sd 5:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK
09:18:18 : sd 5:0:0:0: [sdb] Stopping disk
09:18:18 : sd 5:0:0:0: [sdb] START_STOP FAILED
09:18:18 : sd 5:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK
====================
Now I connect another (apparently dead) drive to ata6.
The drive is not recognized:
====================
22:52:18 : ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe 
frozen
22:52:18 : ata6: irq_stat 0x00400040, connection status changed
22:52:18 : ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
22:52:18 : ata6: hard resetting link
22:52:28 : ata6: softreset failed (device not ready)
22:52:28 : ata6: hard resetting link
22:52:38 : ata6: softreset failed (device not ready)
22:52:38 : ata6: hard resetting link
22:52:49 : ata6: link is slow to respond, please be patient (ready=0)
22:53:13 : ata6: softreset failed (device not ready)
22:53:13 : ata6: limiting SATA link speed to 1.5 Gbps
22:53:13 : ata6: hard resetting link
=====================
I disconnect the drive for a few moments, but nothing is output by kernel.
I reconnect it again, but again, nothing is output by the kernel.
I run: echo "- - -" > 
/sys/devices/pci0000:00/0000:00:1f.2/host5/scsi_host/host5/scan
However, it appeared stuck and still no messages in the kernel log, so
I disconnected the device again. Still nothing is output, and the
following messages started to be output, indicating that the process
had become stuck:
=====================
23:01:45 : INFO: task bash:3154 blocked for more than 120 seconds.
23:01:45 : "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
message.
23:01:45 : bash          D 000000011992d5f9     0  3154   3147 0x00000000
23:01:45 : ffff8800ade67d68 0000000000000086 ffff8800ade67ce8 00000000000153c0
23:01:45 : ffff8800ade67fd8 00000000000153c0 ffff8800ade67fd8 ffff880090a72d80
23:01:45 : 00000000000153c0 00000000000153c0 ffff8800ade67fd8 00000000000153c0
23:01:45 : Call Trace:
23:01:45 : [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
23:01:45 : [<ffffffffa0184ba1>] ata_port_wait_eh+0x71/0xe0 [libata]
23:01:45 : [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
23:01:45 : [<ffffffffa0181dcf>] ata_scsi_user_scan+0xbf/0x150 [libata]
23:01:45 : [<ffffffffa012aee4>] store_scan+0xe4/0x120 [scsi_mod]
23:01:45 : [<ffffffff812c2e00>] dev_attr_store+0x20/0x30
23:01:45 : [<ffffffff811a6282>] sysfs_write_file+0xf2/0x180
23:01:45 : [<ffffffff8113bf08>] vfs_write+0xb8/0x1a0
23:01:45 : [<ffffffff813e5389>] ? do_page_fault+0x1a9/0x340
23:01:45 : [<ffffffff8113c951>] sys_write+0x51/0x90
23:01:45 : [<ffffffff81009fc2>] system_call_fastpath+0x16/0x1b
23:03:45 : INFO: task bash:3154 blocked for more than 120 seconds.
23:03:45 : "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
message.
23:03:45 : bash          D 000000011992d5f9     0  3154   3147 0x00000000
23:03:45 : ffff8800ade67d68 0000000000000086 ffff8800ade67ce8 00000000000153c0
23:03:45 : ffff8800ade67fd8 00000000000153c0 ffff8800ade67fd8 ffff880090a72d80
23:03:45 : 00000000000153c0 00000000000153c0 ffff8800ade67fd8 00000000000153c0
23:03:45 : Call Trace:
23:03:45 : [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
23:03:45 : [<ffffffffa0184ba1>] ata_port_wait_eh+0x71/0xe0 [libata]
23:03:45 : [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
23:03:45 : [<ffffffffa0181dcf>] ata_scsi_user_scan+0xbf/0x150 [libata]
23:03:45 : [<ffffffffa012aee4>] store_scan+0xe4/0x120 [scsi_mod]
23:03:45 : [<ffffffff812c2e00>] dev_attr_store+0x20/0x30
23:03:45 : [<ffffffff811a6282>] sysfs_write_file+0xf2/0x180
23:03:45 : [<ffffffff8113bf08>] vfs_write+0xb8/0x1a0
23:03:45 : [<ffffffff813e5389>] ? do_page_fault+0x1a9/0x340
23:03:45 : [<ffffffff8113c951>] sys_write+0x51/0x90
23:03:45 : [<ffffffff81009fc2>] system_call_fastpath+0x16/0x1b
23:05:45 : INFO: task bash:3154 blocked for more than 120 seconds.
23:05:45 : "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
message.
23:05:45 : bash          D 000000011992d5f9     0  3154   3147 0x00000000
23:05:45 : ffff8800ade67d68 0000000000000086 ffff8800ade67ce8 00000000000153c0
23:05:45 : ffff8800ade67fd8 00000000000153c0 ffff8800ade67fd8 ffff880090a72d80
23:05:45 : 00000000000153c0 00000000000153c0 ffff8800ade67fd8 00000000000153c0
23:05:45 : Call Trace:
23:05:45 : [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
23:05:45 : [<ffffffffa0184ba1>] ata_port_wait_eh+0x71/0xe0 [libata]
23:05:45 : [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
23:05:45 : [<ffffffffa0181dcf>] ata_scsi_user_scan+0xbf/0x150 [libata]
23:05:45 : [<ffffffffa012aee4>] store_scan+0xe4/0x120 [scsi_mod]
23:05:45 : [<ffffffff812c2e00>] dev_attr_store+0x20/0x30
23:05:45 : [<ffffffff811a6282>] sysfs_write_file+0xf2/0x180
23:05:45 : [<ffffffff8113bf08>] vfs_write+0xb8/0x1a0
23:05:45 : [<ffffffff813e5389>] ? do_page_fault+0x1a9/0x340
23:05:45 : [<ffffffff8113c951>] sys_write+0x51/0x90
23:05:45 : [<ffffffff81009fc2>] system_call_fastpath+0x16/0x1b
==============
Lastly, I connect the drive to ata5 instead, with a similar result:
==============
ata5: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
ata5: irq_stat 0x00000040, connection status changed
ata5: SError: { CommWake DevExch }
ata5: hard resetting link
ata5: softreset failed (device not ready)
ata5: hard resetting link
ata5: softreset failed (device not ready)
ata5: hard resetting link
ata5: link is slow to respond, please be patient (ready=0)
ata5: softreset failed (device not ready)
ata5: limiting SATA link speed to 1.5 Gbps
ata5: hard resetting link

-- 
Anssi Hannula
