Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95224C5DF62
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEDD21925
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0Qj1PNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbfKESbe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:31:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41454 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390482AbfKESbe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 13:31:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id d29so3538452plj.8;
        Tue, 05 Nov 2019 10:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YoZQhBP3HIfluuLXPlaF9LqczYVSkwkePRkTZv8ugw=;
        b=W0Qj1PNCxSSkcOdJj3Zq28X5xyJ/3PEEaPLAREukfWBdgI5kKAKaBKTezI1CqCzcF1
         Al3DthymfSkv4dPf4V/2mGhttXohbaMBqUpi7+BKioCC6wtrCRklrZXU2M4jrPj7Smqt
         Mmv6kqDWsA7Yw11Bi/oRiRPsOfbYVrxR91a+WAKwayNF1MCQMBjAZbvhtLxDpHMVPwmx
         7FcFinU5XzZVV7J+8B5G2dHfKTpwfKy+9oHHV53KWaKswBoHO+v0vvFmhRJXTSH2wFFK
         9Hzy+vhwL2Lbp0B1ieeCPzrzXcLhmjhxRPgHHYIRJi1ZYPSaINjRKuypQI57n3j82VYR
         oJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YoZQhBP3HIfluuLXPlaF9LqczYVSkwkePRkTZv8ugw=;
        b=m7a8wKlgaKdum5F2ikSjGVp8zf7fr4staZeI2W2BIif6bAMD/NtKlkQrAsAlpvFEPm
         SNwNXWhQeX431XwT1vB6Gk4Vt72ahmjeFswXxHAr4osVbpLOqyMdymS8rekofr5hx3S4
         viZ/bYIlZ4vstNcGFHcWJtMV7AicDoJMQNUIQmbKkPJC6usV+SZOqTjSh4BKAqWAK0BS
         aENTsE/osZr/baUORehDosnhnZ8/BqAR70t48Nx08VtXfh9Xk2937Ie1/zULNaJIl6Nr
         q8bvm3toCljB9EJzS+rwIba4YhqOiuio1XArVLceICSnu0jqtLCJNkoT+TFqh0UpGUv0
         k9hg==
X-Gm-Message-State: APjAAAX3zhLyO1Uy/ijiBGNKop3SsgdrJWKXHH3EI6Rd5gR5nsD5mHqa
        GXXJzoFHMoYlDGwRt553qCYlEbzyvG6s//UHiCg=
X-Google-Smtp-Source: APXvYqwwuQLwkXMMofgqIXmwHQapHSmF2ttoN6z42y9XvPFdassSxAno8+A+9Bobed/y2QBnqMhhwgyPiWcSdqCx1Rs=
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr32309658plk.276.1572978692618;
 Tue, 05 Nov 2019 10:31:32 -0800 (PST)
MIME-Version: 1.0
References: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
 <1572935872-28394-1-git-send-email-schmitzmic@gmail.com> <CAMuHMdXM+h_GsbkSvyfpLJ0DJixmr-wOS_d5qQrZ8e7VY_bbPg@mail.gmail.com>
In-Reply-To: <CAMuHMdXM+h_GsbkSvyfpLJ0DJixmr-wOS_d5qQrZ8e7VY_bbPg@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Wed, 6 Nov 2019 07:31:21 +1300
Message-ID: <CAOmrzkKLosq7LdXS6BuvHSARPXCXPiasW1zGywY3+hoys4NxoA@mail.gmail.com>
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

thanks for the review!

On Tue, Nov 5, 2019 at 9:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Michael,
>
> On Tue, Nov 5, 2019 at 7:38 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > With the introduction of a platform device for the Atari Falcon IDE
> > interface, the old Falcon IDE driver no longer loads (resource already
> > claimed by the platform device).
> >
> > Convert falconide driver to use the same platform device that is used
> > by pata_falcon also.
> >
> > Tested (as built-in driver) on my Atari Falcon.
> >
> > Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> > CC: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Thanks for your patch!
>
> > --- a/drivers/ide/falconide.c
> > +++ b/drivers/ide/falconide.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/blkdev.h>
> >  #include <linux/ide.h>
> >  #include <linux/init.h>
> > +#include <linux/platform_device.h>
> >
> >  #include <asm/setup.h>
> >  #include <asm/atarihw.h>
> > @@ -23,6 +24,7 @@
> >  #include <asm/ide.h>
> >
> >  #define DRV_NAME "falconide"
> > +#define DRV_VERSION "0.1.0"
>
> Does anyone care about that version?

Not likely.

> Will it ever be updated?

You ask me? You're still listed as driver author!

I'll remove the version.

>
> > @@ -169,10 +177,21 @@ static int __init falconide_init(void)

Should I remove the __init here? Doesn't hurt in the built-in use
case, what about use as a module?

> >  err_free:
> >         ide_host_free(host);
> >  err:
> > -       release_mem_region(ATA_HD_BASE, 0x40);
> > +       release_mem_region(res->start, resource_size(res));
> >         return rc;
> >  }
> >
> > -module_init(falconide_init);
> > +static struct platform_driver ide_falcon_driver = {
> > +       .driver   = {
> > +               .name   = "atari-falcon-ide",
> > +       },
> > +};
>
> Missing .remove() callback.

Can't easily test driver remove, but I can certainly add a callback for that.

ide_unregister does the Right Thing (i.e. leaves the ST-DMA interrupt
registered) so no reason why it shouldn't work.

>
> > +
> > +module_platform_driver_probe(ide_falcon_driver, falconide_init);
> > +
> >
> > +MODULE_AUTHOR("Geert Uytterhoeven");
> > +MODULE_DESCRIPTION("low-level driver for Atari Falcon IDE");
> >  MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:atari-falcon-ide");
> > +MODULE_VERSION(DRV_VERSION);
>
> I'd drop the MODULE_VERSION().

Done.

Shall I merge this one with part one of the old series so there's no
chance of a bisection going wrong?

Cheers,

    Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
