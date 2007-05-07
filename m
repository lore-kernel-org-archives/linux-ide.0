From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Mon, 07 May 2007 12:30:05 +0800
Message-ID: <463EAB4D.3000309@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58524 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbXEGEaO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 00:30:14 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l474UDEg001159
	for <linux-ide@vger.kernel.org>; Mon, 7 May 2007 00:30:13 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l474UD5v052126
	for <linux-ide@vger.kernel.org>; Sun, 6 May 2007 22:30:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l474UC0X016518
	for <linux-ide@vger.kernel.org>; Sun, 6 May 2007 22:30:13 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Problem:
  Kernel got "irq 5: nobody cared" when using
  libata + polling IDENTIFY + Promise 20275 adapter + Benq DW1620 drive.

  Detail message available in bug 8441 (http://bugzilla.kernel.org/show_bug.cgi?id=8441).

Cause:
 The Benq DW1620 drive raises INTRQ during polling IDENTIFY PACKET DEVICE,
 even if nIEN = 1.

Proposed fix:
  disable_irq() during polling IDENTIFY to work around, the same as what IDE subsystem does.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Some controller like Intel ICH4 is immune from the problem, with the same kernel
and the same Benq DW1620 drive. So, adding the ATA_FLAG_IDENT_IRQ_OFF flag for
those adapters that needs the workaround. Patch against 2.6.21.1 for your review, thanks.

diff -Nrup linux-2.6.21.1-ori/drivers/ata/libata-core.c linux-2.6.21.1-mod2/drivers/ata/libata-core.c
--- linux-2.6.21.1-ori/drivers/ata/libata-core.c	2007-05-04 11:22:23.000000000 +0800
+++ linux-2.6.21.1-mod2/drivers/ata/libata-core.c	2007-05-07 11:00:02.000000000 +0800
@@ -1427,6 +1427,7 @@ int ata_dev_read_id(struct ata_device *d
 		    unsigned int flags, u16 *id)
 {
 	struct ata_port *ap = dev->ap;
+	struct ata_host *host = ap->host;
 	unsigned int class = *p_class;
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
@@ -1466,8 +1467,29 @@ int ata_dev_read_id(struct ata_device *d
 	 */
 	tf.flags |= ATA_TFLAG_POLLING;
 
+	/* Disable IRQ since some devices like Benq DW1620 raises INTRQ
+	 * when IDENTIFY PACKET DEVICE, even with polling IDENTIFY.
+	 */
+	if (ap->flags & ATA_FLAG_IDENT_IRQ_OFF) {
+		if (host->irq)
+			disable_irq(host->irq);
+
+		if (host->irq2)
+			disable_irq(host->irq2);
+	}
+
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
+
+	/* Re-enable IRQ */
+	if (ap->flags & ATA_FLAG_IDENT_IRQ_OFF) {
+		if (host->irq)
+			enable_irq(host->irq);
+
+		if (host->irq2)
+			enable_irq(host->irq2);
+	}
+
 	if (err_mask) {
 		if (err_mask & AC_ERR_NODEV_HINT) {
 			DPRINTK("ata%u.%d: NODEV after polling detection\n",
diff -Nrup linux-2.6.21.1-ori/drivers/ata/pata_pdc2027x.c linux-2.6.21.1-mod2/drivers/ata/pata_pdc2027x.c
--- linux-2.6.21.1-ori/drivers/ata/pata_pdc2027x.c	2007-04-28 05:49:26.000000000 +0800
+++ linux-2.6.21.1-mod2/drivers/ata/pata_pdc2027x.c	2007-05-07 10:44:33.000000000 +0800
@@ -214,7 +214,7 @@ static struct ata_port_info pdc2027x_por
 	{
 		.sht		= &pdc2027x_sht,
 		.flags		= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
-		                  ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO | ATA_FLAG_IDENT_IRQ_OFF,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5, /* udma0-5 */
@@ -224,7 +224,7 @@ static struct ata_port_info pdc2027x_por
 	{
 		.sht		= &pdc2027x_sht,
 		.flags		= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
-                        	  ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO | ATA_FLAG_IDENT_IRQ_OFF,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6, /* udma0-6 */
diff -Nrup linux-2.6.21.1-ori/include/linux/libata.h linux-2.6.21.1-mod2/include/linux/libata.h
--- linux-2.6.21.1-ori/include/linux/libata.h	2007-04-28 05:49:26.000000000 +0800
+++ linux-2.6.21.1-mod2/include/linux/libata.h	2007-05-07 12:25:05.000000000 +0800
@@ -174,6 +174,7 @@ enum {
 	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
+	ATA_FLAG_IDENT_IRQ_OFF	= (1 << 17), /* disable irq when IDENTIFY */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be


