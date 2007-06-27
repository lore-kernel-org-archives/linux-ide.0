From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/5] piix: backport short cables support from ata_piix.c
Date: Wed, 27 Jun 2007 21:13:33 +0200
Message-ID: <200706272113.33261.bzolnier@gmail.com>
References: <200706101558.14511.bzolnier@gmail.com> <46815B44.1040609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:43017 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbXF0TzJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2007 15:55:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so415259ugf
        for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 12:55:09 -0700 (PDT)
In-Reply-To: <46815B44.1040609@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 26 June 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Backport short cables support from ata_piix.c.
> 
> > This patch should allow UDMA > 2 modes on:
> > - Acer 5602WLMi
> > - Acer 3682WLMi
> > - Asus W5F
> > - Acer Aspire 2023WLMi
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Added (as well as ACKs for patches #3-5 of this series).

>     Minor nit here:
> 
> > Index: b/drivers/ide/pci/piix.c
> > ===================================================================
> > --- a/drivers/ide/pci/piix.c
> > +++ b/drivers/ide/pci/piix.c
> > @@ -394,12 +394,43 @@ static void piix_dma_clear_irq(ide_drive
> [...]
> >  static u8 __devinit piix_cable_detect(ide_hwif_t *hwif)
> >  {
> > -	struct pci_dev *dev = hwif->pci_dev;
> > +	struct pci_dev *pdev = hwif->pci_dev;
> 
>     Unnecessary rename.
> 
> > +	const struct ich_laptop *lap = &ich_laptop[0];
> 
>     ... and & and [0] are superfluous with arrays -- they behave like pointers 
> in expression.

I was blinded by libata code... ;)

Bart
