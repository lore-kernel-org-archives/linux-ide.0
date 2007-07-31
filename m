From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Boot fails on Intel SATA controller
Date: Tue, 31 Jul 2007 11:00:59 -0300
Message-ID: <20070731110059.4bae43d4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:38674 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbXGaODK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 10:03:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kelk1@comcast.net


 Hi there,

 A Mandriva user is reporting that his machine hangs while booting
kernels 2.6.22.1 and 2.6.23-rc1.

 But boots fine with 2.6.21.

Here is the 2.6.22 boot log:

"""
SCSI subsystem initialized
Loading scsi_mod.ko module
Loading libata.ko module
ACPI: PCI Interrupt 0000:00:1f.2[C] -> Loading ahci.ko GSI 20 (level, low) ->
IRQ 18
module
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xf881ad00 ctl 0x00000000 bmdma 0x00000000 irq 18
ata2: SATA max UDMA/133 cmd 0xf881ad80 ctl 0x00000000 bmdma 0x00000000 irq 18
ata3: SATA max UDMA/133 cmd 0xf881ae00 ctl 0x00000000 bmdma 0x00000000 irq 18
ata4: SATA max UDMA/133 cmd 0xf881ae80 ctl 0x00000000 bmdma 0x00000000 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0x27)
ata1.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (781422768)
ata1.00: ATA-7: HDS724040KLSA80, KFAOA20N, max UDMA/133
ata1.00: 781422768 sectors, multi 8: LBA48
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
"""

 System is a Dell Dimension 8400 with SATA controller

"""
$ lspcidrake | grep IDE
piix            : Intel Corporation|82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE
Controller [STORAGE_IDE]
ahci            : Intel Corporation|82801FR/FRW (ICH6R/ICH6RW) SATA Controller
[STORAGE_IDE]
"""

 There's more info in the ticket:

http://qa.mandriva.com/show_bug.cgi?id=32076

-- 
Luiz Fernando N. Capitulino
