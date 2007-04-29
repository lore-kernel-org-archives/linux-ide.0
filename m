From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 14:49:23 -0400
Message-ID: <4634E8B3.4050301@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca> <46349695.7080706@rtr.ca> <46349A03.9090300@rtr.ca> <4634CAEC.4010700@gmail.com> <4634CC18.4080208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3777 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030800AbXD2St0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Apr 2007 14:49:26 -0400
In-Reply-To: <4634CC18.4080208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> Can you please perform similar test on a native PATA device connected to
>> native PATA controller?  I'm curious whether SRST makes real silicons
>> forget about the on-going command.
> 
> I'll dig through some other hardware here and see what I have.

Here's the first results, with sata_via and pata_via:  no issue.
This was tested without the fifo-flush hack.  Logs are below.

If anyone else is feeling brave, I've just put hdparm-7.2 up on sourceforge.net,
with a new VERY DANGEROUS command-line flag:

    hdparm --drq-hsm-error  /dev/whatever

This will issue an IDENTIFY (or PACKET_IDENTIFY) as a "non data" command
to the device of your choice, and you can then just sit back and watch
the fireworks.  The flag is clearly marked as "VERY DANGEROUS",
but seems to be quite safe here now that I've patched my kernel with the hack.

Note that it does a "sync(); sleep(1);" before issuing the fated command.

Cheers

----------------------


sata_via 0000:00:0f.0: version 2.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
sata_via 0000:00:0f.0: routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0x0001d800 ctl 0x0001d402 bmdma 0x0001c400 irq 16
ata2: SATA max UDMA/133 cmd 0x0001d000 ctl 0x0001c802 bmdma 0x0001c408 irq 16
scsi0 : sata_via
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ATA: abnormal status 0x7F on port 0x0001d807
ATA: abnormal status 0x7F on port 0x0001d807
ata1.00: ATA-6: HDS722512VLSA80, V33OA63A, max UDMA/100
ata1.00: 241254720 sectors, multi 16: LBA48 
ata1.00: configured for UDMA/100
scsi1 : sata_via
Switched to high resolution mode on CPU 0
ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x0001d007
scsi 0:0:0:0: Direct-Access     ATA      HDS722512VLSA80  V33O PQ: 0 ANSI: 5
SCSI device sda: 241254720 512-byte hdwr sectors (123522 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 241254720 512-byte hdwr sectors (123522 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
pata_via 0000:00:0f.1: version 0.2.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 16
ata3: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001fc00 irq 14
ata4: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001fc08 irq 15
scsi2 : pata_via
ATA: abnormal status 0x8 on port 0x000101f7
scsi3 : pata_via
ata4.00: ATAPI, max UDMA/66
ata4.00: configured for UDMA/66
scsi 3:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-111D 1.23 PQ: 0 ANSI: 5
scsi 3:0:0:0: Attached scsi generic sg1 type 5
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
....

###### Test stuck DRQ on VIA-sata (disk):

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/00 tag 0 cdb 0x0 data 0 
         res 58/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata1: soft resetting port
ATA: abnormal status 0x7F on port 0x0001d807
ATA: abnormal status 0x7F on port 0x0001d807
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 241254720 512-byte hdwr sectors (123522 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA


###### Test stuck DRQ on VIA-pata (ATAPI DVD/RW):
###### Notice how the first "ata4.00: cmd ..." line is *missing*:

         res 58/00:02:00:00:02/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata4: soft resetting port
ata4.00: configured for UDMA/66
ata4: EH complete

