From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/13] ide: move drive->using_dma check to callers of ->dma_host_on method
Date: Tue, 13 Nov 2007 22:27:19 +0100
Message-ID: <200711132227.19689.bzolnier@gmail.com>
References: <200711130002.20962.bzolnier@gmail.com> <47398934.8030100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:2917 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757407AbXKMVUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 16:20:05 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1949941fkz
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 13:20:03 -0800 (PST)
In-Reply-To: <47398934.8030100@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 13 November 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> MBR, Sergei
> 
> > Index: b/drivers/ide/ide-dma.c
> > ===================================================================
> > --- a/drivers/ide/ide-dma.c
> > +++ b/drivers/ide/ide-dma.c
> > @@ -470,7 +470,7 @@ EXPORT_SYMBOL(ide_dma_off);
> >  
> >  void ide_dma_host_on(ide_drive_t *drive)
> >  {
> > -	if (drive->using_dma) {
> > +	if (1) {
> 
>     Why so?

Just not to move the code around (because it "vanishes" in patch #13/13).

> >  		ide_hwif_t *hwif	= HWIF(drive);
> >  		u8 unit			= (drive->select.b.unit & 0x01);
> >  		u8 dma_stat		= hwif->INB(hwif->dma_status);
