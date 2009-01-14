From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/9] ide: move ->rqsize init from init_irq() to ide_init_port()
Date: Wed, 14 Jan 2009 18:25:21 +0100
Message-ID: <200901141825.21896.bzolnier@gmail.com>
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain> <20090106183602.21193.67001.sendpatchset@localhost.localdomain> <496A5D64.6030007@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:7524 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762454AbZANRZ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 12:25:26 -0500
In-Reply-To: <496A5D64.6030007@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 11 January 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >   
> 
> > Index: b/drivers/ide/ide-probe.c
> > ===================================================================
> > --- a/drivers/ide/ide-probe.c
> > +++ b/drivers/ide/ide-probe.c
> >   
> [...]
> > @@ -1242,6 +1234,13 @@ static void ide_init_port(ide_hwif_t *hw
> >  
> >  	if (d->max_sectors)
> >  		hwif->rqsize = d->max_sectors;
> > +	else {
> > +		if ((hwif->host_flags & IDE_HFLAG_NO_LBA48) ||
> > +		    (hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA))
> >   
> 
>    Er, why not:
> 
> 		if (hwif->host_flags &
> 		    (IDE_HFLAG_NO_LBA48 | IDE_HFLAG_NO_LBA48_DMA))

IMO it is harder to read
