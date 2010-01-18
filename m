From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 07/64] pata_atiixp: enable parallel scan
Date: Mon, 18 Jan 2010 18:14:47 +0100
Message-ID: <20100118171447.14623.47438.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:61470 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab0ARRP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:15:59 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atiixp: enable parallel scan

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_atiixp.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Index: b/drivers/ata/pata_atiixp.c
===================================================================
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -189,8 +189,23 @@ static int atiixp_init_one(struct pci_de
 		.port_ops = &atiixp_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, &info };
+	struct ata_host *host;
+	int rc;
 
-	return ata_pci_sff_init_one(pdev, ppi, &atiixp_sht, NULL);
+	/* enable device and prepare host */
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
+	if (rc)
+		return rc;
+
+	host->flags |= ATA_HOST_PARALLEL_SCAN;
+
+	pci_set_master(pdev);
+
+	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &atiixp_sht);
 }
 
 static const struct pci_device_id atiixp[] = {
