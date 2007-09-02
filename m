From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CF as IDE on ICH6M using libata
Date: Sun, 2 Sep 2007 19:58:06 +0100
Message-ID: <20070902195806.3becceaa@the-village.bc.nu>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	<20070902150423.75687a98@the-village.bc.nu>
	<6f9550040709021141m1a76ed37n291274b06a9875fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42808 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751077AbXIBStd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 14:49:33 -0400
In-Reply-To: <6f9550040709021141m1a76ed37n291274b06a9875fe@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eddie Hung <eddie.hung@gmail.com>
Cc: linux-ide@vger.kernel.org

> In my research on this issue, I do remember coming across an
> announcement you made not so long ago regarding the libata.pata_dma
> command - however because of my revelations with Windows detailed at
> the end of my reply to tejun, I am curious as to whether MWDMA is
> really DMA at all? I also believe it runs at about the same speed as
> the top PIO speeds too?

MWDMA is DMA but MWDMA2 and PIO4 use the same data transfer rates - the
DMA modes make it easier to offload the processing. In fact MWDMA isn't
really needed - the Cyrix CS5520 and some other chipsets can do DMA in
the chipset up to MWDMA while talking PIO4 to the device.

But to answer the question - there is a real difference electrically
between MWDMA2 and PIO4

> I also know that my SATA-PATA arrangement is hardly ideal - but the
> controller, using the original HDD, supports udma5 - so I am wondering
> why it does not detect, and use, that with the CF card - this brings
> me back to the question I originally posed and tejun answered - is
> there any way to force it to use UDMA4 - because I know it is
> supported by the card?

If it is offered by the card it should be automatically selected. Can you
mail me the hdparm identify data for the drive ?
> 
> Also, the CF-IDE bridge is a cheap one (not that there were much
> choices) from ebay - and the documentation that comes with it states
> that it supports DMA - in which case is there any way I can verify
> that? What are the prerequisites for DMA support? (Do certain pins
> need to be connected, for example?)

For DMA certain pins must be connected correctly. For UDMA the entire
cable assembly including adapter must also meet very strict capacitance
and other loading requirements - few do, especially hung off the end of
cables.

