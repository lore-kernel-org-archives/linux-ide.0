From: Frans Pop <elendil@planet.nl>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 06:47:26 +0200
Message-ID: <200906210647.27964.elendil@planet.nl>
References: <200906202352.33894.elendil@planet.nl> <20090620.171945.140676687.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:54364 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbZFUEr0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Jun 2009 00:47:26 -0400
In-Reply-To: <20090620.171945.140676687.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Sunday 21 June 2009, David Miller wrote:
> From: Frans Pop <elendil@planet.nl>
> Date: Sat, 20 Jun 2009 23:52:33 +0200
>
> > ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
> > (serialized) irq 14: nobody cared (try booting with the "irqpoll"
> > option) Call Trace:
>
> Try reverting this patch:
>
> commit 6b5cde3629701258004b94cde75dd1089b556b02
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Mon Dec 29 20:27:32 2008 +0100
>
>     cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646

Yes, that was my suspect too (see the later mail I sent).
I'll give your partial revert a try.

> Alternatively you can try using the pata_cmd64x.c driver instead :-)

Well, that's not yet available in current Debian kernels. I did test 
pata_cmd64x once (way back in July 2007, when Alan Cox requested it), but 
have not used it since as I normally run distro kernels on the box.
When I build the custom kernel with your patch I'll activate it and give 
it a try again.

Thanks,
FJP
