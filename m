From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 8/9] libata: remove writing of tf->ctl from ata_tf_load()
Date: Fri, 15 Jun 2007 11:34:43 +0800
Message-ID: <467208D3.6090900@tw.ibm.com>
References: <46720353.90209@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:58861 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbXFODet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 23:34:49 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5F3YmMB011087
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 23:34:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5F3YmES216362
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:34:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5F3YlbN021764
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:34:48 -0600
In-Reply-To: <46720353.90209@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Doug Maxey <dwm@enoyolf.org>

Patch 8/9:
 
Currently ata_tf_load() writes to the Control register if it is changed.

The relevant bits in the ctl register are HOB, SRST and nIEN.
 - HOB is only used by ata_tf_read().
 - For SRST, soft reset is not the duty of tf_load.
 - For nIEN, explicit irq_on()/irq_off and freeze()/thaw() are provided.

  Since EH/HSM now call freeze()/thaw() for irq off/on explicitly.
The implicit nIEN handling is removed from ata_tf_load().
The nIEN snoop codes are also removed from sata_vsc.


Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 07_sata_promise_freeze/drivers/ata/libata-sff.c 08_tfload_cleanup/drivers/ata/libata-sff.c
--- 07_sata_promise_freeze/drivers/ata/libata-sff.c	2007-06-12 13:15:17.000000000 +0800
+++ 08_tfload_cleanup/drivers/ata/libata-sff.c	2007-06-12 14:52:57.000000000 +0800
@@ -153,11 +153,13 @@ void ata_tf_load(struct ata_port *ap, co
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
-	if (tf->ctl != ap->last_ctl) {
-		iowrite8(tf->ctl, ioaddr->ctl_addr);
-		ap->last_ctl = tf->ctl;
-		ata_wait_idle(ap);
-	}
+	/*
+	 * The relevant bits in the ctl register are HOB, SRST and nIEN.
+	 * HOB is only used by ata_tf_read().
+	 * For SRST, soft reset is not the duty of tf_load.
+	 * For nIEN, explicit ->irq_on() and ->irq_off are provided.
+	 * That's why tf->ctl is ignored here.
+	 */
 
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
 		iowrite8(tf->hob_feature, ioaddr->feature_addr);
diff -Nrup 07_sata_promise_freeze/drivers/ata/pata_scc.c 08_tfload_cleanup/drivers/ata/pata_scc.c
--- 07_sata_promise_freeze/drivers/ata/pata_scc.c	2007-06-12 14:58:15.000000000 +0800
+++ 08_tfload_cleanup/drivers/ata/pata_scc.c	2007-06-12 14:58:20.000000000 +0800
@@ -271,12 +271,6 @@ static void scc_tf_load (struct ata_port
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
-	if (tf->ctl != ap->last_ctl) {
-		out_be32(ioaddr->ctl_addr, tf->ctl);
-		ap->last_ctl = tf->ctl;
-		ata_wait_idle(ap);
-	}
-
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
 		out_be32(ioaddr->feature_addr, tf->hob_feature);
 		out_be32(ioaddr->nsect_addr, tf->hob_nsect);
diff -Nrup 07_sata_promise_freeze/drivers/ata/sata_svw.c 08_tfload_cleanup/drivers/ata/sata_svw.c
--- 07_sata_promise_freeze/drivers/ata/sata_svw.c	2007-06-11 17:24:51.000000000 +0800
+++ 08_tfload_cleanup/drivers/ata/sata_svw.c	2007-06-12 13:37:46.000000000 +0800
@@ -125,11 +125,6 @@ static void k2_sata_tf_load(struct ata_p
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
-	if (tf->ctl != ap->last_ctl) {
-		writeb(tf->ctl, ioaddr->ctl_addr);
-		ap->last_ctl = tf->ctl;
-		ata_wait_idle(ap);
-	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
 		writew(tf->feature | (((u16)tf->hob_feature) << 8),
 		       ioaddr->feature_addr);
diff -Nrup 07_sata_promise_freeze/drivers/ata/sata_vsc.c 08_tfload_cleanup/drivers/ata/sata_vsc.c
--- 07_sata_promise_freeze/drivers/ata/sata_vsc.c	2007-06-11 17:25:50.000000000 +0800
+++ 08_tfload_cleanup/drivers/ata/sata_vsc.c	2007-06-13 13:47:24.000000000 +0800
@@ -137,36 +137,11 @@ static void vsc_thaw(struct ata_port *ap
 }
 
 
-static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
-{
-	void __iomem *mask_addr;
-	u8 mask;
-
-	mask_addr = ap->host->iomap[VSC_MMIO_BAR] +
-		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
-	mask = readb(mask_addr);
-	if (ctl & ATA_NIEN)
-		mask |= 0x80;
-	else
-		mask &= 0x7F;
-	writeb(mask, mask_addr);
-}
-
-
 static void vsc_sata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
-	/*
-	 * The only thing the ctl register is used for is SRST.
-	 * That is not enabled or disabled via tf_load.
-	 * However, if ATA_NIEN is changed, then we need to change the interrupt register.
-	 */
-	if ((tf->ctl & ATA_NIEN) != (ap->last_ctl & ATA_NIEN)) {
-		ap->last_ctl = tf->ctl;
-		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
-	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
 		writew(tf->feature | (((u16)tf->hob_feature) << 8),
 		       ioaddr->feature_addr);


