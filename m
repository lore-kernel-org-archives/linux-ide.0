From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Sun, 12 Apr 2009 11:10:45 -0400
Message-ID: <49E20475.1080409@rtr.ca>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca> <49C19087.5000307@gmail.com> <49C190F1.7010202@kernel.org> <49C28133.8050401@rtr.ca> <49C281A5.5080404@rtr.ca> <49C2D642.90706@kernel.org> <49C39690.6090802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55570 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbZDLPKr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Apr 2009 11:10:47 -0400
In-Reply-To: <49C39690.6090802@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> I need a way to limit the multi_count to a specific maximum
> value for sata_mv.  ISTR that some PATA chips may also have
> an upper hardware limit on multi_count.
> 
> Generally, "8" is safe for all chipsets.  Going above that
> requires knowledge of what the chipset can tolerate.
> 
> How about a u8 multi_count_max field in the ata_host struct?
> Use 0xff for "multi_count not allowed", and anything else
> in there as an upper limit for the chipset.
..
Alan Cox wrote:
>
> If its only one driver why not do it the way we do things like transfer
> length limits for LBA48 (see pata_it821x and others)
..

Okay, I've looked at pata_it821x.c now, and I just don't see it.
That particular driver seems to limit *all* transfers to 256 max,
not just those of a particular protocol, like mult-sect I/O.

Am I missing something there?

The limit for sata_mv chipsets seems to actually be 7-sectors or less
for read/write multiple.  Which means a max of 4 in practice.

Similarly, we should also be preventing *any* PIO of more than one DRQ
for sata_mv.  But I don't see a sensible way to do that either.

In practice, that part does seem to work fine with the PIO polling
that sata_mv uses.

But what to do about the read/write multiple issue ?

???
