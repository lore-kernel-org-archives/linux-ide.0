From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC] pci_get_legacy_ide_irq()
Date: Tue, 19 Oct 2004 19:25:34 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e041019102572b83e37@mail.gmail.com>
References: <1098169487.15029.58.camel@gaston>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.195]:4630 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269884AbUJSRZf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Oct 2004 13:25:35 -0400
Received: by mproxy.gmail.com with SMTP id 77so337273rnk
        for <linux-ide@vger.kernel.org>; Tue, 19 Oct 2004 10:25:34 -0700 (PDT)
In-Reply-To: <1098169487.15029.58.camel@gaston>
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>

Hi!

On Tue, 19 Oct 2004 17:04:48 +1000, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi !
> 
> As discussed earlier, this is a proposed patch that adds the function
> to include/asm-generic/pci.h and ppc64's own pci.h. I also only call
> it from the amd7xxx.c driver for now, I want to let Bart decide if we
> should add a call to it from every driver that don't see an irq when
> we sort-of know what we are doing, or if we could just call it from the
> generic pci-ide code when the controller is in legacy mode ... maybe
> after a probe pass ? (thoug archs like ppc don't do irq probe).

IMHO just stick it in a drivers for now,
we can think about generic place later

> The patch also uses NO_IRQ which is currently not defined on a lot of
> archs. This is ok as I'm currently collecting definitions for it and
> will send a patch adding those before this patch gets submited.

fine

> This patch adds a pci_get_legacy_ide_irq() function to
> include/asm-generic/pci.h that returns the interrupt to use for a PCI
> IDE controller that is set to "legacy mode". It also adds a ppc64 specific
> implementation that allows the platform code to provide it's own number.
> Finally, it adds a call to this routine to the amd7xxx driver (instead
> of hard coding the numbers) when no interrupt was found.
> I decided to fix individual drivers rather
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-maple/drivers/ide/pci/amd74xx.c
> ===================================================================
> --- linux-maple.orig/drivers/ide/pci/amd74xx.c  2004-10-19 13:38:08.000000000 +1000
> +++ linux-maple/drivers/ide/pci/amd74xx.c       2004-10-19 17:04:20.243498048 +1000
> @@ -416,8 +416,8 @@
>  {
>         int i;
> 
> -       if (!hwif->irq)
> -               hwif->irq = hwif->channel ? 15 : 14;
> +       if (hwif->irq == NO_IRQ)
> +               hwif->irq = pci_get_legacy_ide_irq(hwif->pci_dev, hwif->channel);

This won't be ever executed unless
* you teach IDE driver about NO_IRQ
or
* NO_IRQ is 0

Bartlomiej
