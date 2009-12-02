From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/5] powerpc/macio: Add dma_parms support to macio
Date: Wed, 02 Dec 2009 11:36:27 +1100
Message-ID: <20091202003628.197401007D3@ozlabs.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:50176 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748AbZLBAgW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 19:36:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, jeff@garzik.org, tj@kernel.org

This adds dma_parms to macio devices and initializes them with
default values. This will allow pata_macio to setup the appropriate
max segment size for the block layer.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/macio.h |    1 +
 drivers/macintosh/macio_asic.c   |    5 +++++
 2 files changed, 6 insertions(+)

--- linux-work.orig/arch/powerpc/include/asm/macio.h	2009-11-27 14:38:05.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/macio.h	2009-11-27 14:38:20.000000000 +1100
@@ -39,6 +39,7 @@ struct macio_dev
 	struct macio_bus	*bus;		/* macio bus this device is on */
 	struct macio_dev	*media_bay;	/* Device is part of a media bay */
 	struct of_device	ofdev;
+	struct device_dma_parameters dma_parms; /* ide needs that */
 	int			n_resources;
 	struct resource		resource[MACIO_DEV_COUNT_RESOURCES];
 	int			n_interrupts;
Index: linux-work/drivers/macintosh/macio_asic.c
===================================================================
--- linux-work.orig/drivers/macintosh/macio_asic.c	2009-11-27 14:39:24.000000000 +1100
+++ linux-work/drivers/macintosh/macio_asic.c	2009-11-27 16:37:39.000000000 +1100
@@ -379,6 +379,11 @@ static struct macio_dev * macio_add_one_
 	dev->ofdev.dev.parent = parent;
 	dev->ofdev.dev.bus = &macio_bus_type;
 	dev->ofdev.dev.release = macio_release_dev;
+	dev->ofdev.dev.dma_parms = &dev->dma_parms;
+
+	/* Standard DMA paremeters */
+	dma_set_max_seg_size(&dev->ofdev.dev, 65536);
+	dma_set_seg_boundary(&dev->ofdev.dev, 0xffffffff);
 
 #ifdef CONFIG_PCI
 	/* Set the DMA ops to the ones from the PCI device, this could be
