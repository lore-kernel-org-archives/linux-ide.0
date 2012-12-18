From: geomatsi <geomatsi@gmail.com>
Subject: Re: DMA support for CF
Date: Tue, 18 Dec 2012 21:59:44 +0000
Message-ID: <50D0E750.6070406@gmail.com>
References: <50D0264C.1010907@norik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:44011 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab2LRSad (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2012 13:30:33 -0500
Received: by mail-la0-f43.google.com with SMTP id z14so854427lag.16
        for <linux-ide@vger.kernel.org>; Tue, 18 Dec 2012 10:30:31 -0800 (PST)
In-Reply-To: <50D0264C.1010907@norik.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matej Kupljen <matej.kupljen@norik.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, nicolas.ferre@atmel.com, linux-ide@vger.kernel.org

On 12/18/2012 08:16 AM, Matej Kupljen wrote:
> Dear Sergey and Jeff,

> I have a board based on AT91SAM9263, with the CF connected to
> the EBI0 and I am using the pata-at91.c driver.
>
> My question is, can I use DMA (MWDMA and/or UDMA) for the CF card,
> of course, if I add support to the driver?
> Basically, the question is, can we use the HDMAC (DMA controller)
> to support the DMA transfers?
> Please note that the DMARQ and DMACK are connected from CF to SoC.
>
>
> I've been looking for this in the documentation, and I cannot find the
> answer. Considering that the SAM9263 is considered legacy, I have
> checked the documentation for AT91SAM9R/RL and AT91SAM9G and I couldn't
> find the answer there either.
>
> Can you answer this question, please?
> If not, to whom I should send it?
>
> Thank you and Best Regards,
> Matej Kupljen

Hi,

In the future could you please consider sending your questions to a 
proper kernel mail list cc-ing authors/maintainers if necessary.


As you noted, driver pata-at91 does not have dma support. This is 
because originally it has been developed for a board based on 
at91sam9260 chip which has no dma engine. More recent at91 chips 
(including at91sam9263) do have dma engines. It should be possible to 
add dma support to pata-at91 driver and use dma transfers for CF.

A couple of notes regarding at91sam9263:

1. DMA driver
IIRC at91sam9263 chip has a different dma engine than all the other 
chips of at91 family. More recent chips have HDMAC: 
drivers/dma/at_hdmac.c while at91sam9263 has DWDMA: drivers/dma/dw_dmac.c

2. Size of dma transfers
IIRC there is a problem with dma engine on at91sam9263 chip: it has 
significantly reduced block size for transfers. This leads into a fairly 
small max transfer size in a single block transfer. As a result, it 
might not be practical to use this particular dma engine for CF.

Thanks,
Sergey
