Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D55C5DF62
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4B321A49
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFku+IDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfKEVNd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:13:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36402 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfKEVNc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 16:13:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so4052330pgh.3;
        Tue, 05 Nov 2019 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4az5auxMPr3zKkYiQbDpmfJVD3Z71yi0JGIFUd30qY=;
        b=RFku+IDZ5XX3nj85XpCdCZk8ORp4v7hk11LWrFHY2UFm5FrdeAMQ9lYRmOL9ZuXFrz
         HT7BaLX4UOoz+aymiqj1d62A9PKtGbb6Xp7Ur97Zyof9HwU467yBpJv8YrwV9fxcKssa
         2/EF1SVrcPNBcn8jHBl0aj+PlhnrkM9kA8JUqb8sgRPnuqepctk7cHFwCKHsTn/sldFC
         uNWBiypHe0PFNh0FQ3qOOBd1pvRphGIAqiMXKObz6dVWadZxrcZgNO1aS5ddd99r9Z+d
         z9PT4xND6xq0oQrEUh+0L8EnMobyKYKKTw9U+USd+qGH4j19CWwn3dYYM2J2F/MJQjIP
         hFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4az5auxMPr3zKkYiQbDpmfJVD3Z71yi0JGIFUd30qY=;
        b=oyS/VnJ3sko7jAvityAHNHMHJNllBVsOnACgEbJlx7gqZejfYn3GyUoLntqHUFXOzd
         YBSLWHn9r39Pjr0rGgNY7dfKquD4C6U76Oqy+znK/6qU8u4OfmuPsO8/wJH5RhIfXich
         r/6Nr/uxjY1rauivMMFuc7sOQOStPno51CXFJm8Xis3wnMQalvnwmxnv607vU1N35R5f
         Y9jm1hDiuRkIlII1TvIJXa43UnC1fzvoVhD5b/p+crKvf80Wx8vsysf8zvVCDnn+VP4f
         FzxOQyf4pTp3sVL9XP9xYW3Vdet2rsqT4cgLUZv345g0UDD/A8Vt9Wkpb+e/oLLOMcBJ
         MeGg==
X-Gm-Message-State: APjAAAV+h60r8VTqNXszi76/oGiBl0Fm/MU7z5pL1CzsIN+nfO9pIz9d
        Pwf8t4eWGNSTYBnkQeGYfQqtsH3PvecGiQnsV2Y=
X-Google-Smtp-Source: APXvYqwU131WYihpxY00ZE3EhiqyIMt3GtJuq3j9YU8fQm8pnGiP5L1PWlVeBB4GB3DUYJg846l3vXQMCAoM5ZLl0U0=
X-Received: by 2002:a63:2c45:: with SMTP id s66mr39676839pgs.248.1572988411385;
 Tue, 05 Nov 2019 13:13:31 -0800 (PST)
MIME-Version: 1.0
References: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
 <1572935872-28394-1-git-send-email-schmitzmic@gmail.com> <CAMuHMdXM+h_GsbkSvyfpLJ0DJixmr-wOS_d5qQrZ8e7VY_bbPg@mail.gmail.com>
 <CAOmrzkKLosq7LdXS6BuvHSARPXCXPiasW1zGywY3+hoys4NxoA@mail.gmail.com>
 <CAMuHMdVBpMJ6E9N1=YG6VPNJifexdbM9=PWAkjyLwdz9b5n0YQ@mail.gmail.com> <CAOmrzk+-FD63N88MTE6993V8-Z96vXpAcB7yd33fftcj3ZebbA@mail.gmail.com>
In-Reply-To: <CAOmrzk+-FD63N88MTE6993V8-Z96vXpAcB7yd33fftcj3ZebbA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Wed, 6 Nov 2019 10:13:19 +1300
Message-ID: <CAOmrzkJ+tmEnYu4tz1Fvs8XJK2W_n9JWcFa7vpNLNy=SX2Yh1w@mail.gmail.com>
Subject: Re: [PATCH] ide: falconide: convert to platform driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Schmitz <schmitz@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,


> On Wed, Nov 6, 2019 at 7:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Shall I merge this one with part one of the old series so there's no
> > > chance of a bisection going wrong?
> >
> > Yes please.
> > Thanks!
>
> Thanks, I'll send a new version shortly.

Just confirming - the changes to pata_falcon.c will remain as a
separate patch which should be applied together with the patch that
will introduce the new platform device, and rewrite the legacy driver
to use it. That would require Bartlomiej and you to coordinate
closely.

If that's too onerous, I can merge the lot and you just ack the m68k
bits? Please let me know what you'd prefer.

Cheers,

    Michael
