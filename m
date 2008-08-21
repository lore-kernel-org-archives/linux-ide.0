From: Richard Kennedy <richard@rsk.demon.co.uk>
Subject: [PATCH] libata: reorder ata_device to remove 8 bytes of padding on
	64 bits
Date: Thu, 21 Aug 2008 14:47:00 +0100
Message-ID: <1219326420.1276.8.camel@castor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756706AbYHUNrd@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

reduce size by 8 bytes from 1160 to 1152 allowing it to fit in 1 fewer
cachelines.
    
Signed-off-by: Richard Kennedy <richard@rsk.demon.co.uk>

---
patch against 2.6.27-rc4 compiled & run on AMD64.

Richard


diff --git a/include/linux/libata.h b/include/linux/libata.h
index 06b8033..84a7a0d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -553,8 +553,8 @@ struct ata_ering {
 struct ata_device {
 	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
-	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		horkage;	/* List of broken features */
+	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
