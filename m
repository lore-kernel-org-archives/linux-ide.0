From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] libata: check SATA_SETTINGS log with HW Feature Ctrl
Date: Sun, 18 Nov 2012 04:44:41 +0800
Message-ID: <1353185081-11349-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:54035 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715Ab2KQMnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Nov 2012 07:43:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Shane Huang <shane.huang@amd.com>

NCQ capability was used to check availability of SATA Settings page
from Identify Device Data Log, which contains DevSlp timing variables.
It does not work on some HDDs and leads to error messages.
IDENTIFY word 78 bit 5(Hardware Feature Control) should be used.

Quoting SATA spec 3.1:
If Hardware Feature Control is supported, then:
a) IDENTIFY DEVICE data word 78 bit 5 (see 13.2.1.18) shall be
set to one;
b) the SET FEATURES Select Hardware Feature Control subcommand
shall be supported (see 13.3.8);
c) page 08h of the Identify Device Data log (see 13.7.7) shall
be supported;

This patch is not tested on SATA HDD with DevSlp supported.

Reported-by: Borislav Petkov <bp@amd64.org>
Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 drivers/ata/libata-core.c |    3 +--
 include/linux/ata.h       |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3cc7096..4c9a58b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2330,9 +2330,8 @@ int ata_dev_configure(struct ata_device *dev)
 
 		/* Obtain SATA Settings page from Identify Device Data Log,
 		 * which contains DevSlp timing variables etc.
-		 * Exclude old devices with ata_id_has_ncq()
 		 */
-		if (ata_id_has_ncq(dev->id)) {
+		if (ata_id_has_hw_feature_ctrl(dev->id)) {
 			err_mask = ata_read_log_page(dev,
 						     ATA_LOG_SATA_ID_DEV_DATA,
 						     ATA_LOG_SATA_SETTINGS,
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 408da95..18cbb93 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -593,6 +593,7 @@ static inline int ata_is_data(u8 prot)
 #define ata_id_cdb_intr(id)	(((id)[ATA_ID_CONFIG] & 0x60) == 0x20)
 #define ata_id_has_da(id)	((id)[ATA_ID_SATA_CAPABILITY_2] & (1 << 4))
 #define ata_id_has_devslp(id)	((id)[ATA_ID_FEATURE_SUPP] & (1 << 8))
+#define ata_id_has_hw_feature_ctrl(id)	((id)[ATA_ID_FEATURE_SUPP] & (1 << 5))
 
 static inline bool ata_id_has_hipm(const u16 *id)
 {
-- 
1.7.9.5


