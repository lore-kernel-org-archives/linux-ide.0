From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/22] libata: move ->set_mode() handling into ata_set_mode()
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <1147348791627-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:8123 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751588AbWEKMAC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:02 -0400
Received: by py-out-1112.google.com with SMTP id f28so211154pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:01 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move ->set_mode() handlng into ata_set_mode().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

9e0876cd42527ef2356a676edafc9d7f422e9a48
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1806c7c..ec40c79 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1426,20 +1426,7 @@ static int ata_bus_probe(struct ata_port
 	}
 
 	/* configure transfer mode */
-	if (ap->ops->set_mode) {
-		/* FIXME: make ->set_mode handle no device case and
-		 * return error code and failing device on failure as
-		 * ata_set_mode() does.
-		 */
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			if (ata_dev_enabled(&ap->device[i])) {
-				ap->ops->set_mode(ap);
-				break;
-			}
-		rc = 0;
-	} else
-		rc = ata_set_mode(ap, &dev);
-
+	rc = ata_set_mode(ap, &dev);
 	if (rc) {
 		down_xfermask = 1;
 		goto fail;
@@ -1997,6 +1984,20 @@ int ata_set_mode(struct ata_port *ap, st
 	struct ata_device *dev;
 	int i, rc = 0, used_dma = 0, found = 0;
 
+	/* has private set_mode? */
+	if (ap->ops->set_mode) {
+		/* FIXME: make ->set_mode handle no device case and
+		 * return error code and failing device on failure.
+		 */
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			if (ata_dev_enabled(&ap->device[i])) {
+				ap->ops->set_mode(ap);
+				break;
+			}
+		}
+		return 0;
+	}
+
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		unsigned int pio_mask, dma_mask;
-- 
1.2.4


