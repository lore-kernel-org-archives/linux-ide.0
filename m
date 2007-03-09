From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix ata_host_release() free order
Date: Fri, 9 Mar 2007 19:36:12 +0900
Message-ID: <20070309103612.GC32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:56668 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993106AbXCIKgN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 05:36:13 -0500
Received: by wx-out-0506.google.com with SMTP id h31so813564wxd
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 02:36:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

host->ops->host_stop() might access ports.  Free ports after
host_stop.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This one fixes oops on pdc_adma unloading and needs to go to
libata-dev#upstream-fixes.

 drivers/ata/libata-core.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cd0ce65..0520950 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5668,18 +5668,22 @@ static void ata_host_release(struct device *gendev, void *res)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		if (!ap)
-			continue;
-
-		if (ap->ops->port_stop)
+		if (ap && ap->ops->port_stop)
 			ap->ops->port_stop(ap);
-
-		scsi_host_put(ap->scsi_host);
 	}
 
 	if (host->ops->host_stop)
 		host->ops->host_stop(host);
 
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap)
+			scsi_host_put(ap->scsi_host);
+
+		host->ports[i] = NULL;
+	}
+
 	dev_set_drvdata(gendev, NULL);
 }
 
-- 
1.5.0.1

