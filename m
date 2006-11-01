From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Fun with HPT302N (Rocket Raid 1520 PCI card)
Date: Wed, 01 Nov 2006 04:32:56 -0500
Message-ID: <454869C8.9000103@pobox.com>
References: <23724.1161684269@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:998 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946727AbWKAJc7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 04:32:59 -0500
In-Reply-To: <23724.1161684269@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

David Howells wrote:
> Hi Jeff,
> 
> Do you have a SATA driver for the HPT302N chipset (as found on a Rocket Raid
> 1520 PCI card)?
> 
> The PCI ID maps to PCI_DEVICE_ID_TTI_HPT302, but it's revision 2, so that'd
> make it the HPT302N according to the comments in the pata_hpt37x.c and
> pata_hpt3x2n.c drivers.
> 
> It would seem that the pata_hpt3x2n.c driver handles it - but by the driver's
> name it would seem to be for driving a PATA interface, not a SATA interface.
> If I compile that driver in, it does indeed find the device:
> 
> 	hpt3xn: BIOS clock data not set.
> 	ata3: PATA max UDMA/133 cmd 0xE4000820 ctl 0xE400082A bmdma 0xE4000C00 irq 20
> 	ata4: PATA max UDMA/133 cmd 0xE4000830 ctl 0xE400082E bmdma 0xE4000C08 irq 20
> 	scsi2 : pata_hpt3x2n
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ata3.00: qc timeout (cmd 0xec)
> 	ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 	ATA: abnormal status 0x7F on port 0xE4000827
> 
> And seems to think that it's a PATA interface, which is not what I see looking
> at the card itself.  I'm not sure what's going on with the failure to IDENTIFY,
> but it doesn't actually have any drives attached at the moment.  I'll have to
> get a SATA drive to plug into it to see what happens.


I think the newer HPTs present a pata_hpt*.c compatible interface, even 
though the card is driving SATA devices.

Other than that, I know nothing at all about the hardware :(  Alan would 
know a lot more.

	Jeff


