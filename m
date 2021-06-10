Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB328C47094
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 07:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2C1613C1
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 07:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFJHe0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:34:26 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:40933 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhFJHeZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2021 03:34:25 -0400
Received: by mail-vs1-f42.google.com with SMTP id b1so1343885vsh.7;
        Thu, 10 Jun 2021 00:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdGJLD0xMRGMgyQF1c4UXbWGQ2I6telSHqN2LHSb7rA=;
        b=MinX2JY9WfiSnzvQXnwdXnXXKz2KD3ULu7bprQzo2lj9XXwAHk2cGAZh6XWiOxnLxl
         RFuO+uUikdHwkdkWrqNFfOnX+W7Flfau+bqXSo9Uf9DKIy2Ml49yt98FS6hs1R8ZEnzK
         GNUe86CPk40Ali+thVnX0aef6uVrpvHpPyMx/ueczqIt7YVuNJCcJl/mNB4Kz5nQqaL6
         IcTQtB9kAYUxIihlM/OtBS9pqti1W26BCmh8fSQrNl9q4j87QfKwCTabw4UDTQcwI1cl
         VHSbkzvTvs/FT/g9dga8fjlP+bVCv2lBEtfc+CEr9ZbhJrCfauy0UUmSyPqIRXnGnuu9
         Qs9w==
X-Gm-Message-State: AOAM531kiuNVAFpQVy5C5GmAubm/DUOEfzTx+0iR3GRisf6XIT8gtYxR
        qEfE0fJE2FUuSCGRTC3KKrSgzEz2LfKnXG3O8is=
X-Google-Smtp-Source: ABdhPJzDrUH4euPzGbK01E5oUeCXoIQZpVU9Y5ema5ViscqKJrpuQuc9YumPb7XKf41xrT0hMCxEHMGx0HVahwgNTr4=
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr3304703vss.18.1623310349028;
 Thu, 10 Jun 2021 00:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1623224214-4836-1-git-send-email-schmitzmic@gmail.com> <1623224214-4836-2-git-send-email-schmitzmic@gmail.com>
 <87zgvzzcp6.fsf@igel.home> <e3643beb-7d61-e39f-83ca-f44a927b69db@gmail.com> <c8306197-1342-6924-9d46-ba61f1ee7112@linux-m68k.org>
In-Reply-To: <c8306197-1342-6924-9d46-ba61f1ee7112@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Jun 2021 09:32:17 +0200
Message-ID: <CAMuHMdVGoUhs3N3bdOQ2OxQa+69LcK0YOG2HASbFNhD4Qpc2+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] m68k: io_mm.h - add APNE 100 MBit support
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, ALeX Kazik <alex@kazik.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On Thu, Jun 10, 2021 at 3:09 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Thu, 10 Jun 2021, Michael Schmitz wrote:
> > On 9/06/21 8:04 pm, Andreas Schwab wrote:
> > > On Jun 09 2021, Michael Schmitz wrote:
> > >
> > > > @@ -136,6 +141,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
> > > >       case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
> > > >   #endif
> > > >   #ifdef CONFIG_AMIGA_PCMCIA
> > > > +#ifdef CONFIG_APNE100MBIT
> > > > +    case ISA_TYPE_AG16: fallthrough;
> > > > +#endif
> > > >       case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
> > > Is the fallthrough annotation really needed?
> >
> > Just to shut up compiler warnings, and even that I haven't seen myself.
> >
> > I have seen a number of patches adding either comments or this annotation in
> > the core NCR5380 driver (which Finn maintains, who suggested this annotation
> > to an earlier version of the Q40/Atari io_mm.h patch), so adding annotations
> > appears to be encouraged now.
> >
> > I personally think these annotations are over the top generally, but I've
> > learned to program when computed goto statements were still en vogue.
> >
> > In this particular case, there can be no doubt that the fallthrough is
> > intentional, so on balance, I'll remove those annotations as well (unless Finn
> > strongly objects?).
> >
>
> I don't object to removing it. On the contrary, in a previous message I
> also questioned adding this particular 'fallthrough' (though I did
> recommended adding a different one).
>
> In general, there's no way to predict which static checkers are going to
> complain about any given line of code. They don't all agree about
> correctness and they are a moving target, just like fashion or reviewers'
> preferred code styles.

AFAIK, they only complain when the switch() operates on an enum,
and not all enum values are handled.

When operating on an int, there's not enough address space on
32-bit machines to handle all cases ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
