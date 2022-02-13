Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E4EC433FE
	for <linux-ide@archiver.kernel.org>; Sun, 13 Feb 2022 15:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiBMPKo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 13 Feb 2022 10:10:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiBMPKm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 13 Feb 2022 10:10:42 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EF15C37A
        for <linux-ide@vger.kernel.org>; Sun, 13 Feb 2022 07:10:35 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 120492314A7A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v2 2/2] ata: libata-sff: refactor ata_sff_altstatus()
Date:   Sun, 13 Feb 2022 18:10:32 +0300
Message-ID: <20220213151032.4694-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220213151032.4694-1-s.shtylyov@omp.ru>
References: <20220213151032.4694-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The driver's calls to ata_sff_altstatus() are mostly surrounded by some
clumsy checks.  Refactor ata_sff_altstatus() to include the repetitive
checks and return a 'bool' result indicating if the alternate
status register exists or not.

While at it, further update the 'kernel-doc' comment -- the alternate
status register has never been a part of the taskfile, despite what
Jeff and co. think! :-)

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libata-sff.c | 56 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 3fb5bd4de50c..fc8915964919 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -70,22 +70,35 @@ EXPORT_SYMBOL_GPL(ata_sff_check_status);
 /**
  *	ata_sff_altstatus - Read device alternate status reg
  *	@ap: port where the device is
+ *	@status: pointer to a status value
  *
- *	Reads ATA taskfile alternate status register for
- *	currently-selected device and return its value.
+ *	Reads ATA alternate status register for currently-selected device
+ *	and return its value.
  *
- *	Note: may NOT be used as the check_altstatus() entry in
- *	ata_port_operations.
+ *	RETURN:
+ *	true if the register exists, false if not.
  *
  *	LOCKING:
  *	Inherited from caller.
  */
-static u8 ata_sff_altstatus(struct ata_port *ap)
+static bool ata_sff_altstatus(struct ata_port *ap, u8 *status)
 {
-	if (ap->ops->sff_check_altstatus)
-		return ap->ops->sff_check_altstatus(ap);
+	u8 tmp;
 
-	return ioread8(ap->ioaddr.altstatus_addr);
+	if (ap->ops->sff_check_altstatus) {
+		tmp = ap->ops->sff_check_altstatus(ap);
+		goto read;
+	}
+	if (ap->ioaddr.altstatus_addr) {
+		tmp = ioread8(ap->ioaddr.altstatus_addr);
+		goto read;
+	}
+	return false;
+
+read:
+	if (status)
+		*status = tmp;
+	return true;
 }
 
 /**
@@ -104,12 +117,9 @@ static u8 ata_sff_irq_status(struct ata_port *ap)
 {
 	u8 status;
 
-	if (ap->ops->sff_check_altstatus || ap->ioaddr.altstatus_addr) {
-		status = ata_sff_altstatus(ap);
-		/* Not us: We are busy */
-		if (status & ATA_BUSY)
-			return status;
-	}
+	/* Not us: We are busy */
+	if (ata_sff_altstatus(ap, &status) && (status & ATA_BUSY))
+		return status;
 	/* Clear INTRQ latch */
 	status = ap->ops->sff_check_status(ap);
 	return status;
@@ -129,10 +139,7 @@ static u8 ata_sff_irq_status(struct ata_port *ap)
 
 static void ata_sff_sync(struct ata_port *ap)
 {
-	if (ap->ops->sff_check_altstatus)
-		ap->ops->sff_check_altstatus(ap);
-	else if (ap->ioaddr.altstatus_addr)
-		ioread8(ap->ioaddr.altstatus_addr);
+	ata_sff_altstatus(ap, NULL);
 }
 
 /**
@@ -164,12 +171,12 @@ EXPORT_SYMBOL_GPL(ata_sff_pause);
 
 void ata_sff_dma_pause(struct ata_port *ap)
 {
-	if (ap->ops->sff_check_altstatus || ap->ioaddr.altstatus_addr) {
-		/* An altstatus read will cause the needed delay without
-		   messing up the IRQ status */
-		ata_sff_altstatus(ap);
+	/*
+	 * An altstatus read will cause the needed delay without
+	 * messing up the IRQ status
+	 */
+	if (ata_sff_altstatus(ap, NULL))
 		return;
-	}
 	/* There are no DMA controllers without ctl. BUG here to ensure
 	   we never violate the HDMA1:0 transition timing and risk
 	   corruption. */
@@ -1637,8 +1644,7 @@ void ata_sff_lost_interrupt(struct ata_port *ap)
 		return;
 	/* See if the controller thinks it is still busy - if so the command
 	   isn't a lost IRQ but is still in progress */
-	status = ata_sff_altstatus(ap);
-	if (status & ATA_BUSY)
+	if (ata_sff_altstatus(ap, &status) && (status & ATA_BUSY))
 		return;
 
 	/* There was a command running, we are no longer busy and we have
-- 
2.26.3

