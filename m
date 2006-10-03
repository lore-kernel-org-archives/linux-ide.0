From: Jonathan Dieter <jdieter@gmail.com>
Subject: MAP value 01b for ICH6M
Date: Tue, 03 Oct 2006 16:42:09 +0300
Message-ID: <452268B1.8090304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:25205 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750820AbWJCNmT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Oct 2006 09:42:19 -0400
Received: by nf-out-0910.google.com with SMTP id o25so167879nfa
        for <linux-ide@vger.kernel.org>; Tue, 03 Oct 2006 06:42:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
Cc: Tom Deblauwe <tom.deblauwe@telenet.be>

Tejun, I've received an e-mail from Tom Deblauwe about the ata_piix.c 
fix for the ICH7M controllers with MAP value 01b.  It looks like he has 
a ICH6M controller with MAP value 01b.  I'm including the relevant snips 
from his dmesg and lspci.  He has already used my original patch that 
worked against both ICH6M and ICH7M controllers, not the one the made it 
into the 2.6.18 kernel that just worked against the ICH7M controller.  
I've CC'd him, so if you want to communicate directly with him, his 
e-mail is included in the header.

Thanks,
Jonathan

-------- Original Message --------
From: 	Tom Deblauwe <tom.deblauwe "at" telenet "dat" be>
To: 	Jonathan Dieter <jdieter@gmail.com>
Subject: 	Re: Kernel 2.6.18 patch


Here is the log of dmesg and lspci -v:

Linux version 2.6.17.13 (root@majorTom) (gcc version 4.1.2 20060901 
(prerelease) (Debian 4.1.1-13)) #1 SMP PREEMPT Thu Sep 14 14:38:22 CEST 2006
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000001f690000 (usable)
BIOS-e820: 000000001f690000 - 000000001f6a2000 (ACPI data)
BIOS-e820: 000000001f6a2000 - 000000001f700000 (ACPI NVS)
BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)

[snip]

SCSI subsystem initialized
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 169
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ahci: probe of 0000:00:1f.2 failed with error -12
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: MAP [ IDE IDE P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
ata1: dev 0 cfg 49:2f00 82:346b 83:7f09 84:6023 85:3c69 86:3d01 87:6003 
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 195371568 sectors: LBA48
ata1: dev 1 cfg 49:0f00 82:421c 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0407
ata1: dev 1 ATAPI, max UDMA/33
ata1: dev 0 configured for UDMA/33
ata1: dev 1 configured for UDMA/33
scsi0 : ata_piix
 Vendor: ATA       Model: SAMSUNG HM100JC   Rev: YN10
 Type:   Direct-Access                      ANSI SCSI revision: 05
 Vendor: HL-DT-ST  Model: DVDRAM GMA-4082N  Rev: HA01
 Type:   CD-ROM                             ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
ata2: SATA port has no device.
scsi1 : ata_piix

[snip]

LSPCI -V:

majortom@majorTom:~$ lspci -v

[snip]

00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 
03) (prog-if 80 [Master])
       Subsystem: Wistron Corp. Unknown device 4042
       Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 169
       I/O ports at <unassigned>
       I/O ports at <unassigned>
       I/O ports at <unassigned>
       I/O ports at <unassigned>
       I/O ports at 18b0 [size=16]
       Capabilities: <access denied>

[snip]

