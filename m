From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Date: Mon, 27 Mar 2006 16:40:20 +0200
Message-ID: <58cb370e0603270640v7c6070a9gb7dbd2aa5fcbbf98@mail.gmail.com>
References: <20060122171239.GD10003@stusta.de> <4427F5E7.1000108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:50219 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751046AbWC0Ok2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 09:40:28 -0500
Received: by pproxy.gmail.com with SMTP id w49so1327019pyg
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 06:40:27 -0800 (PST)
In-Reply-To: <4427F5E7.1000108@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Adrian Bunk wrote:
>
> > This patch removes the CONFIG_PDC202XX_FORCE=n case.
>
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> > ---
> >
> > This patch was already sent on:
> > - 14 Jan 2006
> >
> >  drivers/ide/Kconfig            |    7 -------
> >  drivers/ide/pci/pdc202xx_new.c |    6 ------
> >  drivers/ide/pci/pdc202xx_old.c |   15 ---------------
> >  3 files changed, 28 deletions(-)
>
> [skipped]
>
> > --- linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c.old  2006-01-14 20:44:01.000000000 +0100
> > +++ linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c      2006-01-14 20:44:21.000000000 +0100
> > @@ -786,9 +786,6 @@
> >               .init_dma       = init_dma_pdc202xx,
> >               .channels       = 2,
> >               .autodma        = AUTODMA,
> > -#ifndef CONFIG_PDC202XX_FORCE
> > -             .enablebits     = {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> > -#endif
> >               .bootable       = OFF_BOARD,
> >               .extra          = 16,
> >       },{     /* 1 */
> > @@ -799,9 +796,6 @@
> >               .init_dma       = init_dma_pdc202xx,
> >               .channels       = 2,
> >               .autodma        = AUTODMA,
> > -#ifndef CONFIG_PDC202XX_FORCE
> > -             .enablebits     = {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> > -#endif
> >               .bootable       = OFF_BOARD,
> >               .extra          = 48,
> >               .flags          = IDEPCI_FLAG_FORCE_PDC,
>
>     A late question: wasn't that IDEPCI_FLAG_FORCE_PDC flag there for the same
> purpose -- to bypass enablebits check? Wasn't it enough?

It was for the same purpose but it wasn't enough,
now this flag can die...

Bartlomiej
