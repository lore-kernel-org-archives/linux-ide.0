Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3692DC4708F
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 05:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2572061413
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 05:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFDF5L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Jun 2021 01:57:11 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35096 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhFDF5K (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2021 01:57:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6C9CE29C9E;
        Fri,  4 Jun 2021 01:55:21 -0400 (EDT)
Date:   Fri, 4 Jun 2021 15:55:32 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
In-Reply-To: <143313da-d294-f89b-d285-235230514c5a@gmail.com>
Message-ID: <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com> <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622611267-15825-2-git-send-email-schmitzmic@gmail.com> <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 4 Jun 2021, Michael Schmitz wrote:

> of the Q40 branch and out of the later Amiga Gayle PCMCIA branch to the 
> head of the file and add a comment explaining the rationale? Too much 
> churn for now?
> 

Right, it could be too much churn for a bug-fix patch.

> > 
> > >   #ifdef CONFIG_AMIGA_PCMCIA
> > > @@ -135,9 +139,12 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
> > >       case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
> > >   #endif
> > >   #ifdef CONFIG_ATARI_ROM_ISA
> > > -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> > > +    case ISA_TYPE_ENEC: if (addr < 1024)
> > > +				return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> > > +			else
> > > +				return (u8 __iomem *)(addr);
> > There is some trailing whitespace added here that 'git am' complains
> > about.
> > 
> > Also, I think a 'fallthrough' statement would be better than adding a new
> > else branch that duplicates the new default case below.
> 
> I'm still unsure whether changing the default branch for the sake of 
> fixing Atari behaviour is a sane idea - I was hoping for comments either 
> way.
> 

You mean, what happens if a random m68k platform (other than amiga, atari 
and q40) were to adopt CONFIG_ISA? I guess it would be nice if that would 
'just work' but it's probably never going to be needed.

> But if it's changed, you are correct that having the control flow fall 
> through instead of taking a redundant else branch is better.
> 
> Essentially, changing that hunk to
> 
>  #ifdef CONFIG_ATARI_ROM_ISA
> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> +    case ISA_TYPE_ENEC: if (addr < 1024)
> +				return (u8 __iomem *)ENEC_ISA_IO_B(addr);
> 
> here (and elsewhere below)?
> 

I worry about the static checkers that look for missing 'fallthrough' and 
'break' statements. So I was thinking of something like this:

static inline u8 __iomem *isa_itb(unsigned long addr)
{
  switch(ISA_TYPE)
    {
#ifdef CONFIG_Q40
    case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
#endif
#ifdef CONFIG_AMIGA_PCMCIA
    case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
#endif
#ifdef CONFIG_ATARI_ROM_ISA
    case ISA_TYPE_ENEC: 
        if (addr < 1024)
            return (u8 __iomem *)ENEC_ISA_IO_B(addr);
        fallthrough;
#endif
    default: return (u8 __iomem *)(addr);
    }
}


Alternatively you could just move the default out of the switch:

static inline u8 __iomem *isa_itb(unsigned long addr)
{
  switch(ISA_TYPE)
    {
#ifdef CONFIG_Q40
    case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
#endif
#ifdef CONFIG_AMIGA_PCMCIA
    case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
#endif
#ifdef CONFIG_ATARI_ROM_ISA
    case ISA_TYPE_ENEC:
        if (addr < 1024)
            return (u8 __iomem *)ENEC_ISA_IO_B(addr);
        break;
#endif
    }
    return (u8 __iomem *)(addr);
}


The latter is probably the more flexible style because 'break' doesn't 
care about the order of case labels.
