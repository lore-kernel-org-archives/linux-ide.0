Return-Path: <SRS0=j7Np=Y4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ABBC47E49
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 20:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1853D20869
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfKDUGO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:06:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45940 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKDUGO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Nov 2019 15:06:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so11103918oti.12;
        Mon, 04 Nov 2019 12:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4qbCO6b+EddwK63iiWuHjAl6ARaEUL6F3uMnifVRXU=;
        b=JF52UDaFoL4h87m03J0ltuILfd1YF/egO7SCzZWrYe5vXnWYBKmjasPSiXtUaJwP/6
         6cGpySohkLmr0n4qDSgxHwTlIAsfDDbntJLVT93pw6uZLbAnoD699ZaRPJnYc9LF3GyK
         caieuwGhZeNnpxpGVbb4Myh401mCcjXC0mctdhRwwqejygIDyA/uNJTNzBFZHcCMjwKp
         ccR4EXSNapTzxb8DWvkGj3h3WeHD398He6Oh7cxnJCRu9875FHC1U0jQPM3AwFE60Rn8
         9PsxQpzwIqXUTdRQHbRJ4Rx/RtYQNFAdXPoTzM1+4jP1D0nyC3RsL35AWMuK0O3NfsGQ
         1l9w==
X-Gm-Message-State: APjAAAVEA6pEjVNKHbzYuTD7wuOePsnkTSfyIg/2tJ5R9Fjdcgk1QWBE
        SoVr2Wrg92p+xXF+6XxSHL1YCicDAG8e57pHWYA=
X-Google-Smtp-Source: APXvYqwy9jIkfgZ2H6H7qJdG15+5FXdq6XazJwbYBQy9j0WfJhB7rWwooYyQYonowR4ww2BSIIXv6IGOgZkPWyPM58I=
X-Received: by 2002:a05:6830:210e:: with SMTP id i14mr5610181otc.250.1572897973465;
 Mon, 04 Nov 2019 12:06:13 -0800 (PST)
MIME-Version: 1.0
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk> <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
 <edb1ab21-9b60-4a25-b18c-76173ae6b28f@gmail.com> <CAMuHMdU6mcW_EcmE3bCTRGVCdouFPDoawTVyyGJP50oGES=duA@mail.gmail.com>
 <db487366-b0d7-d65d-70b5-261aa439298b@gmail.com>
In-Reply-To: <db487366-b0d7-d65d-70b5-261aa439298b@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 21:06:02 +0100
Message-ID: <CAMuHMdVJmT5xMGpyK3hm3j7OX7asjz2U4=+=B4SaGtqVDnxiHw@mail.gmail.com>
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

On Mon, Nov 4, 2019 at 8:17 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 5/11/19 12:04 AM, Geert Uytterhoeven wrote:
> > On Mon, Oct 28, 2019 at 8:03 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> Am 27.10.2019 um 07:17 schrieb Geert Uytterhoeven:
> >>>> Who's going to pick this one up? I can do it, but it'd be nice to have
> >>>> m68k on patch 1 first.
> >>> Sorry for the late reply.  I'll have a closer look after ELC-E, and will apply
> >>> to the m68k tree if it passes.
> >>>
> >>> BTW, I believe v1 of both patches has been acked by Bartlomiej?
> >> Correct - on July 3rd. I totally forgot about that, and didn't add his
> >> Acked-by in v2, sorry.
> > OK.
> >
> > I was about to queue the combined patch, until I realized the defconfigs
> > default to falconide, which is broken by patch 1/2.
> > My proposed solution for that is:
> >    1. Switch the defconfigs from falconide to pata_falcon,
>
> Ack.
>
> >    2. Remove the legacy falconide driver.
>
> Nack - I still use that one (because pata_falcon has no support for
> using interrupts with the Falcon IDE interface, and I'm unsure how much
> more kernel bloat libata will add). Need to check the impact of
> switching to pata_falcon first.

Oh, I forgot about that.
So yes, in that case pata_falcon is not a viable alternative yet.
However, that means we can only avoid regressions by converting
falconide to the new platform device, too, and doing that together, atomically,
with your 2 patches in this series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
