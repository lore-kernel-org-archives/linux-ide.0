From: Roger Heflin <rahmrh@wildblue.net>
Subject: sata_via (VT6420) and WDC WD5000AAJS-22YFA0 not playing together
Date: Sat, 13 Oct 2007 15:29:02 -0500
Message-ID: <47112A8E.6000902@wildblue.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.wildblue.net ([216.126.204.44]:53671 "EHLO
	mail2.wildblue.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762970AbXJMUsr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 16:48:47 -0400
Received: from [192.168.1.99] (70-41-59-96.cust.wildblue.net [70.41.59.96])
	by mail2.wildblue.net (Postfix) with ESMTP id B3D784A39C6
	for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 14:29:10 -0600 (MDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have 4 WDC WD5000AAJS-22YFA0 drives (WD 500GB).

2 appear to be found just fine on a promise controller, 2 connected to
a via (VT6420) controller don't appear to happy at all.   Moving one of
the appearing known good drives that worked on the other controller 
results in this drive not being found on the via controller, and
moving a via controller drive to the promise makes the drive
appear to be working properly.

I don't think (at this time) this is a power supply issue, unless it
was underpowering the via controller on the MB.   The via drives don't
don't successfully get setup as /dev/sdx and the promise connected 
drives do get properly setup and appear to be just fine.

I get this failure under 2.6.23.1, I know fc7 2.6.22-9 fails, and I 
don't know if any previous kernel ever worked as I have just installed
these disks.

This is with an Asus K8V SE deluxe motherboard, and the bios is the
latest from Asus's site.   I have tried both with and without the
raid bios on and it does not seem to matter.

I have tried with the drive jumpers in default mode, and with
the drive jumpers forced to 1.5Gb. and with spread spectrum 
enabled/disabled.    What is really odd is that the disks don't
always even spin up when connected to the via controller (even
with that disk being the only 500 in the system), but always
spin up when connected to the promise controller.

I could be that my via controller is just broken.

Any ideas on how to debug further?

The messages that I get are (and this is mostly consistent over
a number of tries though sometimes inserting the drive results in
it failing to spinup at all and results in the SATA link being down).

ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 20
ACPI: PCI interrupt for device 0000:00:0f.0 disabled
sata_via 0000:00:0f.0: version 2.3
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
sata_via 0000:00:0f.0: routed to hard irq line 10
scsi7 : sata_via
scsi8 : sata_via
ata8: SATA max UDMA/133 cmd 0x0001e800 ctl 0x0001e402 bmdma 0x0001d400 
irq 17
ata9: SATA max UDMA/133 cmd 0x0001e000 ctl 0x0001d802 bmdma 0x0001d408 
irq 17
ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.00: ATA-1:   C WDWCASAAJS6320FA0, , max PIO2
ata8.00: 538976288 sectors, multi 0: LBA NCQ (depth 0/1)
ata8.00: applying bridge limits
ata8.00: model number mismatch '  C WDWCASAAJS6320FA0' != 'WDC 
WD5000AAJS-22YFA0         02WD    50'
ata8.00: revalidation failed (errno=-19)
ata8.00: limiting speed to PIO1
ata8: failed to recover some devices, retrying in 5 secs
ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.00: model number mismatch '  C WDWCASAAJS6320FA0' != 'WDC 
WD5000AAJS6320FA0'
ata8.00: revalidation failed (errno=-19)
ata8.00: disabled
ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata9.00: qc timeout (cmd 0xec)
ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata9: port is slow to respond, please be patient (Status 0xd0)
ata9.00: qc timeout (cmd 0xec)
ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata9.00: limiting speed to UDMA7:PIO5
ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata9: port is slow to respond, please be patient (Status 0xd0)
ata9.00: qc timeout (cmd 0xec)
ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata9: port is slow to respond, please be patient (Status 0xd0)
ata9: EH pending after completion, repeating EH (cnt=4)
