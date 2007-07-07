From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 6/7] libata: remove nIEN handling from ata_tf_load()
Date: Sat, 07 Jul 2007 15:20:24 +0800
Message-ID: <468F3EB8.2050102@tw.ibm.com>
References: <468F3949.5050800@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:55456 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbXGGHUe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 03:20:34 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l677KVXd025985
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 03:20:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l677KUuh248208
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:20:30 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l677KUZT012026
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:20:30 -0600
In-Reply-To: <468F3949.5050800@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

The relevant bits in the ctl register are HOB, SRST and nIEN.
 - HOB is only used by ata_tf_read().
 - For SRST, soft reset is not the duty of tf_load.
 - For nIEN, explicit irq_on()/irq_off and freeze()/thaw() are provided.

Remove the implicit nIEN handling from ata_tf_load() since EH/HSM now
calls irq_on/irq_off explicitly. vsc_intr_mask_update() also removed
since now unused.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
The bitmasks used by vsc_intr_mask_update() are different to the bit masks
in vsc_irq_on() and vsc_irq_off(). I don't know which one is more correct.
Maybe we need more test and see if vsc_irq_on()/vsc_irq_off() works for
turning irq on/off for polling pio.

diff -Nrup 05_rename_thaw_lldd/drivers/ata/libata-sff.c 06_tf_load_cleanup/drivers/ata/libata-sff.c
--- 05_rename_thaw_lldd/drivers/ata/libata-sff.c	2007-07-07 10:49:04.000000000 +0800
+++ 06_tf_load_cleanup/drivers/ata/libata-sff.c	2007-07-07 10:50:10.000000000 +0800
@@ -143,11 +143,13 @@ void ata_tf_load(struct ata_port *ap, co
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
diff -Nrup 05_rename_thaw_lldd/drivers/ata/pata_scc.c 06_tf_load_cleanup/drivers/ata/pata_scc.c
--- 05_rename_thaw_lldd/drivers/ata/pata_scc.c	2007-07-07 10:49:30.000000000 +0800
+++ 06_tf_load_cleanup/drivers/ata/pata_scc.c	2007-07-07 10:50:10.000000000 +0800
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
diff -Nrup 05_rename_thaw_lldd/drivers/ata/sata_svw.c 06_tf_load_cleanup/drivers/ata/sata_svw.c
--- 05_rename_thaw_lldd/drivers/ata/sata_svw.c	2007-07-07 10:49:30.000000000 +0800
+++ 06_tf_load_cleanup/drivers/ata/sata_svw.c	2007-07-07 10:50:10.000000000 +0800
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
diff -Nrup 05_rename_thaw_lldd/drivers/ata/sata_vsc.c 06_tf_load_cleanup/drivers/ata/sata_vsc.c
--- 05_rename_thaw_lldd/drivers/ata/sata_vsc.c	2007-07-07 10:49:30.000000000 +0800
+++ 06_tf_load_cleanup/drivers/ata/sata_vsc.c	2007-07-07 10:50:10.000000000 +0800
@@ -137,36 +137,19 @@ static void vsc_irq_on(struct ata_port *
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
 
 	/*
-	 * The only thing the ctl register is used for is SRST.
-	 * That is not enabled or disabled via tf_load.
-	 * However, if ATA_NIEN is changed, then we need to change the interrupt register.
+	 * The relevant bits in the ctl register are HOB, SRST and nIEN.
+	 * HOB is only used by ata_tf_read().
+	 * For SRST, soft reset is not the duty of tf_load.
+	 * For nIEN, explicit ->irq_on() and ->irq_off are provided.
+	 * That's why tf->ctl is ignored here.
 	 */
-	if ((tf->ctl & ATA_NIEN) != (ap->last_ctl & ATA_NIEN)) {
-		ap->last_ctl = tf->ctl;
-		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
-	}
+
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
 		writew(tf->feature | (((u16)tf->hob_feature) << 8),
 		       ioaddr->feature_addr);


