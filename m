From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
	open bugs) II
Date: Fri, 10 Aug 2007 11:28:25 -0700
Message-ID: <1186770505.6334.3.camel@localhost.localdomain>
References: <46BA9101.6080407@gmail.com>
	 <20070809145336.6d728f9b@the-village.bc.nu>
	 <20070809170540.GA30700@one.firstfloor.org>
	 <20070809182101.710c3c5b@the-village.bc.nu>
	 <20070809172304.GB30700@one.firstfloor.org>
	 <20070809185310.682dffbc@the-village.bc.nu>
	 <20070809192850.GA32280@one.firstfloor.org>
	 <20070809233458.12d8447c@the-village.bc.nu>
	 <20070809224305.GA1611@one.firstfloor.org>
	 <20070810001443.610185e1@the-village.bc.nu>
	 <20070809231141.GB1845@one.firstfloor.org>
	 <20070810002453.384a9b4c@the-village.bc.nu>
	 <p73sl6rencd.fsf@bingen.suse.de>
	 <20070810145430.17d72a76@the-village.bc.nu>
	 <1186757538.3335.3.camel@localhost.localdomain>
	 <20070810175808.52b5446a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:37411 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755741AbXHJS2c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 14:28:32 -0400
In-Reply-To: <20070810175808.52b5446a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-pcmcia@lists.infradead.org

On Fri, 2007-08-10 at 17:58 +0100, Alan Cox wrote:
> > Not in non platform code, please ... somewhere on the Janitor's list is
> > moving the dma_mask from the bus specific devices into the generic
> > device ... when that happens this quantity will become u64 and they
> > won't know what to do with the NULL check.
> 
> Ok filed for "kernel summit" 

Surely we don't need to wait until then?  This is the correct fix, isn't
it?  (Obviously I'll split it into a generic and a pcmcia specific piece
if it looks OK to everyone).

It sets the PCMCIA dma_mask up correctly and introduces a DMA_MASK_NONE
(I prefer that to DMA_0BIT_MASK but I can add that too if people want)
and gives Alan his is_device_dma_capable() API.

James

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index a996071..b3837d3 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -23,6 +23,7 @@
 #include <linux/crc32.h>
 #include <linux/firmware.h>
 #include <linux/kref.h>
+#include <linux/dma-mapping.h>
 
 #define IN_CARD_SERVICES
 #include <pcmcia/cs_types.h>
@@ -670,6 +671,9 @@ struct pcmcia_device * pcmcia_device_add(struct pcmcia_socket *s, unsigned int f
 	p_dev->dev.bus = &pcmcia_bus_type;
 	p_dev->dev.parent = s->dev.parent;
 	p_dev->dev.release = pcmcia_release_dev;
+	/* by default don't allow DMA */
+	p_dev->dma_mask = DMA_MASK_NONE;
+	p_dev->dev.dma_mask = &p_dev->dma_mask;
 	bus_id_len = sprintf (p_dev->dev.bus_id, "%d.%d", p_dev->socket->sock, p_dev->device_no);
 
 	p_dev->devname = kmalloc(6 + bus_id_len + 1, GFP_KERNEL);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2dc21cb..0ebfafb 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -24,6 +24,8 @@ enum dma_data_direction {
 #define DMA_28BIT_MASK	0x000000000fffffffULL
 #define DMA_24BIT_MASK	0x0000000000ffffffULL
 
+#define DMA_MASK_NONE	0x0ULL
+
 static inline int valid_dma_direction(int dma_direction)
 {
 	return ((dma_direction == DMA_BIDIRECTIONAL) ||
@@ -31,6 +33,11 @@ static inline int valid_dma_direction(int dma_direction)
 		(dma_direction == DMA_FROM_DEVICE));
 }
 
+static inline int is_device_dma_capable(struct device *dev)
+{
+	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
+}
+
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
 #else
diff --git a/include/pcmcia/ds.h b/include/pcmcia/ds.h
index 90ef552..f047a1f 100644
--- a/include/pcmcia/ds.h
+++ b/include/pcmcia/ds.h
@@ -184,6 +184,7 @@ struct pcmcia_device {
 
 	char *			prod_id[4];
 
+	u64			dma_mask;
 	struct device		dev;
 
 #ifdef CONFIG_PCMCIA_IOCTL


