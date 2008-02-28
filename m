From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Fri, 29 Feb 2008 00:33:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802290010320.10498@axis700.grange>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange>
 <20080228225603.2764bfd1@core>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39965 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759790AbYB1Xdz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 18:33:55 -0500
In-Reply-To: <20080228225603.2764bfd1@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, 28 Feb 2008, Alan Cox wrote:

> On Thu, 28 Feb 2008 23:37:36 +0100 (CET)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > Hi
> > 
> > just found out that the eSATA connector on my Intel DQ35JO motherboard 
> > doesn't work... because it is connected to the controller with product ID 
> > 29b6... And this ID is not yet handled by the driver. Can I have a patch, 
> > please?:-) I think the correct entry would be
> 
> If the device is in AHCI mode it should match the ahci class entry - is
> the device in AHCI mode or PIIX mode ?

Indeed! It was in "IDE" mode, and 2 out of the 3 chips were handled by the 
piix driver (btw, why did Intel put 3 different SATA controllers on one 
board?). I switched it to AHCI mode (the third possibility is RAID) and 
indeed a kernel with (only) ahci driver managed to bring them up! 
Although, the eSATA link was "slow to respond":

ata4: port is slow to respond, please be patient (Status 0x80)
ata4: softreset failed (device not ready)
ata4: port is slow to respond, please be patient (Status 0x80)
ata4: softreset failed (device not ready)
ata4: port is slow to respond, please be patient (Status 0x80)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7: WDC WD1600BB-00RDA0, 20.00K20, max UDMA/100
ata4.00: 312581808 sectors, multi 16: LBA48
ata4.00: applying bridge limits
ata4.00: configured for UDMA/100

but then it did manage it. Is such a delay normal?

One more question, what do UDMA numbers mean in SATA context? The internal 
SATA disk is "ata1.00: configured for UDMA/133", but should be SATA-2.

Thanks
Guennadi
---
Guennadi Liakhovetski
