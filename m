From: sean <seandarcy2@gmail.com>
Subject: does AHCI work on intel 915 ICH6 controllers? Is it supposed to?
Date: Wed, 08 Jun 2005 18:10:15 -0400
Message-ID: <d87q4j$d37$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:34234 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262126AbVFHWOF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2005 18:14:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dg8ih-0001fz-3l
	for linux-ide@vger.kernel.org; Thu, 09 Jun 2005 00:08:19 +0200
Received: from ool-4356fcdd.dyn.optonline.net ([67.86.252.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2005 00:08:19 +0200
Received: from seandarcy2 by ool-4356fcdd.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2005 00:08:19 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm running 2.6.12-rc5 on a gigabyte GA-8i915G Pro mobo. It 
has only one drive -a Maxtor SATA.

lspci -vv -s 00:1f.2
00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) 
SATA Controller (rev 03) (prog-if 80 [Master])
         Subsystem: Giga-byte Technology: Unknown device 2651
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 201
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at f000 [size=16]
         Capabilities: [70] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
  PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


.config has:

# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=y
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y


the kernel picks  ata_piix.

dmesg:

libata version 1.11 loaded.
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) 
-> IRQ 201
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c68 
86:3e01 87:4063 88:207f
ata1: dev 0 ATA, max UDMA/133, 586114704 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
   Type:   Direct-Access                      ANSI SCSI 
revision: 05
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0


But, if I set .config with just AHCI, the kernel will not 
load libata at all. dmesg jsut goes from the Uniform CD-ROM 
driver revision to usbmon. And I get a kernel panic because 
sda doesn't exist.

I've seen some posts about needing to turn AHCI on in the 
BIOS. I didn't see anything, so I asked gigabyte:


 From : 	sean darcy [ seandarcy2@gmail.com ]
Sent : 	2005/5/8 05:14
Question : 	How do I turn on AHCI for SATA drives? I see no 
option in the BIOS. I'd like to use NCQ.

sean

Answer : 	hello,

By default it's automatically enabled and there are no 
options to enable it.
If your hdd supports it there should be a utility to check 
whether if it's enabled or not.

Thank you


Any good ideas?

sean

