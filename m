From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide: add struct ide_dma_ops
Date: Sat, 12 Apr 2008 14:32:03 +0200
Message-ID: <200804121432.03366.bzolnier@gmail.com>
References: <200803091700.46136.bzolnier@gmail.com> <200803181512.50134.bzolnier@gmail.com> <47FF636E.4070903@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:19745 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757786AbYDLMRQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 08:17:16 -0400
Received: by fg-out-1718.google.com with SMTP id l27so741850fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 05:17:15 -0700 (PDT)
In-Reply-To: <47FF636E.4070903@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday 11 April 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>    Now where is the code which selects the correct dma_ops for the 
> >>> HPT36x/370/372/372N chip with device ID 4 I'm asking you?  :-) 
> 
> > fixed
> 
>     Not actually... :-/

Arghhh.  I see now that the HPT370/370A needs a special handling...
(HPT372/372N has already been handled by 'idx++')

[...]

> > @@ -1483,6 +1489,7 @@ static const struct ide_port_info hpt366
> >  		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
> >  		.udma_mask	= ATA_UDMA5,
> >  		.port_ops	= &hpt3xx_port_ops,
> > +		.dma_ops	= &hpt370_dma_ops,
> 
>     Wrong -- HPT374 should have hpt37x_dma_ops...

Yep, thanks for catching it.

interdiff between v2->v3:

[...]
v3:
* Two bugs slipped in v2 (noticed by Sergei):
  - use correct DMA ops for HPT374 (for real this time)
  - handle HPT370/HPT370A properly

[...]
diff -u b/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- b/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1489,7 +1489,7 @@
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= ATA_UDMA5,
 		.port_ops	= &hpt3xx_port_ops,
-		.dma_ops	= &hpt370_dma_ops,
+		.dma_ops	= &hpt37x_dma_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
@@ -1563,6 +1563,10 @@
 	d.name = info->chip_name;
 	d.udma_mask = info->udma_mask;
 
+	/* fixup ->dma_ops for HPT370/HPT370A */
+	if (info == &hpt370 || info == &hpt370a)
+		d.dma_ops = &hpt370_dma_ops;
+
 	pci_set_drvdata(dev, (void *)info);
 
 	if (info == &hpt36x || info == &hpt374)
