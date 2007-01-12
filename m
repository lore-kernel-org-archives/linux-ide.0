From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Date: Fri, 12 Jan 2007 15:00:30 +0100
Message-ID: <58cb370e0701120600pc65b237w4865c9637fc1b6e6@mail.gmail.com>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	 <20070112042800.28794.95095.sendpatchset@localhost.localdomain>
	 <20070112100836.58738dbc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:13238 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbXALOAc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 09:00:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so789233uga
        for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 06:00:31 -0800 (PST)
In-Reply-To: <20070112100836.58738dbc@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 1/12/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 12 Jan 2007 05:28:00 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > [PATCH] ide: add ide_use_fast_pio() helper
> >
> > * add ide_use_fast_pio() helper for use by host drivers
> > * add DMA capability and autodma checks to ide_use_dma()
> >   - au1xxx-ide/it8213/it821x drivers didn't check for (id->capability & 1)
>
> For the IT8211/2 in SMART this check shouldn't be made.

It is OK since in it821x_fixups() we set it explicitly:

		if(strstr(id->model, "Integrated Technology Express")) {
			/* In raid mode the ident block is slightly buggy
			   We need to set the bits so that the IDE layer knows
			   LBA28. LBA48 and DMA ar valid */
			id->capability |= 3;		/* LBA28, DMA */

and we are better off using generic helper if we can
(which may later allow us to use generic tuning code).

> >   - ide-cris driver didn't set ->autodma
>
> You've changed the behaviour there. Should the default be autodma=0 ?

Before my patch hwif->autodma was only checked in the chipset specific
hwif->ide_dma_check implementations.  For ide-cris it is
cris_dma_check()
function so there no behavior change here.

Sorry for not explaining changes in detail in the patch description
(I will update it).

Bart
