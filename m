From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v4 1/3] libata: Populate host-to-device FIS "auxiliary" field
Date: Fri, 23 Aug 2013 02:40:45 -0700
Message-ID: <1377250847-24132-2-git-send-email-marc.ceeeee@gmail.com>
References: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:58734 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab3HWJmR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Aug 2013 05:42:17 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so447750obc.38
        for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2013 02:42:17 -0700 (PDT)
In-Reply-To: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

SATA 3.1 added an "auxiliary" field to the host-to-device FIS.
Populate the host-to-device FIS with the new field via the
taskfile struct.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/ahci.c        |  8 ++++++++
 drivers/ata/libata-core.c | 10 ++++++----
 include/linux/libata.h    |  5 +++++
 3 files changed, 19 insertions(+), 4 deletions(-)

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
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c24354d..9062aa0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -546,6 +546,8 @@ int atapi_cmd_type(u8 opcode)
  */
 void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 {
+	const __le32 aux = cpu_to_le32(tf->auxiliary);
+
 	fis[0] = 0x27;			/* Register - Host to Device FIS */
 	fis[1] = pmp & 0xf;		/* Port multiplier number*/
 	if (is_cmd)
@@ -569,10 +571,10 @@ void ata_tf_to_fis(const struct ata_taskfile *tf, u8 pmp, int is_cmd, u8 *fis)
 	fis[14] = 0;
 	fis[15] = tf->ctl;
 
-	fis[16] = 0;
-	fis[17] = 0;
-	fis[18] = 0;
-	fis[19] = 0;
+	fis[16] = aux & 0xff;
+	fis[17] = (aux >> 8) & 0xff;
+	fis[18] = (aux >> 16) & 0xff;
+	fis[19] = (aux >> 24) & 0xff;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 283d66b..6539c50 100644
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
@@ -555,6 +556,10 @@ struct ata_taskfile {
 	u8			device;
 
 	u8			command;	/* IO operation */
+
+	u32			auxiliary;	/* auxiliary field */
+						/* from SATA 3.1 and */
+						/* ATA-8 ACS-3 */
 };
 
 #ifdef CONFIG_ATA_SFF
-- 
1.8.1.2

