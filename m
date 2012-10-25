From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] sata_sx4: pdc20621_{ata|host}_sg() do not need 'tf' parameter
Date: Thu, 25 Oct 2012 21:19:12 +0400
Message-ID: <201210252119.13022.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:55401 "EHLO
	wasted.dev.rtsoft.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935930Ab2JYRUs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2012 13:20:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

... because those functions don't use this parameter.

While at it, correctly align 'total_len' parameter.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the 'upstream' branch of libata-dev.git...

 drivers/ata/sata_sx4.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: libata-dev/drivers/ata/sata_sx4.c
===================================================================
--- libata-dev.orig/drivers/ata/sata_sx4.c
+++ libata-dev/drivers/ata/sata_sx4.c
@@ -315,9 +315,8 @@ static int pdc_port_start(struct ata_por
 	return 0;
 }
 
-static inline void pdc20621_ata_sg(struct ata_taskfile *tf, u8 *buf,
-				   unsigned int portno,
-					   unsigned int total_len)
+static inline void pdc20621_ata_sg(u8 *buf, unsigned int portno,
+				   unsigned int total_len)
 {
 	u32 addr;
 	unsigned int dw = PDC_DIMM_APKT_PRD >> 2;
@@ -337,9 +336,8 @@ static inline void pdc20621_ata_sg(struc
 		buf32[dw], buf32[dw + 1]);
 }
 
-static inline void pdc20621_host_sg(struct ata_taskfile *tf, u8 *buf,
-				    unsigned int portno,
-					    unsigned int total_len)
+static inline void pdc20621_host_sg(u8 *buf, unsigned int portno,
+				    unsigned int total_len)
 {
 	u32 addr;
 	unsigned int dw = PDC_DIMM_HPKT_PRD >> 2;
@@ -486,10 +484,10 @@ static void pdc20621_dma_prep(struct ata
 	/*
 	 * Build ATA, host DMA packets
 	 */
-	pdc20621_host_sg(&qc->tf, &pp->dimm_buf[0], portno, total_len);
+	pdc20621_host_sg(&pp->dimm_buf[0], portno, total_len);
 	pdc20621_host_pkt(&qc->tf, &pp->dimm_buf[0], portno);
 
-	pdc20621_ata_sg(&qc->tf, &pp->dimm_buf[0], portno, total_len);
+	pdc20621_ata_sg(&pp->dimm_buf[0], portno, total_len);
 	i = pdc20621_ata_pkt(&qc->tf, qc->dev->devno, &pp->dimm_buf[0], portno);
 
 	if (qc->tf.flags & ATA_TFLAG_LBA48)
