Return-Path: <SRS0=j7Np=Y4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C244CA9ECF
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 11:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FD5222C2
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 11:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfKDLEW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:04:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33427 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfKDLEW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Nov 2019 06:04:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id u13so14036254ote.0;
        Mon, 04 Nov 2019 03:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JsOl871X0kKz16edSR3lS8hZtNOWUkUDpyqOjBQZaX0=;
        b=fD84bfXRgZibmu1crOHQcHKpVoTnbNE2gO8Nz+Dc60w7lcT6FBe29uumehoWnhPO1+
         0RlepYC0xsIZ1aTQ1rGqFjDgYCQD6S3WtW5TusifBWdflSfWtkYqLtrNmy9/Ugh20V4e
         NVubSQSOafnnwdYmEvyohMZ1cfV3Otd0j0px8r+0KCnmUn8yZxuIZxmor5JRIa2GMRlQ
         jNbG+KGm/NWD4q/+K2v8OWMUBllKko2vUWuU/fD4RzpnYdzhk7q/hT3oSFVI5IMefnKX
         ruKZTu9cOeedlxUtZtnxRzBWRIq/PM8+ODG9kWxnQ9kIlhtvWLOQgbIIEWaohf/SBMk7
         N8ag==
X-Gm-Message-State: APjAAAU2WaEiXYeBH/72r8aCHnGjkLimui3ocLODKmHpYx2YBMHxQdTJ
        ATfAAjj1TKcPb6H2ITSanrlUJ2kjGTSNT7di6FI=
X-Google-Smtp-Source: APXvYqxav4hM5eDGKqJ4lDPQUpV311EuoAtDoeNmtgISoHuH9sJ6ssKQ/MtGNLy60K3vMOVDAIeOgIB+16nBjPhi4vU=
X-Received: by 2002:a9d:422:: with SMTP id 31mr17125100otc.107.1572865461312;
 Mon, 04 Nov 2019 03:04:21 -0800 (PST)
MIME-Version: 1.0
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk> <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
 <edb1ab21-9b60-4a25-b18c-76173ae6b28f@gmail.com>
In-Reply-To: <edb1ab21-9b60-4a25-b18c-76173ae6b28f@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 12:04:10 +0100
Message-ID: <CAMuHMdU6mcW_EcmE3bCTRGVCdouFPDoawTVyyGJP50oGES=duA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform device
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Mon, Oct 28, 2019 at 8:03 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 27.10.2019 um 07:17 schrieb Geert Uytterhoeven:
> >>
> >> Who's going to pick this one up? I can do it, but it'd be nice to have
> >> m68k on patch 1 first.
> >
> > Sorry for the late reply.  I'll have a closer look after ELC-E, and will apply
> > to the m68k tree if it passes.
> >
> > BTW, I believe v1 of both patches has been acked by Bartlomiej?
>
> Correct - on July 3rd. I totally forgot about that, and didn't add his
> Acked-by in v2, sorry.

OK.

I was about to queue the combined patch, until I realized the defconfigs
default to falconide, which is broken by patch 1/2.
My proposed solution for that is:
  1. Switch the defconfigs from falconide to pata_falcon,
  2. Remove the legacy falconide driver.

Does that sound OK? Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
