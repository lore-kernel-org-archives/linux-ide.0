From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/6] sgiioc4: use ide_tune_dma()
Date: Fri, 13 Jul 2007 21:49:20 +0200
Message-ID: <200707132149.20310.bzolnier@gmail.com>
References: <200707110206.07157.bzolnier@gmail.com> <4697995F.6070004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:44346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbXGMVa5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:30:57 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647444ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:30:57 -0700 (PDT)
In-Reply-To: <4697995F.6070004@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>

On Friday 13 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add DRV_NAME define and use it instead of sgiioc4_chipset.name.
> 
> > * Remove no longer needed sgiioc4_chipset.
> 
> > * Remove needless clearing of ->atapi_dma from ide_dma_sgiioc4().
> 
> > * Fix ide_dma_sgiioc4() to return success/failure.  Check return value in
> >   sgiioc4_ide_setup_pci_device() and set hwif->autodma accordingly.  Also add
> >   missing setting of drive->autodma.
> 
> > * Add sgiioc4_speedproc() (implementation of ->speedproc method).
> 
> > * Fix ->mwdma_mask (MWDMA2 mask is 0x04 not 0x02) and remove incorrect
> >   ->swdma_mask.  Also remove needless initialization of ->ultra_mask.
> 
> > * Use ide_tune_dma() in sgiioc4_ide_dma_check(), this fixes following bugs:
> >   - DMA capability bit not being checked on the device
> >   - DMA blacklist not being checked
> >   - MWDMA2 mode support by device not being checked
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     Nice cleanups...
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
