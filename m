From: mikp <mikpolniak@roadrunner.com>
Subject: nvidia GF8200 (MCP78) chipset: plugging PMP gives
 "failed to IDENTIFY..."
Date: Sun, 29 Jun 2008 11:35:47 -0400
Message-ID: <20080629113547.ad0082bf.mikpolniak@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta9.adelphia.net ([68.168.78.199]:55876 "EHLO
	mta9.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbYF2Pft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 11:35:49 -0400
Received: from slack7.homefree.net ([76.180.122.198]) by mta9.adelphia.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20080629154036.ODMR4520.mta9.adelphia.net@slack7.homefree.net>
          for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 11:40:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Using Biostar TF8200 m/b with GeForce 8200 (MCP78) chipset.Everything 
seems to be working with kernel 2.6.25, but plugging in SIL 3726 port 
multiplier gives "failed to identify.."

dmesg...

ahci 0000:00:09.0: version 3.0
ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LSA0] -> GSI 23 (level, low) -> IRQ 23
ahci 0000:00:09.0: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl IDE mode
ahci 0000:00:09.0: flags: 64bit ncq sntf led clo pmp pio
PCI: Setting latency timer of device 0000:00:09.0 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m8192@0xfbe76000 port 0xfbe76100 irq 23
ata2: SATA max UDMA/133 abar m8192@0xfbe76000 port 0xfbe76180 irq 23
ata3: SATA max UDMA/133 abar m8192@0xfbe76000 port 0xfbe76200 irq 23
ata4: SATA max UDMA/133 abar m8192@0xfbe76000 port 0xfbe76280 irq 23
ata5: SATA max UDMA/133 abar m8192@0xfbe76000 port 0xfbe76300 irq 23
ata6: SATA max UDMA/133 abar m8192@0xfbe76000 port 0xfbe76380 irq 23
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: WDC WD6400AAKS-00A7B0, 01.03B01, max UDMA/133
ata1.00: 1250263728 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x100)
ata2: failed to recover some devices, retrying in 5 secs

then replugging the PMP gives......

ata2: hard resetting link
ata2: SATA link down (SStatus 100 SControl 300)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xa frozen
ata2: irq_stat 0x00000040, connection status changed
ata2: SError: { CommWake DevExch }
ata2: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x100)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x100)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x100)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x1 t4
ata2: irq_stat 0x08000000, interface fatal error
ata2: EH complete



and lspci -nn

00:00.0 RAM memory [0500]: nVidia Corporation Unknown device [10de:0754] (rev a2)
00:01.0 ISA bridge [0601]: nVidia Corporation Unknown device [10de:075c] (rev a2)
00:01.1 SMBus [0c05]: nVidia Corporation Unknown device [10de:0752] (rev a1)
00:01.2 RAM memory [0500]: nVidia Corporation Unknown device [10de:0751] (rev a1)
00:01.3 Co-processor [0b40]: nVidia Corporation Unknown device [10de:0753] (rev a2)
00:01.4 RAM memory [0500]: nVidia Corporation Unknown device [10de:0568] (rev a1)
00:02.0 USB Controller [0c03]: nVidia Corporation Unknown device [10de:077b] (rev a1)
00:02.1 USB Controller [0c03]: nVidia Corporation Unknown device [10de:077c] (rev a1)
00:04.0 USB Controller [0c03]: nVidia Corporation Unknown device [10de:077d] (rev a1)
00:04.1 USB Controller [0c03]: nVidia Corporation Unknown device [10de:077e] (rev a1)
00:06.0 IDE interface [0101]: nVidia Corporation Unknown device [10de:0759] (reva1)
00:07.0 Audio device [0403]: nVidia Corporation Unknown device [10de:0774] (rev a1)
00:08.0 PCI bridge [0604]: nVidia Corporation Unknown device [10de:075a] (rev a1)
00:09.0 IDE interface [0101]: nVidia Corporation Unknown device [10de:0ad0] (reva2)
00:0b.0 PCI bridge [0604]: nVidia Corporation Unknown device [10de:0569] (rev a1)
00:10.0 PCI bridge [0604]: nVidia Corporation Unknown device [10de:0778] (rev a1)
00:12.0 PCI bridge [0604]: nVidia Corporation Unknown device [10de:075b] (rev a1)
00:13.0 PCI bridge [0604]: nVidia Corporation Unknown device [10de:077a] (rev a1)
00:14.0 PCI bridge [0604]: nVidia Corporation Unknown device [10de:077a] (rev a1




