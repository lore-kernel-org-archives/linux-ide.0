From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v5 2/4] libata: Add H2D FIS "auxiliary" port flag
Date: Sat, 24 Aug 2013 23:22:49 -0700
Message-ID: <1377411771-3733-3-git-send-email-marc.ceeeee@gmail.com>
References: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:44216 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab3HYGXS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Aug 2013 02:23:18 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so2172252obp.36
        for <linux-ide@vger.kernel.org>; Sat, 24 Aug 2013 23:23:18 -0700 (PDT)
In-Reply-To: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

Add a new port flag, ATA_FLAG_FPDMA_AUX, used to indicate
support for transmission of the H2D FIS 'auxiliary' field.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/ahci.c     | 8 ++++++++
 include/linux/libata.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5064f3e..8d41c57 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1288,6 +1288,14 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 */
 		if (!(hpriv->flags & AHCI_HFLAG_NO_FPDMA_AA))
 			pi.flags |= ATA_FLAG_FPDMA_AA;
+
+		/*
+		 * All AHCI controllers should be forward-compatible
+		 * with the new auxiliary field. This code should be
+		 * conditionalized if any buggy AHCI controllers are
+		 * encountered.
+		 */
+		pi.flags |= ATA_FLAG_FPDMA_AUX;
 	}
 
 	if (hpriv->cap & HOST_CAP_PMP)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 47122f4..6539c50 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -223,6 +223,7 @@ enum {
 	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */
 	ATA_FLAG_AN		= (1 << 18), /* controller supports AN */
 	ATA_FLAG_PMP		= (1 << 19), /* controller supports PMP */
+	ATA_FLAG_FPDMA_AUX	= (1 << 20), /* controller supports H2DFIS aux field */
 	ATA_FLAG_EM		= (1 << 21), /* driver supports enclosure
 					      * management */
 	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
-- 
1.8.1.2

