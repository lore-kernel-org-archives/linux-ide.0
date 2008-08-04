From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Mon, 4 Aug 2008 22:43:09 +0100
Message-ID: <20080804224309.77ffd28e@lxorguk.ukuu.org.uk>
References: <fa.OGeO7gZvBG4obEzRbVltjSebgTQ@ifi.uio.no>
	<fa.KtvYE2B2yrJqUleolhtMPN9ljAQ@ifi.uio.no>
	<fa.AqEKTvguYFAzDFHy/We/8MpOqmo@ifi.uio.no>
	<48976168.3020804@shaw.ca>
	<20080804205508.20a3f917@lxorguk.ukuu.org.uk>
	<48977AE1.1070402@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42860 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762892AbYHDWBF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 18:01:05 -0400
In-Reply-To: <48977AE1.1070402@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

> > newer controllers support the 32bit PIO data cycles. Most PCI controllers
> > it makes no speed difference but host bus controllers (especially
> > PIIX/ICH) really benefit.
> >   
> 
>     In what way if there's no speed gain?

As in the numbers are the same before and after. The FIFO on the
controller is happily hiding the extra latencies I assume.

> >> supported. I couldn't track down where that bit was actually defined in 
> >> the first place, all the way back to ATA-1 it seems to be indicated as 
> >> reserved. Actually, I'm not sure why the drive cares in the first place, 
> >> it would seem like a pure host controller issue..
> >>     
> >
> > It goes back before IDE into the depths of the original compaq spec. When
> > you have a device wired basically directly to the ISA bus (original IDE)
> >   
> 
>    ISA has only 8/16-bit data bus, so it could not have mattered 
> there... 

Depends what a 32bit I/O looks like on the 16bit bus - timing wise.
