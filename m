From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 15:05:39 -0400
Message-ID: <4634EC83.1030109@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca> <46349695.7080706@rtr.ca> <46349A03.9090300@rtr.ca> <4634CAEC.4010700@gmail.com> <4634CC18.4080208@rtr.ca> <4634E8B3.4050301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1414 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418AbXD2TFm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Apr 2007 15:05:42 -0400
In-Reply-To: <4634E8B3.4050301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

.. And here is another test of un-hacked 2.6.21,
this time for ata_piix with a pure PATA configuration.
Again, it passes with flying colours.


ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15
scsi0 : ata_piix
ata1.00: ATA-7: Maxtor 6Y160L0, YAR41BW0, max UDMA/133
ata1.00: 320173056 sectors, multi 16: LBA48 
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/66
ata2.01: ATAPI, max MWDMA2
ata2.00: configured for UDMA/66
ata2.01: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y160L0   YAR4 PQ: 0 ANSI: 5
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-111D 1.23 PQ: 0 ANSI: 5
scsi 1:0:1:0: CD-ROM            PLEXTOR  CD-R   PX-W1210A 1.08 PQ: 0 ANSI: 5

....

####### hdparm --drq-hsm-error /dev/sda:

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd ec/00:00:00:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 0 
         res 58/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

####### hdparm --drq-hsm-error /dev/cdrom:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a1/00:00:00:00:00/00:00:00:00:00/40 tag 0 cdb 0x1e data 0 
         res 58/00:02:00:00:02/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata2: soft resetting port
ata2.00: configured for UDMA/66
ata2.01: configured for MWDMA2
ata2: EH complete

