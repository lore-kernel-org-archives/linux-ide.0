From: Tigran Aivazian <tigran@veritas.com>
Subject: Re: question about SATA and IDE DVD/CD drives.
Date: Fri, 2 Jul 2004 16:56:44 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0407021656110.2190-100000@einstein.homenet>
References: <40E5857E.2030308@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colossus.systems.pipex.net ([62.241.160.73]:2201 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264656AbUGBP6J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 11:58:09 -0400
In-Reply-To: <40E5857E.2030308@superbug.demon.co.uk>
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Ok, thanks, chaps, I'll try again now and see if the solution you propose
works. I'll let you know in either case.

Kind regards
Tigran

On Fri, 2 Jul 2004, James Courtier-Dutton wrote:

> Jeff Garzik wrote:
> > Tigran Aivazian wrote:
> > 
> >> Hi Jeff,
> >>
> >> I was a bit confused with the "SATA vs IDE" thing recently, namely the 
> >> fact that if I compile _both_ IDE and SATA support into the kernel 
> >> then IDE takes over and SATA gets a "busy" error, and as a result I 
> >> get 3M/sec performance instead of 56M/sec.
> >>
> >> Now, realizing this error I have reconfigured the kernel to NOT 
> >> include ide and ONLY include SATA plus chipset-specific ata_piix.c (I 
> >> have ICH6 device 2652). However, now the new problem is that I can't 
> >> see the IDE DVD-ROM drive anymore. Here is dmesg:
> > 
> > [...]
> > 
> >> As you see, sda is there, but where is my DVD drive gone?
> > 
> > 
> > I am guessing that your DVD drive is connected to a PATA bus, but you 
> > disabled the PATA driver (CONFIG_IDE) completely.
> > 
> > Enable CONFIG_IDE, and disable CONFIG_BLK_DEV_IDE_SATA, and that will 
> > fix things I bet.
> > 
> >     Jeff
> > 
> > 
> 
> For some strange reason, you need the PATA HD driver compiled into the 
> kernel, together with the SATA driver compiled into the kernel.
> Then SATA takes the HDs, and the PATA HD driver is used to identify the 
> DVD drive, and thus you can then load the PATA CD module, or the 
> IDE-SCSI module to access the DVD drives.
> 
> I have a ICH5 chipset, so I had exactly the same problems as you.
> The strange bit is needing the PATA HD driver compiled into the kernel, 
> even though you only need PATA CD/DVD drivers.
> 
> Cheers
> James
> 

