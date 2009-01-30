From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: DMA breakage in 2.6.29-rc*
Date: Fri, 30 Jan 2009 22:07:58 +1100
Message-ID: <1233313678.18767.25.camel@pasglop>
References: <1233294371.18767.23.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49012 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbZA3LIG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 06:08:06 -0500
In-Reply-To: <1233294371.18767.23.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>

On Fri, 2009-01-30 at 16:46 +1100, Benjamin Herrenschmidt wrote:
> Hi Bart !
> 
> On a bunch of pmac's, I'm getting lost interrupts when trying to do DMA
> with ide hard disks (first time at boot when reading the partition
> table). It then times out, reverts to PIO and boots fine.
> 
> Haven't had time to fully bisect yet, but it seem to be somewhere in the
> pile of IDE patches (surprise :-) that went in around that time.
> 
> I'll dig more next week, but in the meantime, I though you may have a
> possible candidate in mind.

Smells like the patch that popped up not long ago already (can't find
the thread now) where you cleaned up the port registration and broke our
trick of passing a different parent device than the one used for DMA or
something like that ... that mixed with something not testing the dma
map results (probably my fault) and I think we are passing crap DMA
addresses to the device.

I'll sort it out. I should be able to just add working dma ops to the
macio_device, it's a lot easier now that ppc32 has the same dma ops
structure in struct device as ppc64.

Cheers,
Ben.


