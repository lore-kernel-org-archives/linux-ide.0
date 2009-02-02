From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 02/15] scc_pata: remove DECLARE_SCC_DEV() macro
Date: Mon, 2 Feb 2009 19:26:44 +0100
Message-ID: <200902021926.44921.bzolnier@gmail.com>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain> <20090201174923.19144.28927.sendpatchset@localhost.localdomain> <49872324.9070908@cluded.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:10479 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975AbZBBSgz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 13:36:55 -0500
In-Reply-To: <49872324.9070908@cluded.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Daniel K." <daniel@cluded.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 02 February 2009, Daniel K. wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Index: b/drivers/ide/scc_pata.c
> > ===================================================================
> > --- a/drivers/ide/scc_pata.c
> > +++ b/drivers/ide/scc_pata.c
> > @@ -882,21 +882,16 @@ static const struct ide_dma_ops scc_dma_
> >  	.dma_sff_read_status	= scc_dma_sff_read_status,
> >  };
> >  
> > -#define DECLARE_SCC_DEV(name_str)			\
> > -  {							\
> > -      .name		= name_str,			\
> > -      .init_iops	= init_iops_scc,		\
> > -      .init_dma		= scc_init_dma,			\
> > -      .init_hwif	= init_hwif_scc,		\
> > -      .tp_ops		= &scc_tp_ops,		\
> > -      .port_ops		= &scc_port_ops,		\
> > -      .dma_ops		= &scc_dma_ops,			\
> > -      .host_flags	= IDE_HFLAG_SINGLE,		\
> > -      .pio_mask		= ATA_PIO4,			\
> > -  }
> > -
> >  static const struct ide_port_info scc_chipsets[] __devinitdata = {
> > -	/* 0 */ DECLARE_SCC_DEV("sccIDE"),
> > +	.name		= "sccIDE",
> > +	.init_iops	= init_iops_scc,
> > +	.init_dma	= scc_init_dma,
> > +	.init_hwif	= init_hwif_scc,
> > +	.tp_ops		= &scc_tp_ops,
> > +	.port_ops	= &scc_port_ops,
> > +	.dma_ops	= &scc_dma_ops,
> > +	.host_flags	= IDE_HFLAG_SINGLE,
> > +	.pio_mask	= ATA_PIO4,
> >  };
> >  
> >  /**
> 
> You're a few braces short here, aren't you?

Good catch, thanks!

> The braces in the #define, didn't get carried over in the change.

Actually we may simplify the whole thing while at it.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] scc_pata: remove DECLARE_SCC_DEV() macro (v2)

v2:
scc_chipsets[] -> scc_chipset fix (spotted by Daniel K.).

Cc: "Daniel K." <daniel@cluded.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/scc_pata.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

Index: b/drivers/ide/scc_pata.c
===================================================================
--- a/drivers/ide/scc_pata.c
+++ b/drivers/ide/scc_pata.c
@@ -882,21 +882,16 @@ static const struct ide_dma_ops scc_dma_
 	.dma_sff_read_status	= scc_dma_sff_read_status,
 };
 
-#define DECLARE_SCC_DEV(name_str)			\
-  {							\
-      .name		= name_str,			\
-      .init_iops	= init_iops_scc,		\
-      .init_dma		= scc_init_dma,			\
-      .init_hwif	= init_hwif_scc,		\
-      .tp_ops		= &scc_tp_ops,		\
-      .port_ops		= &scc_port_ops,		\
-      .dma_ops		= &scc_dma_ops,			\
-      .host_flags	= IDE_HFLAG_SINGLE,		\
-      .pio_mask		= ATA_PIO4,			\
-  }
-
-static const struct ide_port_info scc_chipsets[] __devinitdata = {
-	/* 0 */ DECLARE_SCC_DEV("sccIDE"),
+static const struct ide_port_info scc_chipset __devinitdata = {
+	.name		= "sccIDE",
+	.init_iops	= init_iops_scc,
+	.init_dma	= scc_init_dma,
+	.init_hwif	= init_hwif_scc,
+	.tp_ops		= &scc_tp_ops,
+	.port_ops	= &scc_port_ops,
+	.dma_ops	= &scc_dma_ops,
+	.host_flags	= IDE_HFLAG_SINGLE,
+	.pio_mask	= ATA_PIO4,
 };
 
 /**
@@ -910,7 +905,7 @@ static const struct ide_port_info scc_ch
 
 static int __devinit scc_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	return init_setup_scc(dev, &scc_chipsets[id->driver_data]);
+	return init_setup_scc(dev, &scc_chipset);
 }
 
 /**

