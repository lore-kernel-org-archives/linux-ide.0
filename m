Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F1C4708F
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 07:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5AB61405
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 07:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFDH41 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:56:27 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:42605 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhFDH41 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2021 03:56:27 -0400
Received: by mail-ua1-f52.google.com with SMTP id w5so4789648uaq.9;
        Fri, 04 Jun 2021 00:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFZRarEn438WqVAwH8CuVhNSuLb9OLw9t9DmZUYwag8=;
        b=cvvppxElnnl9Eqx1TGgHdRsLw55yj3/2UH+3rHD5YTqRh74b/crjZ/+0rlMrbcnvaG
         OwRKi4Qw1WFzakdpV4oKFpxKayIdrO+ePbZRFsTb7C8GyJIZadVYSclZmze7IkPZdH5A
         k7DLflw08a/JkA5JTyORWlkBctOlSvleZ9BlEK62EsnpAGU8GZX//4uSuWf99zbCJ5te
         C/iYqEYLwMrpTHB5GFcHSrfcrtwKqqrFXPwD3MVyG/HNGUxZ57yBRCMyEXhr+NxvJ9sa
         AnPSDMazaK3fPzAUzX1Xzn8x0W0F3CERBgSmJaeEET91+i1Pfi2CtK/msVj0ztO3oCfV
         rwJw==
X-Gm-Message-State: AOAM531uRpJiLo6pdsEASFInfq8IeCqlcjbKBrxeKhUSHCLz8JNH0TSL
        nRWLR3Pr8R50zxtkPnVn67uqLpIQObdbDjjxpCs=
X-Google-Smtp-Source: ABdhPJyzlgHq+vn5+jKQ0d98Gcqtt7cVokb6Dd/c8UX2ICEr0e8+8lhOGRr/BUqfnjPyFLLCa7F9Wy7lhUFx6O4d/IU=
X-Received: by 2002:ab0:26d8:: with SMTP id b24mr2244219uap.58.1622793280699;
 Fri, 04 Jun 2021 00:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org> <143313da-d294-f89b-d285-235230514c5a@gmail.com>
In-Reply-To: <143313da-d294-f89b-d285-235230514c5a@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Jun 2021 09:54:29 +0200
Message-ID: <CAMuHMdU5ebmsErLdy6EykCHNULsBVFCpVsz0H3gpTLUmH1tt7g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Fri, Jun 4, 2021 at 2:19 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 3/06/21 8:23 pm, Finn Thain wrote:
> > On Wed, 2 Jun 2021, Michael Schmitz wrote:
> >> --- a/arch/m68k/include/asm/io_mm.h
> >> +++ b/arch/m68k/include/asm/io_mm.h
> >> @@ -52,7 +52,11 @@
> >>   #define Q40_ISA_MEM_B(madr)  (q40_isa_mem_base+1+4*((unsigned long)(madr)))
> >>   #define Q40_ISA_MEM_W(madr)  (q40_isa_mem_base+  4*((unsigned long)(madr)))
> >>
> >> +#ifdef CONFIG_ATARI
> >> +#define MULTI_ISA 1
> >> +#else
> >>   #define MULTI_ISA 0
> >> +#endif /* Atari */
> >>   #endif /* Q40 */
> >>
> > I have to wonder whether there is a nice simple definition for MULTI_ISA.
>
> As I understand it, MULTI_ISA means that different byte orders and/or
> different address translations need to be used in the same kernel, so
> all that cannot be decided at build time.
>
> As long as there is only a single platform that will use this code (ISA
> only used on a single platform, and neither Atari IDE nor EtherNEC
> used), MULTI_ISA is not needed.
>
> If we have Kconfig symbols for 'single platform only', and
> 'multi-platform ISA use', that might be shorter to write and easier to
> understand. Geert?

It would be nice to have that automatically, like with the current
MULTI_ISA define (and all the MACH_* in arch/m68k/include/asm/setup.h).
Perhaps we should extend kconfig syntax to define a group of
related symbols, and to automatically generate CONFIG_FOO_MULTI or
CONFIG_FOO_SINGLE (and even CONFIG_BAR_ONLY?) symbols?

group ISA
     item ATARI_ROM_ISA
     item AMIGA_PCMCIA
     item Q40

=> CONFIG_ISA_MULTI or CONFIG_ISA_SINGLE (+ e.g. ATARI_ROM_ISA_ONLY
   if appropriate).

Are there other users who can benefit from this?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
