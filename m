From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: port and host should be stopped before
 hardware resources are released
Date: Thu, 08 Nov 2007 13:09:00 +0900
Message-ID: <47328BDC.3090105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:35715 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXKHEJI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 23:09:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so35507rvb
        for <linux-ide@vger.kernel.org>; Wed, 07 Nov 2007 20:09:07 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Port / host stop calls used to be made from ata_host_release() which
is called after all hardware resources acquired after host allocation
are released.  This is wrong as port and host stop routines often
access the hardware.

Add separate devres for port / host stop which is invoked right after
IRQ is released but with all other hardware resources intact.  The
devres is added iff ->host_stop and/or ->port_stop exist.

This problem has been spotted by Mark Lord.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>
---
Jeff, this really needs to get into 2.6.24.  Although it hasn't caused
any real problem (yet), ahci is one of the affected drivers and it's
poking released iomems in its port_ops.

 drivers/ata/libata-core.c |   52 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ec3ce12..07c3444 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6821,19 +6821,6 @@ static void ata_host_release(struct device *gendev, void *res)
 		if (!ap)
 			continue;
 
-		if ((host->flags & ATA_HOST_STARTED) && ap->ops->port_stop)
-			ap->ops->port_stop(ap);
-	}
-
-	if ((host->flags & ATA_HOST_STARTED) && host->ops->host_stop)
-		host->ops->host_stop(host);
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		if (!ap)
-			continue;
-
 		if (ap->scsi_host)
 			scsi_host_put(ap->scsi_host);
 
@@ -6960,6 +6947,24 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 	return host;
 }
 
+static void ata_host_stop(struct device *gendev, void *res)
+{
+	struct ata_host *host = dev_get_drvdata(gendev);
+	int i;
+
+	WARN_ON(!(host->flags & ATA_HOST_STARTED));
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->ops->port_stop)
+			ap->ops->port_stop(ap);
+	}
+
+	if (host->ops->host_stop)
+		host->ops->host_stop(host);
+}
+
 /**
  *	ata_host_start - start and freeze ports of an ATA host
  *	@host: ATA host to start ports for
@@ -6978,6 +6983,8 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
  */
 int ata_host_start(struct ata_host *host)
 {
+	int have_stop = 0;
+	void *start_dr = NULL;
 	int i, rc;
 
 	if (host->flags & ATA_HOST_STARTED)
@@ -6989,6 +6996,22 @@ int ata_host_start(struct ata_host *host)
 		if (!host->ops && !ata_port_is_dummy(ap))
 			host->ops = ap->ops;
 
+		if (ap->ops->port_stop)
+			have_stop = 1;
+	}
+
+	if (host->ops->host_stop)
+		have_stop = 1;
+
+	if (have_stop) {
+		start_dr = devres_alloc(ata_host_stop, 0, GFP_KERNEL);
+		if (!start_dr)
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
 		if (ap->ops->port_start) {
 			rc = ap->ops->port_start(ap);
 			if (rc) {
@@ -7001,6 +7024,8 @@ int ata_host_start(struct ata_host *host)
 		ata_eh_freeze_port(ap);
 	}
 
+	if (start_dr)
+		devres_add(host->dev, start_dr);
 	host->flags |= ATA_HOST_STARTED;
 	return 0;
 
@@ -7011,6 +7036,7 @@ int ata_host_start(struct ata_host *host)
 		if (ap->ops->port_stop)
 			ap->ops->port_stop(ap);
 	}
+	devres_free(start_dr);
 	return rc;
 }
 
