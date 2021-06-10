Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67416C48BCF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 01:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4894E611AE
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 01:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhFJBLB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 21:11:01 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:55818 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJBLB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 21:11:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 98B9B2A90B;
        Wed,  9 Jun 2021 21:08:51 -0400 (EDT)
Date:   Thu, 10 Jun 2021 11:09:09 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Andreas Schwab <schwab@linux-m68k.org>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org, alex@kazik.de
Subject: Re: [PATCH v1 1/2] m68k: io_mm.h - add APNE 100 MBit support
In-Reply-To: <e3643beb-7d61-e39f-83ca-f44a927b69db@gmail.com>
Message-ID: <c8306197-1342-6924-9d46-ba61f1ee7112@linux-m68k.org>
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com> <1623224214-4836-1-git-send-email-schmitzmic@gmail.com> <1623224214-4836-2-git-send-email-schmitzmic@gmail.com> <87zgvzzcp6.fsf@igel.home> <e3643beb-7d61-e39f-83ca-f44a927b69db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 10 Jun 2021, Michael Schmitz wrote:

> On 9/06/21 8:04 pm, Andreas Schwab wrote:
> > On Jun 09 2021, Michael Schmitz wrote:
> > 
> > > @@ -136,6 +141,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
> > >       case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
> > >   #endif
> > >   #ifdef CONFIG_AMIGA_PCMCIA
> > > +#ifdef CONFIG_APNE100MBIT
> > > +    case ISA_TYPE_AG16: fallthrough;
> > > +#endif
> > >       case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
> > Is the fallthrough annotation really needed?
> 
> Just to shut up compiler warnings, and even that I haven't seen myself.
> 
> I have seen a number of patches adding either comments or this annotation in
> the core NCR5380 driver (which Finn maintains, who suggested this annotation
> to an earlier version of the Q40/Atari io_mm.h patch), so adding annotations
> appears to be encouraged now.
> 
> I personally think these annotations are over the top generally, but I've
> learned to program when computed goto statements were still en vogue.
> 
> In this particular case, there can be no doubt that the fallthrough is
> intentional, so on balance, I'll remove those annotations as well (unless Finn
> strongly objects?).
> 

I don't object to removing it. On the contrary, in a previous message I 
also questioned adding this particular 'fallthrough' (though I did 
recommended adding a different one).

In general, there's no way to predict which static checkers are going to 
complain about any given line of code. They don't all agree about 
correctness and they are a moving target, just like fashion or reviewers' 
preferred code styles.

The 'fallthrough' that I recommended was merely the one that seemed to 
improve readability to my eyes (and not to some algorithm). I didn't 
actually run "make C=1 W=1" or any other checker.
