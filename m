Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49711C4743E
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B775611BD
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 06:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHGon (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:44:43 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:34397 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHGom (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2021 02:44:42 -0400
Received: by mail-vs1-f50.google.com with SMTP id q2so2915463vsr.1;
        Mon, 07 Jun 2021 23:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uh8HVNA1CoHHn3gsvnYelJgEcLtS8VQWfCKOnvYkTR0=;
        b=QazluQD6dqkzEzIUbp0SjjoSLxvltr9MbzQDY7wdkV8ty6SZH7bBt1qYXQmFxMEjBP
         NLHklz4ZuEBzmNdEoQVMsO3tBDx5TRrc+6VA820j/x04kb1XDiwRArWB4pBdYg7GvTGH
         AytrfwOt0ew9NVbRzjrrT9TiTsbtslsbdqNrADBAaD/V1WkApCgTmvhE7bc98Kh+HoBh
         ImUNlZ0c9zPvAfssvwKkOkj30oO7MrER0FG1LvWxxY6DsmOg0gKVq+6hc4K3L+cVje+T
         L5BQTUWtOUFBQn3sWXJ8oKcwl90wn7B7E4qmBjyUPU3Ip8kGqLUbfPD7pUKcpSfre/2c
         koTA==
X-Gm-Message-State: AOAM533K0ptjqdREkKKd4jLKeA0CIcPvdQstDnoxOF0e4RBDbv7ocD3Q
        ejXPC/A28HEV9Bm+/oytCGOWJu2u1lb7D5yx6m8=
X-Google-Smtp-Source: ABdhPJw7FTOmF92eD7pkc9jfXU8xB1JoFwxiW8B5Z+8hEoMj937klVZqauirHweN/cDJG+B4SNp7f0sNyMOf9T1elAQ=
X-Received: by 2002:a05:6102:2011:: with SMTP id p17mr11257426vsr.40.1623134569719;
 Mon, 07 Jun 2021 23:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210605060447.GA18461@allandria.com> <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-2-git-send-email-schmitzmic@gmail.com> <CAMuHMdX1cD_zt6hU-6CUZi=uyYdk_xgW+hTCXvxSTRFPy_qn5w@mail.gmail.com>
 <b2943f57-396c-cfd7-7064-4a1351585fa3@gmail.com>
In-Reply-To: <b2943f57-396c-cfd7-7064-4a1351585fa3@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jun 2021 08:42:38 +0200
Message-ID: <CAMuHMdXDXSh2VkpFyFDXpPFDS+f2JGhU-x1gn2dTCSub=9gw8w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h - add APNE 100 MBit support
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        ALeX Kazik <alex@kazik.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Mon, Jun 7, 2021 at 9:58 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 7/06/21 11:15 pm, Geert Uytterhoeven wrote:
> > On Sun, Jun 6, 2021 at 7:54 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> Add code to support 10 Mbit and 100 Mbit mode for APNE driver.
> >>
> >> A new ISA type ISA_TYPE_AG100 switches the Amiga ISA inb accessor
> >> to word access as required by the 100 Mbit cards.
> >>
> >> Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
> >> 100 MBit card support" submitted to netdev 2018/09/16 by Alex
> >> Kazik <alex@kazik.de>.
> >>
> >> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> >> --- a/arch/m68k/include/asm/io_mm.h
> >> +++ b/arch/m68k/include/asm/io_mm.h
> >> @@ -212,13 +232,16 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
> >>   }
> >>
> >>
> >> -#define isa_inb(port)      in_8(isa_itb(port))
> >>   #define isa_inw(port)      (ISA_SEX ? in_be16(isa_itw(port)) : in_le16(isa_itw(port)))
> >>   #define isa_inl(port)      (ISA_SEX ? in_be32(isa_itl(port)) : in_le32(isa_itl(port)))
> >>   #define isa_outb(val,port) out_8(isa_itb(port),(val))
> >>   #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
> >>   #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) : out_le32(isa_itl(port),(val)))
> >>
> >> +/* for APNE 100 Mbit cards - hope the APNE 100 case will be eliminated as
> >> + * dead code if MULTI_ISA is not set */
> >> +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
> > This fails to compile due to a missing closing parenthesis.
>
> Sorry - looks like brown paper bag time today. (I did say 'entirely
> untested'? Didn't expect such a thorough review for a first RFC patch ...)

Sorry, I missed that part in the cover letter ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
