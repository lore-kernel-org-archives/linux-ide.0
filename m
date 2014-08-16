From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] ata: propagate return value of scc_wait_after_reset
Date: Sat, 16 Aug 2014 19:48:04 +0530
Message-ID: <1408198684-2258-1-git-send-email-arjun024@gmail.com>
References: <53ef6157.qX8Csumbm2zNx/EI%fengguang.wu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41531 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaHPOSV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Aug 2014 10:18:21 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so4995487pab.0
        for <linux-ide@vger.kernel.org>; Sat, 16 Aug 2014 07:18:16 -0700 (PDT)
In-Reply-To: <53ef6157.qX8Csumbm2zNx/EI%fengguang.wu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

scc_bus_softreset not necessarily should return zero.
Propagate the error code.

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 drivers/ata/pata_scc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 4e006d7..b5013dc 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -585,7 +585,7 @@ static int scc_wait_after_reset(struct ata_link *link, unsigned int devmask,
  *	Note: Original code is ata_bus_softreset().
  */
 
-static unsigned int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
+static int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
                                       unsigned long deadline)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
@@ -599,9 +599,7 @@ static unsigned int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	udelay(20);
 	out_be32(ioaddr->ctl_addr, ap->ctl);
 
-	scc_wait_after_reset(&ap->link, devmask, deadline);
-
-	return 0;
+	return scc_wait_after_reset(&ap->link, devmask, deadline);
 }
 
 /**
@@ -618,7 +616,8 @@ static int scc_softreset(struct ata_link *link, unsigned int *classes,
 {
 	struct ata_port *ap = link->ap;
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
-	unsigned int devmask = 0, err_mask;
+	unsigned int devmask = 0;
+	int rc;
 	u8 err;
 
 	DPRINTK("ENTER\n");
@@ -634,8 +633,8 @@ static int scc_softreset(struct ata_link *link, unsigned int *classes,
 
 	/* issue bus reset */
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
-	err_mask = scc_bus_softreset(ap, devmask, deadline);
-	if (err_mask) {
- 		ata_port_err(ap, "SRST failed (err_mask=0x%x)\n", err_mask);
+	rc = scc_bus_softreset(ap, devmask, deadline);
+	if (rc) {
+ 		ata_port_err(ap, "SRST failed (err_mask=0x%x)\n", rc);
 		return -EIO;
 	}
-- 
1.7.11.7

