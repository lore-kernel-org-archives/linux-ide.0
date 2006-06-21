From: Aalderd Bouwman <boac@wanadoo.nl>
Subject: Hotplug drives on vt8251 with ahci module
Date: Wed, 21 Jun 2006 09:42:33 +0200
Message-ID: <200606210942.33578.boac@wanadoo.nl>
Reply-To: boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:20246 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S1751262AbWFUHmf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 03:42:35 -0400
Received: from aalderd (s5593cc1b.adsl.wanadoo.nl [85.147.204.27])
	by smtp4.wanadoo.nl (Postfix) with ESMTP id C2C0019349
	for <linux-ide@vger.kernel.org>; Wed, 21 Jun 2006 09:42:33 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

When I load module ahci when a drive is 'online' the drive is can be used 
normal. When I disconnect the drive EH doesn't recognize that action. When I 
reconnect the driver posts the following kernel-message:

ata2: exception Emask 0x10 SAct 0x0 SErr 0x40f0000 action 0x2 frozen
ata2: (irq_stat 0x04400040, connection status changed)
ata2: soft resetting port
ata2: SATA link down (SStatus 1 SControl 300)
ata2: failed to recover some devices, retrying in 5 secs

And I am not able to use the drive/port at all.
The driver will disable the ata-port.

The total kernel-log:

Jun 21 09:27:33 server libata version 1.30 loaded.
Jun 21 09:27:33 server ahci 0000:00:0f.0: version 1.3
Jun 21 09:27:33 server ACPI (acpi_bus-0192): Device `SATA]is not power 
manageable [20060310]
Jun 21 09:27:33 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> 
GSI 10 (level, low) -> IRQ 10
Jun 21 09:27:37 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 
Gbps 0xf impl SATA mode
Jun 21 09:27:37 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio 
slum part
Jun 21 09:27:37 server ata1: SATA max UDMA/133 cmd 0xE048AD00 ctl 0x0 bmdma 
0x0 irq 10
Jun 21 09:27:37 server ata2: SATA max UDMA/133 cmd 0xE048AD80 ctl 0x0 bmdma 
0x0 irq 10
Jun 21 09:27:37 server ata3: SATA max UDMA/133 cmd 0xE048AE00 ctl 0x0 bmdma 
0x0 irq 10
Jun 21 09:27:37 server ata4: SATA max UDMA/133 cmd 0xE048AE80 ctl 0x0 bmdma 
0x0 irq 10
Jun 21 09:27:37 server ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 21 09:27:37 server ata1.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 
86:3c01 87:4023 88:407f
Jun 21 09:27:37 server ata1.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 
NCQ (depth 0/32)
Jun 21 09:27:37 server ata1.00: configured for UDMA/133
Jun 21 09:27:37 server scsi0 : ahci
Jun 21 09:27:38 server ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jun 21 09:27:38 server ata2.00: cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 
86:3a01 87:4003 88:007f
Jun 21 09:27:38 server ata2.00: ATA-7, max UDMA/133, 160086528 sectors: LBA
Jun 21 09:27:38 server ata2.00: configured for UDMA/133
Jun 21 09:27:38 server scsi1 : ahci
Jun 21 09:27:38 server ata3: SATA link down (SStatus 0 SControl 300)
Jun 21 09:27:38 server scsi2 : ahci
Jun 21 09:27:38 server ata4: SATA link down (SStatus 0 SControl 300)
Jun 21 09:27:38 server scsi3 : ahci
Jun 21 09:27:38 server Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
Jun 21 09:27:38 server Type:   Direct-Access                      ANSI SCSI 
revision: 05
Jun 21 09:27:38 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 21 09:27:38 server sda: Write Protect is off
Jun 21 09:27:38 server sda: Mode Sense: 00 3a 00 00
Jun 21 09:27:38 server SCSI device sda: drive cache: write back
Jun 21 09:27:38 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 21 09:27:38 server sda: Write Protect is off
Jun 21 09:27:38 server sda: Mode Sense: 00 3a 00 00
Jun 21 09:27:38 server SCSI device sda: drive cache: write back
Jun 21 09:27:38 server sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Jun 21 09:27:38 server sd 0:0:0:0: Attached scsi disk sda
Jun 21 09:27:38 server sd 0:0:0:0: Attached scsi generic sg0 type 0
Jun 21 09:27:38 server Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
Jun 21 09:27:38 server Type:   Direct-Access                      ANSI SCSI 
revision: 05
Jun 21 09:27:38 server SCSI device sdb: 160086528 512-byte hdwr sectors (81964 
MB)
Jun 21 09:27:38 server sdb: Write Protect is off
Jun 21 09:27:38 server sdb: Mode Sense: 00 3a 00 00
Jun 21 09:27:38 server SCSI device sdb: drive cache: write back
Jun 21 09:27:38 server SCSI device sdb: 160086528 512-byte hdwr sectors (81964 
MB)
Jun 21 09:27:38 server sdb: Write Protect is off
Jun 21 09:27:38 server sdb: Mode Sense: 00 3a 00 00
Jun 21 09:27:38 server SCSI device sdb: drive cache: write back
Jun 21 09:27:38 server sdb: sdb1 sdb2
Jun 21 09:27:38 server sd 1:0:0:0: Attached scsi disk sdb
Jun 21 09:27:38 server sd 1:0:0:0: Attached scsi generic sg1 type 0
Jun 21 09:29:04 server ata2: exception Emask 0x10 SAct 0x0 SErr 0x40f0000 
action 0x2 frozen
Jun 21 09:29:04 server ata2: (irq_stat 0x04400040, connection status changed)
Jun 21 09:29:04 server ata2: soft resetting port
Jun 21 09:29:04 server ata2: SATA link down (SStatus 1 SControl 300)
Jun 21 09:29:04 server ata2: failed to recover some devices, retrying in 5 
secs
Jun 21 09:29:09 server ata2: hard resetting port
Jun 21 09:29:16 server ata2: port is slow to respond, please be patient
Jun 21 09:29:39 server ata2: port failed to respond (30 secs)
Jun 21 09:29:39 server ata2: COMRESET failed (device not ready)
Jun 21 09:29:39 server ata2: hardreset failed, retrying in 5 secs
Jun 21 09:29:44 server ata2: hard resetting port
Jun 21 09:29:52 server ata2: port is slow to respond, please be patient
Jun 21 09:30:15 server ata2: port failed to respond (30 secs)
Jun 21 09:30:15 server ata2: COMRESET failed (device not ready)
Jun 21 09:30:15 server ata2: hardreset failed, retrying in 5 secs
Jun 21 09:30:20 server ata2: hard resetting port
Jun 21 09:30:27 server ata2: port is slow to respond, please be patient
Jun 21 09:30:50 server ata2: port failed to respond (30 secs)
Jun 21 09:30:50 server ata2: COMRESET failed (device not ready)
Jun 21 09:30:50 server ata2: reset failed, giving up
Jun 21 09:30:50 server ata2.00: disabled
Jun 21 09:30:50 server ata2: EH complete

When I try to fdisk the drive:
Jun 21 09:31:24 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:24 server end_request: I/O error, dev sdb, sector 0
Jun 21 09:31:24 server Buffer I/O error on device sdb, logical block 0
Jun 21 09:31:24 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:24 server end_request: I/O error, dev sdb, sector 8
Jun 21 09:31:24 server Buffer I/O error on device sdb, logical block 1
Jun 21 09:31:24 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:24 server end_request: I/O error, dev sdb, sector 16
Jun 21 09:31:24 server Buffer I/O error on device sdb, logical block 2
Jun 21 09:31:24 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:24 server end_request: I/O error, dev sdb, sector 24
Jun 21 09:31:24 server Buffer I/O error on device sdb, logical block 3
Jun 21 09:31:24 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:24 server end_request: I/O error, dev sdb, sector 0
Jun 21 09:31:24 server Buffer I/O error on device sdb, logical block 0
Jun 21 09:31:29 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:29 server end_request: I/O error, dev sdb, sector 0
Jun 21 09:31:29 server Buffer I/O error on device sdb, logical block 0
Jun 21 09:31:29 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:29 server end_request: I/O error, dev sdb, sector 8
Jun 21 09:31:29 server Buffer I/O error on device sdb, logical block 1
Jun 21 09:31:29 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:29 server end_request: I/O error, dev sdb, sector 16
Jun 21 09:31:29 server Buffer I/O error on device sdb, logical block 2
Jun 21 09:31:29 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:29 server end_request: I/O error, dev sdb, sector 24
Jun 21 09:31:29 server Buffer I/O error on device sdb, logical block 3
Jun 21 09:31:29 server sd 1:0:0:0: SCSI error: return code = 0x40000
Jun 21 09:31:29 server end_request: I/O error, dev sdb, sector 0
Jun 21 09:31:29 server Buffer I/O error on device sdb, logical block 0

Remove the ahci module:
Jun 21 09:32:17 server ACPI: PCI interrupt for device 0000:00:0f.0 disabled

Here I disconnect both drives connected to the controller.
After the second/third port-reset I also do rmmod ahci:

Jun 21 09:12:02 server ahci 0000:00:0f.0: version 1.3
Jun 21 09:12:02 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> 
GSI 10 (level, low) -> IRQ 10
Jun 21 09:12:06 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 
Gbps 0xf impl SATA mode
Jun 21 09:12:06 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio 
slum part 
Jun 21 09:12:06 server ata9: SATA max UDMA/133 cmd 0xE0488D00 ctl 0x0 bmdma 
0x0 irq 10
Jun 21 09:12:06 server ata10: SATA max UDMA/133 cmd 0xE0488D80 ctl 0x0 bmdma 
0x0 irq 10
Jun 21 09:12:06 server ata11: SATA max UDMA/133 cmd 0xE0488E00 ctl 0x0 bmdma 
0x0 irq 10
Jun 21 09:12:06 server ata12: SATA max UDMA/133 cmd 0xE0488E80 ctl 0x0 bmdma 
0x0 irq 10
Jun 21 09:12:07 server ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 21 09:12:07 server ata9.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 
86:3c01 87:4023 88:407f
Jun 21 09:12:07 server ata9.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 
NCQ (depth 0/32)
Jun 21 09:12:07 server ata9.00: configured for UDMA/133
Jun 21 09:12:07 server scsi8 : ahci
Jun 21 09:12:07 server ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jun 21 09:12:07 server ata10.00: cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 
86:3a01 87:4003 88:007f
Jun 21 09:12:07 server ata10.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
Jun 21 09:12:07 server ata10.00: configured for UDMA/133
Jun 21 09:12:07 server scsi9 : ahci
Jun 21 09:12:07 server ata11: SATA link down (SStatus 0 SControl 300)
Jun 21 09:12:07 server scsi10 : ahci
Jun 21 09:12:07 server ata12: SATA link down (SStatus 0 SControl 300)
Jun 21 09:12:07 server scsi11 : ahci
Jun 21 09:12:07 server Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
Jun 21 09:12:07 server Type:   Direct-Access                      ANSI SCSI 
revision: 05
Jun 21 09:12:07 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 21 09:12:07 server sda: Write Protect is off
Jun 21 09:12:07 server sda: Mode Sense: 00 3a 00 00
Jun 21 09:12:07 server SCSI device sda: drive cache: write back
Jun 21 09:12:07 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 21 09:12:07 server sda: Write Protect is off
Jun 21 09:12:07 server sda: Mode Sense: 00 3a 00 00
Jun 21 09:12:07 server SCSI device sda: drive cache: write back
Jun 21 09:12:07 server sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Jun 21 09:12:07 server sd 8:0:0:0: Attached scsi disk sda
Jun 21 09:12:07 server sd 8:0:0:0: Attached scsi generic sg0 type 0
Jun 21 09:12:07 server Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
Jun 21 09:12:07 server Type:   Direct-Access                      ANSI SCSI 
revision: 05
Jun 21 09:12:07 server SCSI device sdb: 160086528 512-byte hdwr sectors (81964 
MB)
Jun 21 09:12:07 server sdb: Write Protect is off
Jun 21 09:12:07 server sdb: Mode Sense: 00 3a 00 00
Jun 21 09:12:07 server SCSI device sdb: drive cache: write back
Jun 21 09:12:07 server SCSI device sdb: 160086528 512-byte hdwr sectors (81964 
MB)
Jun 21 09:12:07 server sdb: Write Protect is off
Jun 21 09:12:07 server sdb: Mode Sense: 00 3a 00 00
Jun 21 09:12:07 server SCSI device sdb: drive cache: write back
Jun 21 09:12:07 server sdb: sdb1 sdb2
Jun 21 09:12:07 server sd 9:0:0:0: Attached scsi disk sdb
Jun 21 09:12:07 server sd 9:0:0:0: Attached scsi generic sg1 type 0
Jun 21 09:13:32 server ata9: exception Emask 0x10 SAct 0x0 SErr 0x41f0000 
action 0x2 frozen
Jun 21 09:13:32 server ata9: (irq_stat 0x04400040, connection status changed)
Jun 21 09:13:32 server ata9: soft resetting port
Jun 21 09:13:32 server ata9: SATA link down (SStatus 1 SControl 300)
Jun 21 09:13:32 server ata9: failed to recover some devices, retrying in 5 
secs
Jun 21 09:13:37 server ata9: hard resetting port
Jun 21 09:13:45 server ata9: port is slow to respond, please be patient
Jun 21 09:13:54 server ata10: exception Emask 0x10 SAct 0x0 SErr 0x4070000 
action 0x2 frozen
Jun 21 09:13:54 server ata10: (irq_stat 0x04400040, connection status changed)
Jun 21 09:13:54 server ata10: soft resetting port
Jun 21 09:13:54 server ata10: SATA link down (SStatus 1 SControl 300)
Jun 21 09:13:54 server ata10: failed to recover some devices, retrying in 5 
secs
Jun 21 09:13:59 server ata10: hard resetting port
Jun 21 09:14:06 server ata10: port is slow to respond, please be patient
Jun 21 09:14:08 server ata9: port failed to respond (30 secs)
Jun 21 09:14:08 server ata9: COMRESET failed (device not ready)
Jun 21 09:14:08 server ata9: hardreset failed, retrying in 5 secs
Jun 21 09:14:13 server ata9: hard resetting port
Jun 21 09:14:20 server ata9: port is slow to respond, please be patient
Jun 21 09:14:29 server ata10: port failed to respond (30 secs)
Jun 21 09:14:29 server ata10: COMRESET failed (device not ready)
Jun 21 09:14:29 server ata10: hardreset failed, retrying in 5 secs
Jun 21 09:14:34 server ata10: hard resetting port
Jun 21 09:14:41 server ata10: port is slow to respond, please be patient
Jun 21 09:14:43 server ata9: port failed to respond (30 secs)
Jun 21 09:14:43 server ata9: COMRESET failed (device not ready)
Jun 21 09:14:43 server ata9: hardreset failed, retrying in 5 secs
Jun 21 09:14:48 server ata9: hard resetting port
Jun 21 09:14:55 server ata9: port is slow to respond, please be patient
Jun 21 09:15:04 server ata10: port failed to respond (30 secs)
Jun 21 09:15:04 server ata10: COMRESET failed (device not ready)
Jun 21 09:15:04 server ata10: hardreset failed, retrying in 5 secs
Jun 21 09:15:09 server ata10: hard resetting port
Jun 21 09:15:16 server ata10: port is slow to respond, please be patient
Jun 21 09:15:18 server ata9: port failed to respond (30 secs)
Jun 21 09:15:18 server ata9: COMRESET failed (device not ready)
Jun 21 09:15:18 server ata9: reset failed, giving up
Jun 21 09:15:18 server ata9: EH pending after completion, repeating EH (cnt=4)
Jun 21 09:15:18 server ata9: exception Emask 0x10 SAct 0x0 SErr 0x4070000 
action 0x2 frozen
Jun 21 09:15:18 server ata9: (irq_stat 0x00000040, connection status changed)
Jun 21 09:15:18 server ata9: soft resetting port
Jun 21 09:15:18 server BUG: unable to handle kernel NULL pointer dereference 
at virtual address 00000010
Jun 21 09:15:18 server printing eip:
Jun 21 09:15:18 server e04926cc
Jun 21 09:15:18 server *pde = 00000000
Jun 21 09:15:18 server Oops: 0000 [#1]
Jun 21 09:15:18 server last sysfs file: /block/sdb/sdb2/dev
Jun 21 09:15:18 server Modules linked in: ahci libata cls_u32 sch_htb 
xt_tcpudp iptable_filter iptable_nat ip_tables x_tables ip_nat_irc 
ip_conntrack_irc ip_nat_ftp ip_nat ip_conntrack_ftp w83627ehf i2c_isa 
i2c_core 3c59x
Jun 21 09:15:18 server CPU:    0
Jun 21 09:15:18 server EIP:    0060:[<e04926cc>]    Not tainted VLI
Jun 21 09:15:18 server EFLAGS: 00010246   (2.6.17-rc5-mm2 #2) 
Jun 21 09:15:18 server EIP is at ahci_tf_read+0xa/0x19 [ahci]
Jun 21 09:15:18 server eax: 00000000   ebx: e049382f   ecx: de36c29c   edx: 
00000000
Jun 21 09:15:18 server esi: de36c29c   edi: 00000000   ebp: e0488d00   esp: 
de43ce84
Jun 21 09:15:18 server ds: 007b   es: 007b   ss: 0068
Jun 21 09:15:18 server Process scsi_eh_8 (pid: 15546, threadinfo=de43c000 
task=c66ed550)
Jun 21 09:15:18 server Stack: e0492455 de36c29c de43ce94 00000000 0000000a 
de36c380 00000246 00000046 
Jun 21 09:15:18 server fffffecc 0000001a de43cecc c0110a49 de43cefc de36c380 
de36c29c de36c29c 
Jun 21 09:15:18 server e04aa50e de36c29c de43cefc e04923f1 e04b0de3 de36c29c 
e04923f1 de43cefc 
Jun 21 09:15:18 server Call Trace:
Jun 21 09:15:18 server <e0492455> ahci_softreset+0x64/0x1d1 [ahci]  <c0110a49> 
__wake_up+0x14/0x1e
Jun 21 09:15:18 server <e04aa50e> ata_do_reset+0x1b/0x4d [libata]  <e04923f1> 
ahci_softreset+0x0/0x1d1 [ahci]
Jun 21 09:15:18 server <e04b0de3> ata_eh_reset+0x78/0xff [libata]  <e04923f1> 
ahci_softreset+0x0/0x1d1 [ahci]
Jun 21 09:15:18 server <e04b0f96> ata_eh_recover+0x70/0x1b3 [libata]  
<e04923f1> ahci_softreset+0x0/0x1d1 [ahci]
Jun 21 09:15:18 server <e04925c2> ahci_hardreset+0x0/0x4c [ahci]  <e049260e> 
ahci_postreset+0x0/0x3c [ahci]
Jun 21 09:15:18 server <e049260e> ahci_postreset+0x0/0x3c [ahci]  <e04925c2> 
ahci_hardreset+0x0/0x4c [ahci]
Jun 21 09:15:18 server <e04923f1> ahci_softreset+0x0/0x1d1 [ahci]  <e04b1171> 
ata_do_eh+0x29/0x3c [libata]
Jun 21 09:15:18 server <e04923f1> ahci_softreset+0x0/0x1d1 [ahci]  <e04925c2> 
ahci_hardreset+0x0/0x4c [ahci]
Jun 21 09:15:18 server <e049260e> ahci_postreset+0x0/0x3c [ahci]  <e0492c87> 
ahci_error_handler+0x2e/0x33 [ahci]
Jun 21 09:15:18 server <e04923f1> ahci_softreset+0x0/0x1d1 [ahci]  <e04925c2> 
ahci_hardreset+0x0/0x4c [ahci]
Jun 21 09:15:18 server <e049260e> ahci_postreset+0x0/0x3c [ahci]  <e04affe5> 
ata_scsi_error+0x145/0x26a [libata]
Jun 21 09:15:18 server <c0249a4c> scsi_error_handler+0x0/0x10d  <c0249af4> 
scsi_error_handler+0xa8/0x10d
Jun 21 09:15:18 server <c0122f1a> kthread+0x79/0xa3  <c0122ea1> 
kthread+0x0/0xa3
Jun 21 09:15:18 server <c01012e5> kernel_thread_helper+0x5/0xb 
Jun 21 09:15:18 server Code: 49 e0 68 bb a1 4a e0 56 e8 92 7e 01 00 83 c4 18 
5b 5e c3 8b 44 24 04 8b 40 28 8b 40 20 0f b6 c0 c3 8b 44 24 04 8b 80 c0 1f 00 
00 <8b> 40 10 83 c0 40 89 44 24 04 e9 ae 59 01 00 55 31 ed 57 56 53 
Jun 21 09:15:18 server EIP: [<e04926cc>] ahci_tf_read+0xa/0x19 [ahci] SS:ESP 
0068:de43ce84
Jun 21 09:15:40 server <3>ata10: port failed to respond (30 secs)
Jun 21 09:15:40 server ata10: COMRESET failed (device not ready)
Jun 21 09:15:40 server ata10: reset failed, giving up
Jun 21 09:15:40 server ata10.00: disabled
Jun 21 09:15:40 server ata10: EH complete

Aalderd Bouwman.
