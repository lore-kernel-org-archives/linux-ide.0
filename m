From: Matej Kupljen <matej.kupljen@norik.com>
Subject: Re: DMA support for CF
Date: Wed, 19 Dec 2012 09:32:53 +0100
Message-ID: <50D17BB5.1010205@norik.com>
References: <50D0264C.1010907@norik.com> <50D0E750.6070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out-2.mail.amis.net ([212.18.32.14]:47266 "EHLO
	out-2.mail.amis.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab2LSIkL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2012 03:40:11 -0500
In-Reply-To: <50D0E750.6070406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: geomatsi <geomatsi@gmail.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, nicolas.ferre@atmel.com, linux-ide@vger.kernel.org

Hi,

thank you for you answers, see my comments/questions below.

> In the future could you please consider sending your questions to a
> proper kernel mail list cc-ing authors/maintainers if necessary.

Sorry for that, I'll do that in the future.

> As you noted, driver pata-at91 does not have dma support. This is
> because originally it has been developed for a board based on
> at91sam9260 chip which has no dma engine. More recent at91 chips
> (including at91sam9263) do have dma engines. It should be possible to
> add dma support to pata-at91 driver and use dma transfers for CF.

I started adding this support to pata-at91 and I got to the point
where I can see that DMARQ pin from CF is getting asserted, so
the DMA could start.
Basically, I am not sure, hot to configure the DMA controller.
Should the DMARQ pin be connected to HDMAC perepherial?
What about DMACK pin? There is no DMACK signal from HDMAC.
What Handshaking Interface should I select?
Hardware handshaking, Software handshaking or Peripheral interrupt
handshaking?


> A couple of notes regarding at91sam9263:
>
> 1. DMA driver
> IIRC at91sam9263 chip has a different dma engine than all the other
> chips of at91 family. More recent chips have HDMAC:
> drivers/dma/at_hdmac.c while at91sam9263 has DWDMA: drivers/dma/dw_dmac.c

Yes, I found that after I managed to somehow support this controller
with the at_hdmac.c, since I didn't find any reference to
"Synopsys DesignWare DMA Controller" in the documentation.


> 2. Size of dma transfers
> IIRC there is a problem with dma engine on at91sam9263 chip: it has
> significantly reduced block size for transfers. This leads into a fairly
> small max transfer size in a single block transfer. As a result, it
> might not be practical to use this particular dma engine for CF.

O.K., but still. The DMA support would be beneficial for other AT91
chips, with better DMA controller, wouldn't it?

I know, that my question are basically about configuring DMA controller,
but I haven't found any answers in the documentation (I have checked
also the docs for SAM9R/RL and SAM9G) and have not found my answers.
I tried contacting the authors but didn0t get any answers.
Maybe, posting to this list would help.

Thank you once again and Regards,
Matej Kupljen

