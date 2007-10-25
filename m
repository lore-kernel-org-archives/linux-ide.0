From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add a global ide=off switch for drivers/ide
Date: Fri, 26 Oct 2007 01:22:02 +0200
Message-ID: <200710260122.02663.ak@suse.de>
References: <200710151243.48577.ak@suse.de> <200710252307.23323.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44620 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbXJYXWG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 19:22:06 -0400
In-Reply-To: <200710252307.23323.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thursday 25 October 2007 23:07:23 Bartlomiej Zolnierkiewicz wrote:

> On Monday 15 October 2007, Andi Kleen wrote:
> > 
> > Had a situation where drivers/ide was compiled in, but I wanted to turn 
> > it off to let the drivers/ata drivers take over. I ended up using ide*=noprobe,
> > but that was somewhat clumpsy because I wasn't sure how many IDE interfaces
> > the machine really had.
> > 
> > Add a global ide=off switch to handle this situation better.
> 
> Overall looks OK but I think we should limit it to IDE built-in case
> (when IDE is modular it is all up to the user-space anyway).

Disagree. It's useful for the modular case too e.g. if you
have the ide modules in your initrd and you want to not load
them for some reason (e.g. debugging) 

Besides adding so many ifdefs would be ugly in my opinion.
> 
> > The patch is a little bigger because I tried to cover all modules.
> 
> A few still needs to be covered:
> - drivers/scsi/ide-scsi.c (other directory)
> - drivers/ide/legacy/ide_platform.c (new driver)
> - drivers/ide/legacy/ide-cs.c (late_initcall)
> - drivers/ide/pci/sgiioc4.c (ditto, not a SFF-PCI driver)

Thanks I'll fix those.

> > I'm also not 100% sure ENODEV is the right error return for this 
> > case, but I didn't come up with a better one.
> 
> -EPERM?  IMO it would be more appropriate (and easy to distinguish
> from the "real" -ENODEV).

Ok.

 
> > +int ide_off;
> > +EXPORT_SYMBOL(ide_off);
> > +
> 
> _GPL?
> 
> Please cover it with #ifdef/#endif CONFIG_BLK_DEV_IDE as it should be
> valid only when IDE is built-in.


> 
> This way we don't pollute device/host drivers with CONFIG_BLK_DEV_IDE #ifdefs.

What CONFIG_BLK_DEV_IDE ifdefs? I added the check only to code that is already
conditional to this I believe and there were no additional ifdefs at all.

-Andi
