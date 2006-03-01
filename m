From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: what is hdparm doing?
Date: Tue, 28 Feb 2006 20:22:21 -0700
Message-ID: <E1FEHuv-0004mb-VL@highlab.com>
References: <E1FED6T-0004a4-LN@highlab.com> <4404F89C.8040008@rtr.ca>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:14288 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932522AbWCADUW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 22:20:22 -0500
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1FEHuv-0004mb-VL
	for linux-ide@vger.kernel.org; Tue, 28 Feb 2006 20:22:21 -0700
In-reply-to: <4404F89C.8040008@rtr.ca> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mark Lord <liml@rtr.ca> wrote:
> Sebastian Kuzminsky wrote:
> > Hi folks, hdparm's got me confused.
> ..
> > "hdparm /dev/hda" says:
> .
> >             DMA: mdma0 mdma1 *mdma2
> >                  Cycle time: min=120ns recommended=120ns
> >             PIO: pio0 pio1 pio2 pio3 pio4
> >                  Cycle time: no flow control=120ns  IORDY flow control=120ns
> ..
> 
> The *mdma2 means, that if you were to issue a READ_DMA (or WRITE_DMA)
> command to the drive, the drive is expecting the host to use
> the multiword-dma-2 protocol and timings for it.
> 
> Meanwhile, the host may, at its option, simply use PIO commands (READ, WRITE)
> instead of DMA, any time it chooses.
> 
> Drives have both a DMA mode, and a PIO mode, each of which is selected
> and used independently of the other.

Ok thanks!

So how do I know what PIO mode the drive wants to use?

And how do I tell the HBA what PIO mode to use?

-- 
Sebastian Kuzminsky
