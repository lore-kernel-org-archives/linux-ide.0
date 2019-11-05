Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F8C47E49
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 18:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CCA21882
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 18:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390432AbfKESq4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:46:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45872 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389861AbfKESq4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 13:46:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id r24so2253237otk.12;
        Tue, 05 Nov 2019 10:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDXQ4NYDhbvIkO2N9a0H6kkv8JZAqw2a9q8F98PkJQk=;
        b=bHBd26uUGzd/0J5Nt4kkoafHYR8WSqu2nvfVAN61+QL3Ct5mC6/Mb6R8HN20Egtf1X
         GzpbdjAxgAQpWQEKWUdPaOUsCoyaemPwJtWjZRXWX143ZB3dV9Rb9ZKevfZ1YU1DkkHW
         FvulXMhxkDrmJ1NjTZHVOg6sfFl7v/ry11wV39jJAWbmLZEzsylpEghsWvgZpYDKBaij
         4eO6VcYRzIphpVuJWsFTchWR6ILJb5s9Yxc9vGfQdUesYMOLrnG9hufHGOci8Z2sOGTd
         Wq0xn45m9oBL3KjiR6LSh+7XC2UZOr5RWxKf0pq3FfrHLis/oqMPjEhXlI/eCsKLqQLg
         Hmdw==
X-Gm-Message-State: APjAAAXTd5I9PDIJXjm6Jt1ULGoojcMOkjsuXJDcNrsyp2ehV7DJGz7p
        RtJchLhF3knacf4J9BqD5pSLupRuEEtGoh3TrEE=
X-Google-Smtp-Source: APXvYqwYXAg4wK7+3+l1QrZyjm7KHJEkcUuk6KmcZkp24sSWkstIFrIu46Nj2hjpOMC5h4zkKMQ1M/LrN/280l8MzF4=
X-Received: by 2002:a05:6830:2363:: with SMTP id r3mr20773978oth.39.1572979615110;
 Tue, 05 Nov 2019 10:46:55 -0800 (PST)
MIME-Version: 1.0
References: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
 <1572935872-28394-1-git-send-email-schmitzmic@gmail.com> <CAMuHMdXM+h_GsbkSvyfpLJ0DJixmr-wOS_d5qQrZ8e7VY_bbPg@mail.gmail.com>
 <CAOmrzkKLosq7LdXS6BuvHSARPXCXPiasW1zGywY3+hoys4NxoA@mail.gmail.com>
In-Reply-To: <CAOmrzkKLosq7LdXS6BuvHSARPXCXPiasW1zGywY3+hoys4NxoA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Nov 2019 19:46:44 +0100
Message-ID: <CAMuHMdVBpMJ6E9N1=YG6VPNJifexdbM9=PWAkjyLwdz9b5n0YQ@mail.gmail.com>
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

On Tue, Nov 5, 2019 at 7:31 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On Tue, Nov 5, 2019 at 9:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Nov 5, 2019 at 7:38 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > > With the introduction of a platform device for the Atari Falcon IDE
> > > interface, the old Falcon IDE driver no longer loads (resource already
> > > claimed by the platform device).
> > >
> > > Convert falconide driver to use the same platform device that is used
> > > by pata_falcon also.
> > >
> > > Tested (as built-in driver) on my Atari Falcon.
> > >
> > > Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

> > > --- a/drivers/ide/falconide.c
> > > +++ b/drivers/ide/falconide.c

> > > @@ -23,6 +24,7 @@
> > >  #include <asm/ide.h>
> > >
> > >  #define DRV_NAME "falconide"
> > > +#define DRV_VERSION "0.1.0"
> >
> > Does anyone care about that version?
>
> Not likely.
>
> > Will it ever be updated?
>
> You ask me? You're still listed as driver author!

Yeah, I wrote a "it compiles, so it must work" driver in the IDE framework,
based on a driver in an even older framework. I never ran it on hardware ;-)

> > > @@ -169,10 +177,21 @@ static int __init falconide_init(void)
>
> Should I remove the __init here? Doesn't hurt in the built-in use
> case, what about use as a module?

Should be fine.

>
> > >  err_free:
> > >         ide_host_free(host);
> > >  err:
> > > -       release_mem_region(ATA_HD_BASE, 0x40);
> > > +       release_mem_region(res->start, resource_size(res));
> > >         return rc;
> > >  }
> > >
> > > -module_init(falconide_init);
> > > +static struct platform_driver ide_falcon_driver = {
> > > +       .driver   = {
> > > +               .name   = "atari-falcon-ide",
> > > +       },
> > > +};
> >
> > Missing .remove() callback.
>
> Can't easily test driver remove, but I can certainly add a callback for that.
>
> ide_unregister does the Right Thing (i.e. leaves the ST-DMA interrupt
> registered) so no reason why it shouldn't work.

gayle.c uses ide_host_remove().

> > > +
> > > +module_platform_driver_probe(ide_falcon_driver, falconide_init);
> > > +
> > >
> > > +MODULE_AUTHOR("Geert Uytterhoeven");
> > > +MODULE_DESCRIPTION("low-level driver for Atari Falcon IDE");
> > >  MODULE_LICENSE("GPL");
> > > +MODULE_ALIAS("platform:atari-falcon-ide");
> > > +MODULE_VERSION(DRV_VERSION);
> >
> > I'd drop the MODULE_VERSION().
>
> Done.
>
> Shall I merge this one with part one of the old series so there's no
> chance of a bisection going wrong?

Yes please.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
