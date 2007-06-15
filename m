From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 4/9] libata: call irq_off from bmdma_freeze()
Date: Fri, 15 Jun 2007 11:21:24 +0800
Message-ID: <467205B4.1050606@tw.ibm.com>
References: <46720353.90209@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:58945 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbXFODV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 23:21:28 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5F3LSuV002097
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 23:21:28 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5F3LRJ8216582
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:21:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5F3LRSZ001895
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:21:27 -0600
In-Reply-To: <46720353.90209@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Doug Maxey <dwm@enoyolf.org>

Patch 4/9:
  Minor patch to call irq_off() from bmdma_freeze() to avoid duplicated code.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 03_add_irq_off_lldd/drivers/ata/libata-sff.c 04_convert_freeze/drivers/ata/libata-sff.c
--- 03_add_irq_off_lldd/drivers/ata/libata-sff.c	2007-06-12 13:15:13.000000000 +0800
+++ 04_convert_freeze/drivers/ata/libata-sff.c	2007-06-12 13:15:17.000000000 +0800
@@ -413,20 +413,7 @@ void ata_bmdma_stop(struct ata_queued_cm
  */
 void ata_bmdma_freeze(struct ata_port *ap)
 {
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	iowrite8(ap->ctl, ioaddr->ctl_addr);
-
-	/* Under certain circumstances, some controllers raise IRQ on
-	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
-	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
-	 */
-	ata_chk_status(ap);
-
-	ap->ops->irq_clear(ap);
+	ap->ops->irq_off(ap);
 }
 
 /**
diff -Nrup 03_add_irq_off_lldd/drivers/ata/pata_scc.c 04_convert_freeze/drivers/ata/pata_scc.c
--- 03_add_irq_off_lldd/drivers/ata/pata_scc.c	2007-06-12 13:06:12.000000000 +0800
+++ 04_convert_freeze/drivers/ata/pata_scc.c	2007-06-12 14:58:03.000000000 +0800
@@ -875,20 +875,7 @@ static u8 scc_irq_ack (struct ata_port *
 
 static void scc_bmdma_freeze (struct ata_port *ap)
 {
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	out_be32(ioaddr->ctl_addr, ap->ctl);
-
-	/* Under certain circumstances, some controllers raise IRQ on
-	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
-	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
-	 */
-	ata_chk_status(ap);
-
-	ap->ops->irq_clear(ap);
+	scc_irq_off(ap);
 }
 
 /**


