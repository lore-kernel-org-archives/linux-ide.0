From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v2 3/3] ata: runtime suspend port if no device attached
Date: Tue, 27 Dec 2011 13:42:34 +0800
Message-ID: <1324964554-9719-4-git-send-email-ming.m.lin@intel.com>
References: <1324964554-9719-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14992 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab1L0Fmz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Dec 2011 00:42:55 -0500
In-Reply-To: <1324964554-9719-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org

Add a new function ata_device_probed(...) to check if device was probed.
Runtime suspend scsi_host--->ata port if no device was probed.

Controller will be runtime suspended if all port were suspended already.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/ata/libata-core.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c04ad68..1ff921b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5906,6 +5906,21 @@ int ata_port_probe(struct ata_port *ap)
 	return rc;
 }
 
+/**
+ *	ata_device_probed - Check if device is probed
+ *	@ap:	port to check
+ */
+static bool ata_device_probed(struct ata_port *ap)
+{
+	struct ata_link *link;
+	struct ata_device *dev;
+
+	ata_for_each_link(link, ap, EDGE)
+		ata_for_each_dev(dev, link, ENABLED)
+			return true;
+
+	return false;
+}
 
 static void async_port_probe(void *data, async_cookie_t cookie)
 {
@@ -5926,7 +5941,11 @@ static void async_port_probe(void *data, async_cookie_t cookie)
 	/* in order to keep device order, we need to synchronize at this point */
 	async_synchronize_cookie(cookie);
 
-	ata_scsi_scan_host(ap, 1);
+	if (ata_device_probed(ap))
+		ata_scsi_scan_host(ap, 1);
+	else
+		/* Runtime suspend it if no device is attached */
+		pm_runtime_idle(&ap->scsi_host->shost_gendev);
 }
 
 /**
-- 
1.7.2.5

