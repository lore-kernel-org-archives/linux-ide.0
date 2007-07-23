From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide patches
Date: Tue, 24 Jul 2007 07:48:15 +1000
Message-ID: <1185227295.5439.131.camel@localhost.localdomain>
References: <200707222019.03684.bzolnier@gmail.com>
	 <1185148506.5439.80.camel@localhost.localdomain>
	 <1185153674.5439.83.camel@localhost.localdomain>
	 <1185155835.5439.91.camel@localhost.localdomain>
	 <46A4AA39.3030401@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34038 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256AbXGWVsc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 17:48:32 -0400
In-Reply-To: <46A4AA39.3030401@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> > Ok, there's a combination of things here:
> 
> >  - First, doing a set_pio from userland (hdparm -p XX) causes the kernel
> > to disable DMA, which I think is incorrect.
> 
>     That's the way ide_config_drive_speed() works.

And I still think that's bad.

> > It's not the case with 2.6.22 from my quick tests.
> 
>    Which means that PIO autotuning is broken there, i.e. that 
> ide_config_drive_speed() not called from the driver's tuneproc() method.

Yes, the driver uses it's own function which doesn't disable DMA
permanently, which is, IMHO, the way to go. I consider the current
behaviour a regression.

> > The problem is that ide_config_drive_speed
> > disables DMA, but only re-enables it when setting a DMA speed.
> 
>     It never "re-enables" DMA. ide_dma_host_on() method is not the same as 
> ide_dma_on() which actually enables DMA.

Ugh ? It re-enables DMA in the sense that if called to configure a DMA
speed, it re-enables dma on the host, thus effectively leaving with DMA
enabled.

> > I think
> > the whole idea of having a "current speed" is bogus here, we should have
> > a separate current DMA speed and current PIO speed. We should be able to
> > set the PIO timings without stopping DMA, toggling DMA is a separate
> > affair.
> 
>     Agreed completely.

Ah good :-)

Cheers,
Ben.


