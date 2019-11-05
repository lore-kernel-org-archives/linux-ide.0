Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5175C47E49
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 20:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EDC217F5
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 20:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ftim7AGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfKEUDF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:03:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44789 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfKEUDE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 15:03:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id f19so6051039pgk.11;
        Tue, 05 Nov 2019 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YoazNcCapO07EMrilU/xDFZwOoErJtAzoLTDVccbvTI=;
        b=Ftim7AGv71FuxXE+aioupZ9uwFyZKGlbaxEUfIwypfmVY9WmxmQ0H5ic9vLSzrQqox
         oeeRz+Ug3muRATZmhDjYLt1edDmpbCON3TbLtmkyctWdPocqOjdMwd5jXX/bWDeTbntD
         XEIRHqhW885L7s21Hq8nam+GQ2an5Geym5a3XhkngsPPSPZDFknMoMCwgqMPW2gyDCUu
         iG5oKnR71r6gZ45/sSnwnIfenrGyVW4FyY465Jo17z/TslQN5a43/UI/P5/DD5sE30+Y
         AYtCFRxJrjsD/Zumu6IUdzZl53mR8oRlze1b2nOJlvzzHIOkhM73MTKhveldt3fNwWjw
         4CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoazNcCapO07EMrilU/xDFZwOoErJtAzoLTDVccbvTI=;
        b=bWqdfGU0//E2Ucu+iFDs6R/ceyQ7+j4J+CETg24/5EjUyNcyHiiiBKbIVxUJcJyZkB
         G9PMvfhYVrjL7WnAIhCMR/SV/zRACJVHmuFkyvCGrxvvP5UVWuxNJWa/6mFOcTiBvrj7
         eCZKb52jNIZlTMa/mO8bMMzyENIoSvNPmDJJShgrrHg4TKRqqVelytY6AhVx/IDSiC1n
         mRcA7uy8GJTnVoWdr41tPodJfNzTK8HQX/emfnWfldXK4uYJW1pbz3n6mCwF0xAaV5Nu
         OKxTuvTevFCqHoxGbM/9yUvcTXjePx/5MnF9ij9lDwQgr6tWkWtvHqRuDD0EDM6Rs8k9
         0MnA==
X-Gm-Message-State: APjAAAWx7imCbx1ZmeLUiPDZukgHvDBVqc2BekcMFvZk+EK6yQRMUVeD
        7z2553ZzqcBwh12vuH9lL7Mcs90L/7sjv4JWyPc=
X-Google-Smtp-Source: APXvYqweRqJ16EuTyRfiirhgXTXQ0ihILysGNzqk0J5178d2Tjjry8pyvn2jDa3pmLHE2A9Nfo0EU/95haHHuDazo8A=
X-Received: by 2002:a17:90a:c082:: with SMTP id o2mr1073773pjs.94.1572984184041;
 Tue, 05 Nov 2019 12:03:04 -0800 (PST)
MIME-Version: 1.0
References: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
 <1572935872-28394-1-git-send-email-schmitzmic@gmail.com> <CAMuHMdXM+h_GsbkSvyfpLJ0DJixmr-wOS_d5qQrZ8e7VY_bbPg@mail.gmail.com>
 <CAOmrzkKLosq7LdXS6BuvHSARPXCXPiasW1zGywY3+hoys4NxoA@mail.gmail.com> <CAMuHMdVBpMJ6E9N1=YG6VPNJifexdbM9=PWAkjyLwdz9b5n0YQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVBpMJ6E9N1=YG6VPNJifexdbM9=PWAkjyLwdz9b5n0YQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Wed, 6 Nov 2019 09:02:52 +1300
Message-ID: <CAOmrzk+-FD63N88MTE6993V8-Z96vXpAcB7yd33fftcj3ZebbA@mail.gmail.com>
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

On Wed, Nov 6, 2019 at 7:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > > > @@ -169,10 +177,21 @@ static int __init falconide_init(void)
> >
> > Should I remove the __init here? Doesn't hurt in the built-in use
> > case, what about use as a module?
>
> Should be fine.

OK, I'll leave it.

>
> >
> > > >  err_free:
> > > >         ide_host_free(host);
> > > >  err:
> > > > -       release_mem_region(ATA_HD_BASE, 0x40);
> > > > +       release_mem_region(res->start, resource_size(res));
> > > >         return rc;
> > > >  }
> > > >
> > > > -module_init(falconide_init);
> > > > +static struct platform_driver ide_falcon_driver = {
> > > > +       .driver   = {
> > > > +               .name   = "atari-falcon-ide",
> > > > +       },
> > > > +};
> > >
> > > Missing .remove() callback.
> >
> > Can't easily test driver remove, but I can certainly add a callback for that.
> >
> > ide_unregister does the Right Thing (i.e. leaves the ST-DMA interrupt
> > registered) so no reason why it shouldn't work.
>
> gayle.c uses ide_host_remove().

I'm using that, too. But  ide_host_remove() is not where free_irq() is called.

>
> > > > +
> > > > +module_platform_driver_probe(ide_falcon_driver, falconide_init);
> > > > +
> > > >
> > > > +MODULE_AUTHOR("Geert Uytterhoeven");
> > > > +MODULE_DESCRIPTION("low-level driver for Atari Falcon IDE");
> > > >  MODULE_LICENSE("GPL");
> > > > +MODULE_ALIAS("platform:atari-falcon-ide");
> > > > +MODULE_VERSION(DRV_VERSION);
> > >
> > > I'd drop the MODULE_VERSION().
> >
> > Done.
> >
> > Shall I merge this one with part one of the old series so there's no
> > chance of a bisection going wrong?
>
> Yes please.
> Thanks!

Thanks, I'll send a new version shortly.

Cheers,

    Michael
