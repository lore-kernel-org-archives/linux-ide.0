From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PIO with SSDs: needs a long DRQ-after-command timeout for WRITEs
Date: Wed, 31 Dec 2008 19:38:08 +0100
Message-ID: <200812311938.08916.bzolnier@gmail.com>
References: <495A27E3.50801@rtr.ca> <20081230135902.560267dc@lxorguk.ukuu.org.uk> <495B9DDD.2020109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:47046 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbYLaSjU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Dec 2008 13:39:20 -0500
Received: by bwz14 with SMTP id 14so18734370bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 31 Dec 2008 10:39:17 -0800 (PST)
In-Reply-To: <495B9DDD.2020109@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wednesday 31 December 2008, Mark Lord wrote:
> Alan Cox wrote:
> >> So.. how long does libata and current IDE allow for initial DRQ assertion?
> >> It should probably be at least 500msec or more now.
> > 
> > I think we need to rewrite the PIO code paths to use disable/enable_irq
> > masking first before getting into adding long delays on PIO paths.
> ..
> 
> Yeah, that would be a good thing to do.

Unless shared IRQs come into the picture -- in such case disabling IRQ
for 0.5sec doesn't sound too sexy...

> But in the meanwhile, a longer timeout there doesn't affect
> any currently working systems -- they'll still wait only as long
> as they currently do.  And a longer timeout *will* enable these
> SSDs to work where they otherwise would not.
> 
> But perhaps the timeout is already long enough?
> I don't know where the current timeout is hiding in libata.  :)

When it comes to IDE the timeout is defined by WAIT_DRQ in <linux/ide.h>
and is currently set to 100ms.  There should be no problem with increasing
it if it would help to get some devices to work (please just send a patch).

Thanks,
Bart
