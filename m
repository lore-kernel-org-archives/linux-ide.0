Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE3C433B4
	for <linux-ide@archiver.kernel.org>; Mon, 26 Apr 2021 07:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C201613E3
	for <linux-ide@archiver.kernel.org>; Mon, 26 Apr 2021 07:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhDZHhA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:37:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:42142 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhDZHgZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Apr 2021 03:36:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 182C620306;
        Mon, 26 Apr 2021 03:35:40 -0400 (EDT)
Date:   Mon, 26 Apr 2021 17:35:45 +1000 (AEST)
From:   Finn Thain <fthain@fastmail.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
In-Reply-To: <12ca8e6e-de1d-fe8d-a27d-b3a6c3581d50@gmail.com>
Message-ID: <3de9a93d-2f7-a650-1fa-c2129a4a765b@nippy.intranet>
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au> <12ca8e6e-de1d-fe8d-a27d-b3a6c3581d50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 26 Apr 2021, Michael Schmitz wrote:

> Am 25.04.2021 um 21:06 schrieb Finn Thain:
> > This was tested on my Quadra 630. I haven't tested it on my PowerBook 150
> > because I don't have a RAM adapter board for it.
> >
> > Apparently, the hardware I tested doesn't need macide_clear_irq() or
> > macide_test_irq() -- if it did, the generic driver would not have worked.
> > It's possible that those routines are needed for the PowerBook 150 but
> > we can cross that bridge if and when we come to it.
> >
> > BTW, macide_clear_irq() appears to suffer from a race condition. The write
> > to the interrupt flags register could easily have unintended side effects
> > as it may alter other flag bits. Fortunately, all of the other bits are
> > unused by Linux. Moreover, when tested on my Quadra 630, that assignment
> > (*ide_ifr &= ~0x20) was observed to have no effect on bit 5.
> 
> You are worried that the bit clear might not be done atomic?
> 

The edge-triggered interrupt flag bits are usually cleared by writing 1 to 
the flag bit. Under this scheme, writing a 0 to a flag bit has no effect.

The assignment statement here is trying to clear bit 5 by writing 0. But 
what about the other bits that we're writing 0 to? Some of them may also 
be flag bits, and they may have been asserted in between the load and 
store. AFAICS this scheme just can't work for edge-triggered interrupts.

So perhaps this is a level-triggered interrupt?

> Regarding the missing effect of clearing bit 5, I suspect this has never 
> before been tested rigorously (I don't remember ever using a Quadra 
> 630). 
> 
> The logic attempted to replicate what the MacOS IDE driver did. 

Fair enough. Maybe we have found a bug in the MacOS IDE driver.

> The Linux IDE driver has its own way to test and clear a port's 
> interrupt flag, so this extra code can quite probably go.
> 
> Thanks for cleaning this up!
> 
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> 

Thanks for your review.
