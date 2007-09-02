From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Sun, 2 Sep 2007 20:14:52 +0100
Message-ID: <6f9550040709021214p1c18078eg78e3fb1983d23560@mail.gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	 <20070902150423.75687a98@the-village.bc.nu>
	 <6f9550040709021141m1a76ed37n291274b06a9875fe@mail.gmail.com>
	 <20070902195806.3becceaa@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:47957 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXIBTOz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 15:14:55 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1173328fkz
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 12:14:53 -0700 (PDT)
In-Reply-To: <20070902195806.3becceaa@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On 02/09/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > In my research on this issue, I do remember coming across an
> > announcement you made not so long ago regarding the libata.pata_dma
> > command - however because of my revelations with Windows detailed at
> > the end of my reply to tejun, I am curious as to whether MWDMA is
> > really DMA at all? I also believe it runs at about the same speed as
> > the top PIO speeds too?
>
> MWDMA is DMA but MWDMA2 and PIO4 use the same data transfer rates - the
> DMA modes make it easier to offload the processing. In fact MWDMA isn't
> really needed - the Cyrix CS5520 and some other chipsets can do DMA in
> the chipset up to MWDMA while talking PIO4 to the device.
>
> But to answer the question - there is a real difference electrically
> between MWDMA2 and PIO4
>
> > I also know that my SATA-PATA arrangement is hardly ideal - but the
> > controller, using the original HDD, supports udma5 - so I am wondering
> > why it does not detect, and use, that with the CF card - this brings
> > me back to the question I originally posed and tejun answered - is
> > there any way to force it to use UDMA4 - because I know it is
> > supported by the card?
>
> If it is offered by the card it should be automatically selected. Can you
> mail me the hdparm identify data for the drive ?
> >
> > Also, the CF-IDE bridge is a cheap one (not that there were much
> > choices) from ebay - and the documentation that comes with it states
> > that it supports DMA - in which case is there any way I can verify
> > that? What are the prerequisites for DMA support? (Do certain pins
> > need to be connected, for example?)
>
> For DMA certain pins must be connected correctly. For UDMA the entire
> cable assembly including adapter must also meet very strict capacitance
> and other loading requirements - few do, especially hung off the end of
> cables.
>
>

Hello Alan,

I sent a reply to the list with the data that tejun asked for before I
replied to you - I guess you haven't got it (yet?). I'll forward it to
you once I finish this e-mail.

The CF-IDE adaptor is plugged straight into the header - and as far as
I can tell it doesn't do anything fancy (e.g. there are no ICs on
there) - but simply maps the pins from the CF slot to the IDE
connector. As such, its effect should be minimal...

Eddie
