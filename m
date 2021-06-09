Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A40C48BCD
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 06:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BA361183
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 06:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhFIGff (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:35:35 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:41844 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhFIGff (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 02:35:35 -0400
Received: by mail-vs1-f46.google.com with SMTP id c1so5859598vsh.8;
        Tue, 08 Jun 2021 23:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huztDeh1iQpGlwwTvC3NoL5RKEn6PGXwfnOsLXt4nb8=;
        b=Enm9aAtkHtxne7Ike/UeTgjmAGmorBlgtwOkOY9fXJEuR6Ez9JTHQ+L/Mhiu8h+5aJ
         BabC+Q5C5lnByUAh5R4zkCPRzGhYymStKw2kSdmHgraJAXKfc1ef2Tppb07dN1WLpvpC
         7e83WU8367nB2onpgFc8nLJpdZYRWgqVXPLj28lslwodHshxRF66LO6ydg4vOX/nCVb/
         LbcL2lJDB/TMncSVoQy8YdjfNnzVn5nxivnSetR/SLs3PKGIS/tKgM0zeiPnXAeK7MXU
         jtNesn57fY/RdoFSKO+5FneMI/O1NX6bMQpHJYtSowOhuZ5htR7Ip/UYPsOvqYMfqV8m
         BzsA==
X-Gm-Message-State: AOAM531UwyZ8EcKKZXtI5xE8lyWiijmpc3R1zPtQt2Z2Lj2XxHciQpfV
        uCdDfliVnRe8s2C3jkPt5SijDN8SL8Hu/ECuwQ8=
X-Google-Smtp-Source: ABdhPJzB7Cs+b8Z1kfWQNgkZNq1KP4O4dykkE/wf6X7patiQV4rmWAHf+pXvRkl0aSCpDwx00nqOucanjtW6ggWI6yU=
X-Received: by 2002:a67:f106:: with SMTP id n6mr3772029vsk.40.1623220410597;
 Tue, 08 Jun 2021 23:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210605060447.GA18461@allandria.com> <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-2-git-send-email-schmitzmic@gmail.com> <CAMuHMdX1cD_zt6hU-6CUZi=uyYdk_xgW+hTCXvxSTRFPy_qn5w@mail.gmail.com>
 <b2943f57-396c-cfd7-7064-4a1351585fa3@gmail.com> <CAMuHMdXDXSh2VkpFyFDXpPFDS+f2JGhU-x1gn2dTCSub=9gw8w@mail.gmail.com>
 <602d8eed-dcad-33db-3b64-d099c2f33503@gmail.com>
In-Reply-To: <602d8eed-dcad-33db-3b64-d099c2f33503@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 08:33:19 +0200
Message-ID: <CAMuHMdW5DE3+KzCp5AS9fT9BaKLufCPa2hjj2e8xNyChoB0Otw@mail.gmail.com>
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

On Tue, Jun 8, 2021 at 11:55 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 8/06/21 6:42 pm, Geert Uytterhoeven wrote:
> > +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
> >>> This fails to compile due to a missing closing parenthesis.
> >> Sorry - looks like brown paper bag time today. (I did say 'entirely
> >> untested'? Didn't expect such a thorough review for a first RFC patch ...)
> > Sorry, I missed that part in the cover letter ;-)
>
> I'll put it more prominently next time.
>
> Ran all patches through checkpatch now, and I still get warnings and
> even a few errors ('trailing statements should be on the next line').
> All due to my keeping to the code style used in io_mm.h, as far as I
> could see.
>
> What's your preference - additions in new style, or keep the old style?

Please use the existing style, unless you're willing to modernize the
whole file in a separate patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
