From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Thu, 23 Aug 2007 05:32:24 -0400
Message-ID: <46CD5428.5090003@garzik.org>
References: <200708182058.l7IKwrcJ016820@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48533 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761362AbXHWJc0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 05:32:26 -0400
In-Reply-To: <200708182058.l7IKwrcJ016820@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, albertl@mail.com

Mikael Pettersson wrote:
> Previously I reported that the pata_pdc2027x PLL detection changes
> in kernel 2.6.22 broke the driver on my PowerMac:
> 
>> pata_pdc2027x: Invalid PLL input clock 1691742kHz, give up!
> 
> This is followed by a number of errors and speed reduction
> steps on the affected ports.
> 
> There are two bugs in pata_pdc2027x's PLL detection code:
> 
> 1. The PLL counter's start value is read before the chip is
>    put in "test mode". Outside of test mode the counter is
>    halted, and on the PowerMac the counter is zero because
>    the chip hasn't been initialised by its BIOS.
> 
>    The fix is to move the read of the start value to after
>    test mode is started, but before the mdelay() in test mode.
>    This also improves the precision of the PLL detection.
> 
> 2. The code to compute the number of PLL decrements during the
>    mdelay() in test mode fails to consider that the PLL counter
>    only is 30 bits wide. If there is a wraparound, it will compute
>    an incorrect and much too large value. On the PowerMac, the
>    start count is zero, the end count is a large 30-bit value, so
>    wraparound occurs and an out of bounds PLL clock is detected.
> 
>    The fix is to mask the (start - end) computation to 30 bits.
> 
> While debugging this I also noticed that pdc_read_counter()
> reads the two halves of the 30-bit PLL counter as 16-bit values,
> and then combines them as if the halves only are 15 bits wide.
> To avoid confusion, the halves should be read as 15-bit values.
> 
> This patch implements all three changes. It fixes the PLL detection
> failure on my PowerMac, and doesn't cause any regressions on an x86
> with an identical card.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
>  drivers/ata/pata_pdc2027x.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)

applied


