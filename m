From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Add a global ide=off switch for drivers/ide
Date: Fri, 26 Oct 2007 02:05:50 +0200
Message-ID: <200710260205.50181.bzolnier@gmail.com>
References: <200710151243.48577.ak@suse.de> <200710252307.23323.bzolnier@gmail.com> <200710260122.02663.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:35602 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762517AbXJZAAB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 20:00:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so636846nfb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 16:59:59 -0700 (PDT)
In-Reply-To: <200710260122.02663.ak@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org

On Friday 26 October 2007, Andi Kleen wrote:
> On Thursday 25 October 2007 23:07:23 Bartlomiej Zolnierkiewicz wrote:
> 
> > On Monday 15 October 2007, Andi Kleen wrote:
> > > 
> > > Had a situation where drivers/ide was compiled in, but I wanted to turn 
> > > it off to let the drivers/ata drivers take over. I ended up using ide*=noprobe,
> > > but that was somewhat clumpsy because I wasn't sure how many IDE interfaces
> > > the machine really had.
> > > 
> > > Add a global ide=off switch to handle this situation better.
> > 
> > Overall looks OK but I think we should limit it to IDE built-in case
> > (when IDE is modular it is all up to the user-space anyway).
> 
> Disagree. It's useful for the modular case too e.g. if you
> have the ide modules in your initrd and you want to not load
> them for some reason (e.g. debugging) 

This argument sounds rather weak, you may want to not load any other
modules from your inird and you don't add "module=off" to them. :)

Besides the patch in the current form is buggy for the modular IDE
since __ide_pci_register_driver() is valid only when IDE is built-in
(please see how ide_pci_register_driver() is defined in ide.h) and
the patch depends on it to handle "ide=off" for IDE PCI host drivers.

[ No hard feelings wrt modular IDE support if the above issue gets fixed. ]

> > This way we don't pollute device/host drivers with CONFIG_BLK_DEV_IDE #ifdefs.
> 
> What CONFIG_BLK_DEV_IDE ifdefs? I added the check only to code that is already
> conditional to this I believe and there were no additional ifdefs at all.

I meant the case if we made "ide=off" valid only for built-in IDE
(then simply referencing ide_off in device/host drivers is incorrect
since ide_off is covered by CONFIG_BLK_DEV_IDE #ifdef/#endif).

Thanks,
Bart
