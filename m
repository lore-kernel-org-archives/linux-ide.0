From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC][PATCH 3/4] ata: runtime suspend port if no device attached
Date: Thu, 15 Dec 2011 21:12:48 +0800
Message-ID: <1323954769-3918-4-git-send-email-ming.m.lin@intel.com>
References: <1323954769-3918-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11990 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011Ab1LONOt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Dec 2011 08:14:49 -0500
In-Reply-To: <1323954769-3918-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Add a new function ata_device_probed(...) to check if device was probed.
Runtime suspend scsi_host--->ata port if no device was probed.

Controller will be runtime suspended if all port are suspended already.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/ata/libata-core.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8996758..4bbbd55 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5934,6 +5934,21 @@ int ata_port_probe(struct ata_port *ap)
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
@@ -5954,7 +5969,11 @@ static void async_port_probe(void *data, async_cookie_t cookie)
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

