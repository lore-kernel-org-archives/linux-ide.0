From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_cmd64x: Set up MWDMA modes properly
Date: Sat, 11 Aug 2007 21:44:39 +0100
Message-ID: <20070811214439.640b65e9@the-village.bc.nu>
References: <20070808143320.0de8c5d9@the-village.bc.nu>
	<46BE1452.4010603@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43746 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751162AbXHKUhS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Aug 2007 16:37:18 -0400
In-Reply-To: <46BE1452.4010603@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jeff@garzik.org

>     That function rocks (except I didn't get what the address setup timings 
> mean to SW/MW DMA)...

They don't, it merges the DMA and PIO ones and you end up with the PIO
ones.

> > + *	Used when configuring the devices ot set the PIO timings. All the
> 
>     What's "ot"?

to - will fix

> >  	regD |= 0x20 << adev->devno;
> 
>     Hm, is setting of "drive DMA capable" bits really needed in the driver. 
> Doesn't libata core itself do this?

For most hardware it doesn't matter. The CMD64x driver code I have all
bothers to set it. I don't know if its needed, someone with the bits
handy could find out I guess, but if we arent sure it does no harm.
