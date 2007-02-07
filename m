From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH] sata_promise: fix missing PATA cable detection
Date: Wed, 7 Feb 2007 22:29:56 +0100 (MET)
Message-ID: <200702072129.l17LTujt012924@alkaid.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:36710 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422738AbXBGVaQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Feb 2007 16:30:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

This patch fixes an oversight which caused sata_promise to
not perform cable detection on the TX2plus chips' PATA ports.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

---

This patch adds yet another is-PATA-or-SATA? check, but it's in a
cold path so shouldn't matter much. This will be cleaned up if/when
PATA ports and SATA ports start using different ops structures.

--- linux-2.6.20/drivers/ata/sata_promise.c.~1~	2007-02-07 20:30:20.000000000 +0100
+++ linux-2.6.20/drivers/ata/sata_promise.c	2007-02-07 20:57:34.000000000 +0100
@@ -601,6 +601,13 @@ static void pdc_thaw(struct ata_port *ap
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }
 
+static int pdc_pre_reset(struct ata_port *ap)
+{
+	if (!sata_scr_valid(ap))
+		pdc_pata_cbl_detect(ap);
+	return ata_std_prereset(ap);
+}
+
 static void pdc_error_handler(struct ata_port *ap)
 {
 	ata_reset_fn_t hardreset;
@@ -613,7 +620,7 @@ static void pdc_error_handler(struct ata
 		hardreset = sata_std_hardreset;
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
+	ata_do_eh(ap, pdc_pre_reset, ata_std_softreset, hardreset,
 		  ata_std_postreset);
 }
 
