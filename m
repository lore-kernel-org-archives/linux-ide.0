From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v10 10/10] libata: do not suspend port if normal ODD is attached
Date: Wed, 21 Nov 2012 19:50:39 +0800
Message-ID: <1353498639-27631-11-git-send-email-aaron.lu@intel.com>
References: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33823 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541Ab2KULus (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Nov 2012 06:50:48 -0500
In-Reply-To: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lwe@gmail.com>, linux-ide@vger.kernel.org, linux-linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

For ODDs, the upper layer will poll for media change every a few
seconds, which will make it enter and leave suspend state very
oftern. And as each suspend will also cause a hard/soft reset,
the gain of runtime suspend is very little while the ODD may
mis-function after constantly being reset. So the idle callback
here will not proceed to suspend if a non-ZPODD capable ODD is
attached to the port.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 97987e7..9cdfb04 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5406,8 +5406,27 @@ static int ata_port_resume(struct device *dev)
 	return rc;
 }
 
+/*
+ * For ODDs, the upper layer will poll for media change every a few seconds,
+ * which will make it enter and leave suspend state every a few seconds. And
+ * as each suspend will cause a hard/soft reset, the gain of runtime suspend
+ * is very little and the ODD may mis-function after constantly being reset.
+ * So the idle callback here will not proceed to suspend if a non-ZPODD capable
+ * ODD is attached to the port.
+ */
 static int ata_port_runtime_idle(struct device *dev)
 {
+	struct ata_port *ap = to_ata_port(dev);
+	struct ata_link *link;
+	struct ata_device *adev;
+
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(adev, link, ENABLED)
+			if (adev->class == ATA_DEV_ATAPI &&
+			    !zpodd_dev_enabled(adev))
+				return -EBUSY;
+	}
+
 	return pm_runtime_suspend(dev);
 }
 
-- 
1.7.12.4

