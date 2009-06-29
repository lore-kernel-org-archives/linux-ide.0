From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: porting IDE patches to PATA driver
Date: Mon, 29 Jun 2009 13:31:53 +0100
Message-ID: <20090629133153.2370f1a3@lxorguk.ukuu.org.uk>
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
	<4A47D382.2080308@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55647 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752749AbZF2Maw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jun 2009 08:30:52 -0400
In-Reply-To: <4A47D382.2080308@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrei Martynov <andrei.martynov@web.de>, linux-ide@vger.kernel.org

> > 	iowrite8(tf->command, ap->ioaddr.command_addr);
> > 	if (tf->flags & ATA_TFLAG_DEVICE)
> > 		iowrite8(tf->device & ~ATA_DEV1, ap->ioaddr.device_addr);
> >   
> 
>   Note that this possibly violates ATA specs that forbid writing to any 
> register with BSY set -- which might well be after wroiting a command, 
> despite 400 ns couldn't have passed yet. IOW, I don't advice such 
> trickery -- your write may well  be ignored.

As far as I can make out from the discussion of the device that write
goes to the magic hardware and puts it back into normal ATA mode not to
the device. I guess it may be going to both though.

Wacky hacks for wacky hardware
