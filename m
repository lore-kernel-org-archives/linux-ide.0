From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATA drivers in libata?
Date: Thu, 17 Feb 2005 12:11:48 +1100
Message-ID: <1108602708.5382.9.camel@gaston>
References: <420FA1B9.6030100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from gate.crashing.org ([63.228.1.57]:3229 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262067AbVBQBMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2005 20:12:15 -0500
In-Reply-To: <420FA1B9.6030100@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>

On Sun, 2005-02-13 at 13:51 -0500, Jeff Garzik wrote:
> I wanted to open a discussion on libata and PATA.
> 
> libata-dev now has two drivers that support PATA, pata_pdc2027x and 
> ata_piix, and the core is getting close (DMA blacklist in, C/H/S support 
> close).
> 
> What are the opinions on issues relating to making PATA libata support 
> available in the upstream kernel?  Here's my random list.
> 
> * I think CONFIG_IDE should continue to be the default answer for "what 
> driver do I use for PATA?"

Yes.

> * Should there be a config option similar to CONFIG_BLK_DEV_IDE_SATA, 
> called CONFIG_SCSI_ATA_PATA?  A runtime 'pata' module option?  Should we 
> include 'DANGER DANGER conflicts with CONFIG_IDE' in the Kconfig 
> description?

Eventually... I'm thinking I may port the "macio" IDE to libata one day,
but for now, I still need both drivers/ide for it and libata for SATA.

> * With ATA passthru (in libata-dev currently), libata supports SMART and 
> the HDIO_CMD/HDIO_TASK generalized ioctls.  Should I care about 
> supporting other ioctls?
> 
> * pci_enable_device() issues?
> 
> * power management differences?

Well, libata doesn't have power management proper at all for now. In
fact, I need to do something at the generic SCSI level similar to what I
did for drivers/ide, that is turning the PM callbacks into requests down
the queues etc... but I don't have any SCSI or libata HW that can power
manage at the moment, so I didn't quite bother yet.

(Though if I ported "macio" IDE ... )

Ultimately, it will have to be done for things like USB & firewire too
anyway. So maybe I should start working on this soonish. I talked a bit
with jejb at OLS a year or 2 ago about the way to do it, it shouldn't be
that much different than what I do in drivers/ide, but then, I know
pretty much nothing about the linux scsi layer...

Ben.
 

