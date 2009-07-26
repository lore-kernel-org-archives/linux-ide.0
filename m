From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: remove superfluous NULL pointer checks
Date: Sun, 26 Jul 2009 16:05:13 +0200
Message-ID: <200907261605.14619.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60599 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbZGYOKf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Jul 2009 10:10:35 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: remove superfluous NULL pointer checks

host->ports[] always contain pointers to valid port structures since
a "dummy port" structure is used in case if there is no physical port.

This patch takes care of two entries from Dan's list:

drivers/ata/sata_sil.c +535 sil_interrupt(13) warning: variable derefenced before check 'ap'
drivers/ata/sata_mv.c +2517 mv_unexpected_intr(6) warning: variable derefenced before check 'ap'

and of another needless NULL pointer check in pata_octeon_cf.c.

Reported-by: Dan Carpenter <error27@gmail.com>
Cc: corbet@lwn.net
Cc: eteo@redhat.com
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_octeon_cf.c |    3 ++-
 drivers/ata/sata_mv.c        |    2 +-
 drivers/ata/sata_sil.c       |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/ata/pata_octeon_cf.c
===================================================================
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -653,7 +653,8 @@ static irqreturn_t octeon_cf_interrupt(i
 
 		ap = host->ports[i];
 		ocd = ap->dev->platform_data;
-		if (!ap || (ap->flags & ATA_FLAG_DISABLED))
+
+		if (ap->flags & ATA_FLAG_DISABLED)
 			continue;
 
 		ocd = ap->dev->platform_data;
Index: b/drivers/ata/sata_mv.c
===================================================================
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2514,7 +2514,7 @@ static void mv_unexpected_intr(struct at
 	char *when = "idle";
 
 	ata_ehi_clear_desc(ehi);
-	if (!ap || (ap->flags & ATA_FLAG_DISABLED)) {
+	if (ap->flags & ATA_FLAG_DISABLED) {
 		when = "disabled";
 	} else if (edma_was_enabled) {
 		when = "EDMA enabled";
Index: b/drivers/ata/sata_sil.c
===================================================================
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -532,7 +532,7 @@ static irqreturn_t sil_interrupt(int irq
 		struct ata_port *ap = host->ports[i];
 		u32 bmdma2 = readl(mmio_base + sil_port[ap->port_no].bmdma2);
 
-		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
+		if (unlikely(ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
 		/* turn off SATA_IRQ if not supported */
