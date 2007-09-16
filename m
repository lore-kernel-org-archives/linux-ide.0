From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH 1/1] introduce DMA_MASK_NONE as a signal for unable to do
	DMA
Date: Sun, 16 Sep 2007 12:15:12 -0500
Message-ID: <1189962913.3383.9.camel@localhost.localdomain>
References: <20070809233458.12d8447c@the-village.bc.nu>
	 <20070809224305.GA1611@one.firstfloor.org>
	 <20070810001443.610185e1@the-village.bc.nu>
	 <20070809231141.GB1845@one.firstfloor.org>
	 <20070810002453.384a9b4c@the-village.bc.nu>
	 <p73sl6rencd.fsf@bingen.suse.de>
	 <20070810145430.17d72a76@the-village.bc.nu>
	 <1186757538.3335.3.camel@localhost.localdomain>
	 <20070810175808.52b5446a@the-village.bc.nu>
	 <1186770505.6334.3.camel@localhost.localdomain>
	 <20070810202718.GB11892@one.firstfloor.org>
	 <1189962755.3383.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:40273 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752170AbXIPRPO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Sep 2007 13:15:14 -0400
In-Reply-To: <1189962755.3383.5.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-pcmcia@lists.infradead.org

Some devices are incapable of DMA and need to be recognised as such.
Introduce a NONE dma mask to facilitate this plus an inline function:
is_device_dma_capable() to check this.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

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


