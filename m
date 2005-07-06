From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Wed, 6 Jul 2005 20:21:59 +0200
Message-ID: <20050706202159.5d353b72@basil.nowhere.org>
References: <20050706133052.GF21330@wotan.suse.de>
	<58cb370e050706070512c93ee1@mail.gmail.com>
	<20050706140933.GH21330@wotan.suse.de>
	<58cb370e05070607351fe5eced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57307 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262421AbVGFSWF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2005 14:22:05 -0400
In-Reply-To: <58cb370e05070607351fe5eced@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, christoph@lameter.com

On Wed, 6 Jul 2005 16:35:11 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On 7/6/05, Andi Kleen <ak@suse.de> wrote:
> > > drive->hwif check is redundant, please remove it
> > 
> > It's not. My first version didn't have it but it still crashed.
> > It's what actually prevents the crash.
> > I also don't know why, but it's true.
> 
> very weird as HWIF(drive) == drive->hwif:
> 
> 	ide_hwif_t *hwif = HWIF(drive);
> 
> ...
> 
> 	q = blk_init_queue_node(do_ide_request, &ide_lock,
> 				pcibus_to_node(drive->hwif->pci_dev->bus));
                                               ^^^^^^^^^^^^^^

I oops on that one. Maybe it takes the early return. 

> 	if (!q)
> 		return 1;
> 
> ...
> 
> 	if (!hwif->rqsize) {
> 
> you should OOPS here


I would appreciate if some form of this patch is merged asap because it breaks
booting on my test machines.

-Andi
