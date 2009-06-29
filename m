From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: porting IDE patches to PATA driver
Date: Mon, 29 Jun 2009 15:53:49 +0100
Message-ID: <20090629155349.1574e492@lxorguk.ukuu.org.uk>
References: <323951117.20090625100956@web.de>
	<20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>
	<14164712.20090625103834@web.de>
	<20090625100542.525dba02@lxorguk.ukuu.org.uk>
	<951976828.20090625123021@web.de>
	<20090625122958.510c28ad@lxorguk.ukuu.org.uk>
	<96179821.20090626152440@web.de>
	<20090626144639.4bc822b8@lxorguk.ukuu.org.uk>
	<792909512.20090626164052@web.de>
	<20090626172143.3fe6a59c@lxorguk.ukuu.org.uk>
	<596875090.20090629140157@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35398 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752688AbZF2OwM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jun 2009 10:52:12 -0400
In-Reply-To: <596875090.20090629140157@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

> you are right. I'm working with multiple sources from different sites
> and missed the fact the original driver ide-jasper.c published at
> uclinux.org has BMDMA undefined. Dmegs output was produced using a
> slightly modified version of the file that has BMDMA defined, but
> there are no other changes in it that would explain unexpected DMA
> interrupt mystery, it should be one of the patches done to ide and
> cdrom subsystem.

Still odd as it never sets the timings for anything but UDMA mode. I
guess it could be that the hardware snoops for MWDMA and PIO modes

> Here is an updated patch, could you please check it? I don't see
> anything unusual except the "never disable DMA" logic in ide_dma.c.

Which itself appears to be ignored !

The only other thing I can see is the way it hangs around waiting a bit
for the DMA to finish after the DMA completion event occurs - that might
be your problem if they goofed and reported DMA complete too early.

Hard to tell as the original vendor driver is such a mess.
