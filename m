From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: [Patch 2/2] pcmcia: use DMA_MASK_NONE for the default for all
	pcmcia devices
Date: Sun, 16 Sep 2007 12:16:39 -0500
Message-ID: <1189962999.3383.12.camel@localhost.localdomain>
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
Received: from hancock.steeleye.com ([71.30.118.248]:44068 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751551AbXIPRQl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Sep 2007 13:16:41 -0400
In-Reply-To: <1189962755.3383.5.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-pcmcia@lists.infradead.org

Most non cardbus devices can't do dma, so flag them as such in the
device creation routine.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

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
diff --git a/include/pcmcia/ds.h b/include/pcmcia/ds.h
index 90ef552..f047a1f 100644
--- a/include/pcmcia/ds.h
+++ b/include/pcmcia/ds.h
@@ -184,6 +184,7 @@ struct pcmcia_device {
 
 	char *			prod_id[4];
 
+	u64			dma_mask;
 	struct device		dev;
 
 #ifdef CONFIG_PCMCIA_IOCTL


