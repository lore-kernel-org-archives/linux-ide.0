From: Chuck Ebbert <cebbert@redhat.com>
Subject: Hard drives only detected when booting from CD on nVidia MCP67 SATA
Date: Wed, 05 Dec 2007 18:53:46 -0500
Message-ID: <47573A0A.4070401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbXLEXxs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Dec 2007 18:53:48 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lB5NrlGm025119
	for <linux-ide@vger.kernel.org>; Wed, 5 Dec 2007 18:53:48 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lB5NrkSu018022
	for <linux-ide@vger.kernel.org>; Wed, 5 Dec 2007 18:53:46 -0500
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lB5NrkNl008208
	for <linux-ide@vger.kernel.org>; Wed, 5 Dec 2007 18:53:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

With kernel 2.6.23 on an Acer 7220 notebook using nVidia MCP67 SATA,
hard drives are only detected after first booting from a CD.

Boot from hard drive      No drives detected

Boot live CD              Detected

Boot CD to GRUB menu,     Detected
then warm-boot from hard
drive


Non-detect case:

ahci 0000:00:09.0: version 2.3
ACPI: PCI Interrupt Link [LSI0] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LSI0] -> GSI 23 (level, low) -> 
IRQ 16
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
ahci 0000:00:09.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl IDE mode
ahci 0000:00:09.0: flags: 64bit sntf led clo pmp pio slum part
PCI: Setting latency timer of device 0000:00:09.0 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xf8854100 ctl 0x00000000 bmdma 0x00000000 irq 221
ata2: SATA max UDMA/133 cmd 0xf8854180 ctl 0x00000000 bmdma 0x00000000 irq 221
ata3: SATA max UDMA/133 cmd 0xf8854200 ctl 0x00000000 bmdma 0x00000000 irq 221
ata4: SATA max UDMA/133 cmd 0xf8854280 ctl 0x00000000 bmdma 0x00000000 irq 221
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
Waiting for driver initialization

But, if a LiveCD is used to boot or if a LiveCD was used before an hot reboot 
(without a power off), disks are correctly found :

Loading ahci.ko
ahci 0000:00:09.0: version 2.3
ACPI: PCI Interrupt Link [LSI0] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LSI0] -> GSI 23 (level, low) -> 
IRQ 16
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
ahci 0000:00:09.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl IDE mode
ahci 0000:00:09.0: flags: 64bit sntf led clo pmp pio slum part
PCI: Setting latency timer of device 0000:00:09.0 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xf8854100 ctl 0x00000000 bmdma 0x00000000 irq 221
ata2: SATA max UDMA/133 cmd 0xf8854180 ctl 0x00000000 bmdma 0x00000000 irq 221
ata3: SATA max UDMA/133 cmd 0xf8854200 ctl 0x00000000 bmdma 0x00000000 irq 221
ata4: SATA max UDMA/133 cmd 0xf8854280 ctl 0x00000000 bmdma 0x00000000 irq 221
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: Hitachi HTS541612J9SA00, SBDOC70P, max UDMA/100
ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)


https://bugzilla.redhat.com/show_bug.cgi?id=411171
