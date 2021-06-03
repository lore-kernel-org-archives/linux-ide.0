Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD45C47096
	for <linux-ide@archiver.kernel.org>; Thu,  3 Jun 2021 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4E06024A
	for <linux-ide@archiver.kernel.org>; Thu,  3 Jun 2021 08:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFCIaw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:30:52 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51050 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCIaw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jun 2021 04:30:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id BFB0F299E9;
        Thu,  3 Jun 2021 04:29:04 -0400 (EDT)
Date:   Thu, 3 Jun 2021 18:29:15 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] m68k: setup_mm.c: set isa_sex for Atari if
 ATARI_ROM_ISA not used
In-Reply-To: <ea80060f-983b-8adb-93f9-e2b84ea5f4b5@gmail.com>
Message-ID: <7ecc9c4e-3ee4-9cf7-a45d-fa84d5d2a62@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com> <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622611267-15825-3-git-send-email-schmitzmic@gmail.com> <CAMuHMdWhdSVCktaVZY+XHeyfeP8uw-RAcOWe--HsBn9Qf5_NOQ@mail.gmail.com>
 <ea80060f-983b-8adb-93f9-e2b84ea5f4b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, 2 Jun 2021, Michael Schmitz wrote:

> Hi Geert,
> 
> Am 02.06.2021 um 19:09 schrieb Geert Uytterhoeven:
> > Hi Michael,
> > 
> > On Wed, Jun 2, 2021 at 7:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > > For multiplatform kernels where CONFIG_ATARI_ROM_ISA is not set,
> > > at least isa_sex must be set correctly to allow for correct I/O
> > > primitive selection in shared drivers.
> > > 
> > > Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> > 
> > Thanks for your patch!
> > 
> > 
> > > --- a/arch/m68k/kernel/setup_mm.c
> > > +++ b/arch/m68k/kernel/setup_mm.c
> > > @@ -386,6 +386,10 @@ void __init setup_arch(char **cmdline_p)
> > >                 isa_type = ISA_TYPE_ENEC;
> > >                 isa_sex = 0;
> > >         }
> > > +#else
> > > +       if (MACH_IS_ATARI) {
> > > +               isa_sex = 0;
> > 
> > I find it strange that you set isa_sex, but not isa_type?
> 
> Yes, as I said this is only to ensure isa_sex has the correct value (0) so
> isa_readw() resolves to in_le16() for the Atari IDE driver after the change at
> the end of the first patch. Might have been better to rather say
> 
> int isa_sex=0;
> 
> at the start of setup_mm.c ... or rely on that variable being initialized as
> zero anyway.
> 
> > However, this is inside the CONFIG_ISA && MULTI_ISA block, so what 
> > kind of ISA does this correspond to?
> 
> No ISA at all in that case, but since we have to route all readw() calls 
> through isa_readw() for the sake of generality if we want to support Q40 
> ISA and Atari MMIO in the same kernel image, we need to make sure 
> isa_readw() does the right thing on Atari if CONFIG_ISA is set.
> 
> I know io_mm.h says it's about various ISA bridges, but as I found out, 
> drivers using only MMIO are also affected by these definitions.
> 
> 'Maze' does not begin to describe it, 'mess' might be getting closer, 
> but I can't see how we would avoid use of definitions in io_mm.h by 
> non-ISA drivers.
> 

It seems that the need for explicit zero initialization has more to do 
with subtelty over in asm/io_mm.h than anything else. If so, it would be 
better to add commentary there than to add redundant code here.

> Cheers,
> 
> 	Michael
> 
> > 
> > > +       }
> > >  #endif
> > >  #endif
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> 
