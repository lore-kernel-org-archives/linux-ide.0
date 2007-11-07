From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 2/4] libata sata_qstor nuke idle state
Date: Wed, 07 Nov 2007 10:52:55 -0500
Message-ID: <4731DF57.9010701@rtr.ca>
References: <4731DF06.3050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4406 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753956AbXKGPw4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 10:52:56 -0500
In-Reply-To: <4731DF06.3050202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_qstor nuke idle state.

We're really only ever in one of two hardware states:  packet, or mmio.
Get rid of unnecessary "qs_state_idle" state.

This belongs in 2.6.24.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_qstor.c	2007-11-07 07:41:28.000000000 -0500
+++ linux/drivers/ata/sata_qstor.c	2007-11-07 08:06:29.000000000 -0500
@@ -103,7 +103,7 @@
 	QS_DMA_BOUNDARY		= ~0UL
 };
 
-typedef enum { qs_state_idle, qs_state_pkt, qs_state_mmio } qs_state_t;
+typedef enum { qs_state_mmio, qs_state_pkt } qs_state_t;
 
 struct qs_port_priv {
 	u8			*pkt;
@@ -222,7 +222,9 @@
 static inline void qs_enter_reg_mode(struct ata_port *ap)
 {
 	u8 __iomem *chan = qs_mmio_base(ap->host) + (ap->port_no * 0x4000);
+	struct qs_port_priv *pp = ap->private_data;
 
+	pp->state = qs_state_mmio;
 	writeb(QS_CTR0_REG, chan + QS_CCT_CTR0);
 	readb(chan + QS_CCT_CTR0);        /* flush */
 }
@@ -238,19 +240,12 @@
 
 static void qs_phy_reset(struct ata_port *ap)
 {
-	struct qs_port_priv *pp = ap->private_data;
-
-	pp->state = qs_state_idle;
 	qs_reset_channel_logic(ap);
 	sata_phy_reset(ap);
 }
 
 static void qs_eng_timeout(struct ata_port *ap)
 {
-	struct qs_port_priv *pp = ap->private_data;
-
-	if (pp->state != qs_state_idle) /* healthy paranoia */
-		pp->state = qs_state_mmio;
 	qs_reset_channel_logic(ap);
 	ata_eng_timeout(ap);
 }
@@ -409,7 +404,6 @@
 					switch (sHST) {
 					case 0: /* successful CPB */
 					case 3: /* device error */
-						pp->state = qs_state_idle;
 						qs_enter_reg_mode(qc->ap);
 						qc->err_mask |= ac_err_mask(sDST);
 						ata_qc_complete(qc);
@@ -448,7 +442,6 @@
 					ap->print_id, qc->tf.protocol, status);
 
 				/* complete taskfile transaction */
-				pp->state = qs_state_idle;
 				qc->err_mask |= ac_err_mask(status);
 				ata_qc_complete(qc);
 				handled = 1;
@@ -504,7 +497,6 @@
 	rc = ata_port_start(ap);
 	if (rc)
 		return rc;
-	qs_enter_reg_mode(ap);
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		return -ENOMEM;
@@ -515,6 +507,7 @@
 	memset(pp->pkt, 0, QS_PKT_BYTES);
 	ap->private_data = pp;
 
+	qs_enter_reg_mode(ap);
 	addr = (u64)pp->pkt_dma;
 	writel((u32) addr,        chan + QS_CCF_CPBA);
 	writel((u32)(addr >> 32), chan + QS_CCF_CPBA + 4);
