From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pnp: use struct ide_port_info
Date: Sat, 24 Jan 2009 15:17:00 +0100
Message-ID: <200901241517.00398.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:60595 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbZAXOVY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:21:24 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pnp: use struct ide_port_info

This fixes hwif->channel and drive->dn assignments.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-pnp.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-pnp.c
===================================================================
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -27,6 +27,10 @@ static struct pnp_device_id idepnp_devic
 	{.id = ""}
 };
 
+static const struct ide_port_info ide_pnp_port_info = {
+	.host_flags		= IDE_HFLAG_NO_DMA,
+};
+
 static int idepnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct ide_host *host;
@@ -60,7 +64,7 @@ static int idepnp_probe(struct pnp_dev *
 	hw.irq = pnp_irq(dev, 0);
 	hw.chipset = ide_generic;
 
-	rc = ide_host_add(NULL, hws, &host);
+	rc = ide_host_add(&ide_pnp_port_info, hws, &host);
 	if (rc)
 		goto out;
 
