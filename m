From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/10] sata_inic162x: misc clean ups
Date: Wed, 30 Apr 2008 16:35:08 +0900
Message-ID: <1209540918258-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.245]:29897 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754231AbYD3HfX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:23 -0400
Received: by rv-out-0506.google.com with SMTP id k29so211406rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:23 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* use larger indents for structure member definitions

* kill unused variable @addr in inic_scr_write()

* kill unnecessary flushes in inic_freeze/thaw()

* kill buggy explicit kfree() on devres managed port private data

This is in preparation of further inic162x updates.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index d27bb9a..1f5d17e 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -99,13 +99,13 @@ enum {
 };
 
 struct inic_host_priv {
-	u16	cached_hctl;
+	u16		cached_hctl;
 };
 
 struct inic_port_priv {
-	u8	dfl_prdctl;
-	u8	cached_prdctl;
-	u8	cached_pirq_mask;
+	u8		dfl_prdctl;
+	u8		cached_prdctl;
+	u8		cached_pirq_mask;
 };
 
 static struct scsi_host_template inic_sht = {
@@ -185,12 +185,10 @@ static int inic_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val)
 static int inic_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 {
 	void __iomem *scr_addr = ap->ioaddr.scr_addr;
-	void __iomem *addr;
 
 	if (unlikely(sc_reg >= ARRAY_SIZE(scr_map)))
 		return -EINVAL;
 
-	addr = scr_addr + scr_map[sc_reg] * 4;
 	writel(val, scr_addr + scr_map[sc_reg] * 4);
 	return 0;
 }
@@ -367,8 +365,6 @@ static void inic_freeze(struct ata_port *ap)
 
 	ap->ops->sff_check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
-
-	readb(port_base + PORT_IRQ_STAT); /* flush */
 }
 
 static void inic_thaw(struct ata_port *ap)
@@ -379,8 +375,6 @@ static void inic_thaw(struct ata_port *ap)
 	writeb(0xff, port_base + PORT_IRQ_STAT);
 
 	__inic_set_pirq_mask(ap, PIRQ_MASK_OTHER);
-
-	readb(port_base + PORT_IRQ_STAT); /* flush */
 }
 
 /*
@@ -506,10 +500,8 @@ static int inic_port_start(struct ata_port *ap)
 
 	/* Alloc resources */
 	rc = ata_port_start(ap);
-	if (rc) {
-		kfree(pp);
+	if (rc)
 		return rc;
-	}
 
 	init_port(ap);
 
-- 
1.5.2.4

