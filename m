Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C82C47E49
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE921A49
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 21:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfKEVoJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:44:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46390 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729839AbfKEVoJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 16:44:09 -0500
Received: by mail-oi1-f195.google.com with SMTP id n14so3273938oie.13;
        Tue, 05 Nov 2019 13:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHJp/gsCCGSv6YRuEs26kifWiFNGdGIggYvod+/8t/g=;
        b=qTbvlpeyZCCVXSQahODR8aQzYYtdDW1czyOIQJcYDqpOoulHIsoONu/5CcJ1DtKQMz
         nvEiOqxfb00NRui/dfDJGyo94ziG3yP39isV9fGkfICBQTUzdzwzK2mnKAJSN3BJyWdP
         2rI3jnu2PoZ3S5vL5TgOOl7qjPjjB3hm2QHynzX3I36EBdnl/Uizt80/GwRQS+soMmOI
         ADearH3PzUoetCChmnPbqk1qQuFA8B/P3JYBkrupoZte1OYWAo+oGOCWu2aiYrBCHT8D
         VireumRT6Hy4C7p8QpywJQEojJNgkRKbv/0MbvkpCeVu+duz4df4MgbC+H4QlUQsqIiz
         9ZOg==
X-Gm-Message-State: APjAAAVTTmPLiGgl7QFphGQpNBye9p1YHapklXnpNGJfYiFM+ee3K50x
        5e0GnXo6U50JUpX+pEnUI4TAdfVEAcXmXLJwvhU=
X-Google-Smtp-Source: APXvYqz66qAFwLHpoSZ0PfJJ5r6VIpF1ae7jYQ7Z1mkTMm+HsIsypIMORETybgy5IZhXukA7909Xb6l5PrRGaMdOWSQ=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr970340oia.131.1572990246610;
 Tue, 05 Nov 2019 13:44:06 -0800 (PST)
MIME-Version: 1.0
References: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
 <1572935872-28394-1-git-send-email-schmitzmic@gmail.com> <CAMuHMdXM+h_GsbkSvyfpLJ0DJixmr-wOS_d5qQrZ8e7VY_bbPg@mail.gmail.com>
 <CAOmrzkKLosq7LdXS6BuvHSARPXCXPiasW1zGywY3+hoys4NxoA@mail.gmail.com>
 <CAMuHMdVBpMJ6E9N1=YG6VPNJifexdbM9=PWAkjyLwdz9b5n0YQ@mail.gmail.com>
 <CAOmrzk+-FD63N88MTE6993V8-Z96vXpAcB7yd33fftcj3ZebbA@mail.gmail.com> <CAOmrzkJ+tmEnYu4tz1Fvs8XJK2W_n9JWcFa7vpNLNy=SX2Yh1w@mail.gmail.com>
In-Reply-To: <CAOmrzkJ+tmEnYu4tz1Fvs8XJK2W_n9JWcFa7vpNLNy=SX2Yh1w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Nov 2019 22:43:55 +0100
Message-ID: <CAMuHMdU_HHw7i9gP1yC8w4BLDo9php6+_FXBsmL8Zr-+hvCptA@mail.gmail.com>
Subject: Re: [PATCH] ide: falconide: convert to platform driver
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Schmitz <schmitz@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Tue, Nov 5, 2019 at 10:13 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > On Wed, Nov 6, 2019 at 7:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > Shall I merge this one with part one of the old series so there's no
> > > > chance of a bisection going wrong?
> > >
> > > Yes please.
> > > Thanks!
> >
> > Thanks, I'll send a new version shortly.
>
> Just confirming - the changes to pata_falcon.c will remain as a
> separate patch which should be applied together with the patch that
> will introduce the new platform device, and rewrite the legacy driver
> to use it. That would require Bartlomiej and you to coordinate
> closely.

Bartlomiej already acked both patches, so they can go in through the m68k
tree.

To avoid bisection regressions, both patches should be merged into a
single patch...

> If that's too onerous, I can merge the lot and you just ack the m68k
> bits? Please let me know what you'd prefer.

... and with the falconide.c conversion, all three patches should be merged
into a single patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
