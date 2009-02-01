From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sun, 1 Feb 2009 17:16:29 +0100
Message-ID: <200902011716.29579.bzolnier@gmail.com>
References: <49615667.9020408@iwl.com> <200901111847.12080.bzolnier@gmail.com> <4984BC9F.3090200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:7234 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbZBARYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:24:19 -0500
Received: by mu-out-0910.google.com with SMTP id g7so846825muf.1
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2009 09:24:15 -0800 (PST)
In-Reply-To: <4984BC9F.3090200@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Saturday 31 January 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>> +enum {
> >>> +	MSR_IDE_CFG		= 0x51300010,
> >>> +	PCI_IDE_CFG		= 0x40,
> >>> +
> >>> +	CFG			= 0,
> >>> +	DTC			= 2,
> >>> +	CAST			= 3,
> >>> +	ETC			= 4,
> >>> +
> >>> +	IDE_CFG_CHANEN		= (1 << 1),
> >>> +	IDE_CFG_CABLE		= (1 << 17) | (1 << 16),
> >>> +
> >>> +	IDE_D0_SHIFT		= 24,
> >>> +	IDE_D1_SHIFT		= 16,
> >>> +	IDE_DRV_MASK		= 0xff,
> >>> +
> >>> +	IDE_CAST_D0_SHIFT	= 6,
> >>> +	IDE_CAST_D1_SHIFT	= 4,
> >>> +	IDE_CAST_DRV_MASK	= 0x3,
> >>> +
> >>> +	IDE_CAST_CMD_SHIFT	= 24,
> >>> +	IDE_CAST_CMD_MASK	= 0xff,
> >>> +};
> >>>   
> >>>       
> >>    Declaring a lot of semi-related constants is not what enum was 
> >> intended for I think...
> >>     
> >
> > Don't know about that but it is still better than using defines.
> >   
> 
>    That's what I doubt...
> 
> >>> +	cs5536_read(dev, CFG, &cfg);
> >>> +
> >>> +	if ((cfg & IDE_CFG_CHANEN) == 0) {
> >>> +		printk(KERN_ERR DRV_NAME ": disabled by BIOS\n");
> >>> +		return -ENODEV;
> >>>   
> >>>       
> >>    Eh, why not do it via the usual .enablebits mechanism?
> >>     
> >
> > Because we may be using MSR access instead of PCI one.
> >   
> 
>    Ah...
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: add CS5536 host driver (v2)
> >
> > This is a port of libata's pata_cs5536.c (written by Martin K. Petersen)
> > to IDE subsystem.
> >
> > Changes done while at it:
> >
> > * Reprogram PIO/MWDMA timings if needed before and after DMA transfer
> >   (chipset uses shared PIO/MWDMA timings).
> >
> > * Fix cable detection to report 80-wires cable if BIOS set it for any
> >   device on a port (IDE core will do drive-side cable detection later).
> >
> > * Don't disable UDMA while programming PIO timings.
> >
> > * Simplify PCI/MSR support.
> >
> > Pros of having IDE host driver in addition to libata's one:
> >
> > * IDE is much lighter than SCSI+libata, the host driver itself is also
> >   a bit smaller:
> >
> >    text    data     bss     dec     hex filename
> >    1237     500       4    1741     6cd drivers/ata/pata_cs5536.o
> >    1214     128       4    1346     542 drivers/ide/cs5536.o
> >
> > * This allows use of IDE features which are unavailable under libata.
> >
> > v2:
> > * Fixes per review from Sergei:
> >   - simplify dependency check in Kconfig
> >   - use IDE_DRV_MASK also for ->drive_data
> >   - disable UDMA when programming MWDMA
> >   - program new DTC timings only when necessary
> >   - fix printk() level in cs5536_init_one()
> >
> > * Fix patch description according to comments from Alan and Sergei.
> >
> > Cc: Martin K. Petersen <mkp@mkp.net>
> > Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Cc: Karl Auerbach <karl@iwl.com>
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > v1->v2 interdiff only
> >   
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> 
> > diff -u b/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
> > --- b/drivers/ide/cs5536.c
> > +++ b/drivers/ide/cs5536.c
> > @@ -61,6 +61,9 @@
> >  
> >  	IDE_CAST_CMD_SHIFT	= 24,
> >  	IDE_CAST_CMD_MASK	= 0xff,
> > +
> > +	IDE_ETC_UDMA_RELSHIFT	= 6,
> > +	IDE_ETC_UDMA_MASK	= 0x3,
> >   
> 
>    Too many shifts and mask values to my taste, why not just use 0xC0?

Fixed, I have no idea why I did it this way originally... :)

> > @@ -186,22 +189,24 @@
> >  	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
> >  	u32 etc;
> >  
> > -	if (mode >= XFER_UDMA_0) {
> > -		cs5536_read(pdev, ETC, &etc);
> > +	cs5536_read(pdev, ETC, &etc);
> >  
> > +	if (mode >= XFER_UDMA_0) {
> >  		etc &= ~(IDE_DRV_MASK << dshift);
> >   
> 
>    Er, I'm not sure using IDE_DRV_MASK here is completely correct as 
> only the mask 0xC7 actually controls UltraDMA enables and cycle time...

Bits 0x38 are described to be hardwired to 0 in the datasheet so this
should be OK (also pata_cs5536.c does the same thing)...

v2->v3 interdiff:
...
v3:
* Smarter masking of UDMA bits per Sergei's suggestion.
...

diff -u b/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
--- b/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -62,8 +62,7 @@
 	IDE_CAST_CMD_SHIFT	= 24,
 	IDE_CAST_CMD_MASK	= 0xff,
 
-	IDE_ETC_UDMA_RELSHIFT	= 6,
-	IDE_ETC_UDMA_MASK	= 0x3,
+	IDE_ETC_UDMA_MASK	= 0xc0,
 };
 
 static int use_msr;
@@ -195,7 +194,7 @@
 		etc &= ~(IDE_DRV_MASK << dshift);
 		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
 	} else { /* MWDMA */
-		etc &= ~(IDE_ETC_UDMA_MASK << (dshift + IDE_ETC_UDMA_RELSHIFT));
+		etc &= ~(IDE_ETC_UDMA_MASK << dshift);
 		drive->drive_data &= IDE_DRV_MASK;
 		drive->drive_data |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
 	}
