From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/13] serverworks: cleanup ->set_dma_mode method
Date: Tue, 13 Nov 2007 22:26:45 +0100
Message-ID: <200711132226.45742.bzolnier@gmail.com>
References: <200711130001.16287.bzolnier@gmail.com> <47398B65.7090409@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:3451 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759662AbXKMVUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 16:20:05 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1949948fkz
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 13:20:04 -0800 (PST)
In-Reply-To: <47398B65.7090409@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 13 November 2007, Sergei Shtylyov wrote:

[...]

> > Index: b/drivers/ide/pci/serverworks.c
> > ===================================================================
> > --- a/drivers/ide/pci/serverworks.c
> > +++ b/drivers/ide/pci/serverworks.c
> > @@ -164,25 +164,12 @@ static void svwks_set_dma_mode(ide_drive
> >  	ultra_timing	&= ~(0x0F << (4*unit));
> >  	ultra_enable	&= ~(0x01 << drive->dn);
> >  
> > -	switch(speed) {
> > -		case XFER_MW_DMA_2:
> > -		case XFER_MW_DMA_1:
> > -		case XFER_MW_DMA_0:
> > -			dma_timing |= dma_modes[speed - XFER_MW_DMA_0];
> > -			break;
> > -
> > -		case XFER_UDMA_5:
> > -		case XFER_UDMA_4:
> > -		case XFER_UDMA_3:
> > -		case XFER_UDMA_2:
> > -		case XFER_UDMA_1:
> > -		case XFER_UDMA_0:
> > -			dma_timing   |= dma_modes[2];
> 
>     Why it needs to change in the first place?

Indeed, there is a needless coupling of MWDMA/UDMA timings in serverworks.

Care to fix it?

Bart
