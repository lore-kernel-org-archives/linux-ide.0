From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] libata: fix smatch warning for zpodd_wake_dev
Date: Mon, 28 Jan 2013 13:08:02 +0800
Message-ID: <510607B2.3050703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33523 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785Ab3A1FHf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2013 00:07:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-ide@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Fix a smatch warning caused by an useless pointer check.
The context parameter (aka. ata_dev) will never be NULL until we remove
the acpi notification handler, so it is pointless to check it for NULL.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-zpodd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 540b0b7..7c0204a 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -239,8 +239,7 @@ static void zpodd_wake_dev(acpi_handle handle, u32 event, void *context)
 	struct zpodd *zpodd = ata_dev->zpodd;
 	struct device *dev = &ata_dev->sdev->sdev_gendev;
 
-	if (event == ACPI_NOTIFY_DEVICE_WAKE && ata_dev &&
-			pm_runtime_suspended(dev)) {
+	if (event == ACPI_NOTIFY_DEVICE_WAKE && pm_runtime_suspended(dev)) {
 		zpodd->from_notify = true;
 		pm_runtime_resume(dev);
 	}
-- 
1.8.1

