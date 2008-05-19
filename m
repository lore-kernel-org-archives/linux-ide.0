From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 10/10] sata_mv: ensure empty request queue for FBS-NCQ EH
Date: Mon, 19 May 2008 09:01:24 -0400
Message-ID: <48317A24.4080003@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca> <482F1732.6010109@rtr.ca> <482F1759.20905@rtr.ca> <482F179E.8020602@rtr.ca> <482F17C3.8020106@rtr.ca> <482F17F8.3010403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2993 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbYESNB0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 09:01:26 -0400
In-Reply-To: <482F17F8.3010403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Check for an empty request queue before stopping EDMA after a FBS-NCQ error,
as per recommendation from the Marvell datasheet.

This ensures that the EDMA won't suddenly become active again
just after our subsequent check of the empty/idle bits.

Also bump DRV_VERSION.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Is DRV_VERSION even useful now?
I could do another patch to just nuke it.

--- old/drivers/ata/sata_mv.c	2008-05-16 17:02:26.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-19 08:52:17.000000000 -0400
@@ -72,7 +72,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.20"
+#define DRV_VERSION	"1.21"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -1695,6 +1695,18 @@
 	}
 }
 
+static int mv_req_q_empty(struct ata_port *ap)
+{
+	void __iomem *port_mmio = mv_ap_base(ap);
+	u32 in_ptr, out_ptr;
+
+	in_ptr  = (readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS)
+			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
+	out_ptr = (readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)
+			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
+	return (in_ptr == out_ptr);	/* 1 == queue_is_empty */
+}
+
 static int mv_handle_fbs_ncq_dev_err(struct ata_port *ap)
 {
 	struct mv_port_priv *pp = ap->private_data;
@@ -1728,7 +1740,7 @@
 			ap->qc_active, failed_links,
 			ap->nr_active_links);
 
-	if (ap->nr_active_links <= failed_links) {
+	if (ap->nr_active_links <= failed_links && mv_req_q_empty(ap)) {
 		mv_process_crpb_entries(ap, pp);
 		mv_stop_edma(ap);
 		mv_eh_freeze(ap);
