From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Libata VIA woes continue. Worked around - *wrong*
Date: Sun, 29 Aug 2004 12:17:15 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4131910B.6020000@wasp.net.au>
References: <412F3DEA.2070307@wasp.net.au> <41318680.8080102@wasp.net.au> <41318C87.9010806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:26767 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S267330AbUH2IQj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Aug 2004 04:16:39 -0400
In-Reply-To: <41318C87.9010806@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:

> 
> Well, there are some cases on a few controllers (SiI is one that comes 
> to mind) where -- IIRC -- bridges dictate the max is UDMA/100, not 
> UDMA/133, even if the underlying device is UDMA/133.
> 
> In sata_promise.c or sata_via.c, what happens if you change udma_mask 
> from 0x7f to 0x3f?  Do the failures go away?

These drives are UDMA/100. On the VIA controller I changed the udma_mask to 0x1f and the failures 
"appeared" to go away but that was before I realised the exact nature of the failure mode. (That 
being it will either fail on bootup, or very soon after or it will work perfectly until the next boot)

I can always hook the drives up and hammer them if you'd like me to do further testing but I'm not 
sure how we can then let libata know that the drives connected need to be slowed down as we can't 
identify we have a bridge connected really.

I'm still not convinced that it's not something else.
Sure transfers > 200 sectors killed it on the VIA controller at UDMA/100 while they appeared to work 
ok at UDMA/66. I guess I need to run a defined array of tests.

- Large transfers (> 200) at UDMA/100 and UDMA/66
- Small transfers (<=200) at UDMA/100 and UDMA/66
- Something like 10 reboot cycles of each.

It's very hard to hit on the Promise controller (Perhaps < 10% of reboots) while on the VIA 
controller it happens maybe 60% of the time.

And of course 2.6.5 never hits it at all. (And given I patched the VIA driver in 2.6.9-rc1 to keep 
transfers < 200 sectors and still hit the bug it's not that!)

>> Cross that bridge if we come to it I guess.
> 
> 
> Guffaw ;-)

Oh bugger.. I had not even realised what I said! :p) (Slow news day obviously)

Regards,
Brad
