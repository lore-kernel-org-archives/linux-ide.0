Return-Path: <SRS0=07Tt=DB=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2158BC2D0E2
	for <linux-ide@archiver.kernel.org>; Thu, 24 Sep 2020 07:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7A8235F7
	for <linux-ide@archiver.kernel.org>; Thu, 24 Sep 2020 07:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgIXHVd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Sep 2020 03:21:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39943 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgIXHVc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Sep 2020 03:21:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so2666492oif.7;
        Thu, 24 Sep 2020 00:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiXSRRV3D/hx3Tqji6VNTmS+jCoI6Pp2GgFTTxvZRBQ=;
        b=fmJJY7WJB7fBnFKrVm9ORy3BW9OM8ULy6TmE82G8R17Hlmqw7ttO1ewv1tijb6QrYh
         Ca66dDBJGSsOR1w+WwUGfqqWK7bxQk2bcy1saM3+tmWoaJ/FpA5yEGMFUQyoY577tcz3
         GhWyqyimZfyJ0BF8So5HAQm0y2mLcQ/F2AMhfzDuSuQ3xjEaD5czfPDA/C6+4TuIjkTC
         B+f0FH5Gj8FH9U4K757IJyZBQ3KLN2hWZCe5KgmfFD8q2abYG3uh+Sub0z0ZN7ISwInG
         87m2P/5Ui7O79kBHgxTY0o+K9eoTqDauHxbEHvfGTtx/onrpK2XqI7KNGYbPj3dLE7TW
         PzEQ==
X-Gm-Message-State: AOAM532AHEAuf7Zy6xo7la1IbppoK3YmuFSJengig40+89XkcSEB2SV3
        q5UQlQ5PYHLydn5Q64j1/Fqeuzyts/5mA8w3DHnIgMAU
X-Google-Smtp-Source: ABdhPJwfC8XqCNB8/d+pfoyj8uWE9e6HbLfPf8cnb+MF/t/qJVFy07WgAjIGg/0734FqKdD2m71xTilREalxWMYC9GM=
X-Received: by 2002:aca:52d6:: with SMTP id g205mr1770983oib.54.1600932091971;
 Thu, 24 Sep 2020 00:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <3cf40b9df80a99a3eee6d3af79437016038f0a44.1600051331.git.fthain@telegraphics.com.au>
 <CAMuHMdUOdOkBE72ouk0W_bXnoSTFqLsLKag+2LSRz+Qox6MoxQ@mail.gmail.com>
 <alpine.LNX.2.23.453.2009150945480.6@nippy.intranet> <CAMuHMdX1GXMGg1mviE_msM1vx0ZLEKEPT4AacSBjYDzN6sZVmw@mail.gmail.com>
 <alpine.LNX.2.23.453.2009160758350.6@nippy.intranet> <alpine.LNX.2.23.453.2009240929310.7@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2009240929310.7@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Sep 2020 09:21:20 +0200
Message-ID: <CAMuHMdXoGSmepZqigX4rUsRf7xQuNo8FynJYyQ_ee1Tu6Xu06g@mail.gmail.com>
Subject: Re: [PATCH v2] ide/macide: Convert Mac IDE driver to platform driver
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On Thu, Sep 24, 2020 at 3:07 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 16 Sep 2020, Finn Thain wrote:
> > On Tue, 15 Sep 2020, Geert Uytterhoeven wrote:
> > > > > > --- a/drivers/ide/macide.c
> > > > > > +++ b/drivers/ide/macide.c
> > > > >
> > > > > > @@ -109,42 +110,61 @@ static const char *mac_ide_name[] =
> > > > > >   * Probe for a Macintosh IDE interface
> > > > > >   */
> > > > > >
> > > > > > -static int __init macide_init(void)
> > > > > > +static int mac_ide_probe(struct platform_device *pdev)
> > > > > >  {
> > > > >
> > > > > >         printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
> > > > > >                          mac_ide_name[macintosh_config->ide_type - 1]);
> > > > > >
> > > > > > -       macide_setup_ports(&hw, base, irq);
> > > > > > +       macide_setup_ports(&hw, mem->start, irq->start);
> > > > > >
> > > > > > -       return ide_host_add(&d, hws, 1, NULL);
> > > > > > +       rc = ide_host_add(&d, hws, 1, &host);
> > > > > > +       if (rc)
> > > > > > +               return rc;
> > > > > > +
> > > > > > +       platform_set_drvdata(pdev, host);
> > > > >
> > > > > Move one up, to play it safe?
> > > > >
> > > >
> > > > You mean, before calling ide_host_add? The 'host' pointer is
> > > > uninitialized prior to that call.
> > >
> > > Oh right, so the IDE subsystem doesn't let you use the drvdata inside
> > > your driver (besides in remove()) in a safe way :-(
> > >
> >
> > The IDE subsystem does allow other patterns here. I could have changed
> > ide_host_alloc() into ide_host_register() followed by ide_host_add() but
> > I could not see any benefit from that change.
> >
>
> Sorry, I meant to say, "I could have changed ide_host_add() into
> ide_host_alloc() followed by ide_host_register() ..."
>
> > A quick search for "platform_device" shows that the driver does not use
> > any uninitialized driver_data pointer (because ide_ifr is a global). In
> > your message of September 9th you readily reached the same conclusion
> > when you reviewed v1.
> >
> > If mac_ide_probe() followed the usual pattern it might make review
> > easier (as reviewers may not wish to consider the entire driver) but
> > does that really make the code more "safe"?
>
> I still think that "if it ain't broke, don't fix it" is actually the
> "safe" option for macide.c. But I'm happy to make additional changes, test
> them and send v5 if that's preferred.

I'm fine with keeping this as-is, as it doesn't really matter for this
particular
driver.

> Looking further at the drivers using ide_host_register(), I see that
> falconide.c is missing a set_drvdata() call, while tx4939ide.c calls
> set_drvdata() after ide_host_register(). The latter example is not a bug.
>
> The pattern I used, that is, calling set_drvdata() after ide_host_add(),
> is actually more popular among IDE drivers than the pattern you suggested,
> that is, set_drvdata() followed by ide_host_register(). Either way, I
> don't see any bugs besides the one in falconide.c.
>
> Regarding falconide.c, my inclination is to send a fix following the more
> common pattern (among IDE drivers), as below. I guess that may prompt the
> subsystem maintainers to make known their views on the style question.

Please do so. Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
