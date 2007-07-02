From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Tue, 3 Jul 2007 01:38:47 +0900
Message-ID: <20070702163847.GV29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:39986 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbXGBQiy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 12:38:54 -0400
Received: by nz-out-0506.google.com with SMTP id s18so942913nze
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 09:38:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

host->irq and host->irq2 should be set before ata_host_register() for
IRQ reporting to work.  Move up host->irq assignment in
ata_host_activate() and add it to ata_pci_init_one() native path and
pata_cs5520.

The port info printing in ata_host_register() doesn't fit all the
different controllers.  It should probably be moved out to LLDs with
some helpers in the future.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    6 +++---
 drivers/ata/libata-sff.c  |    5 +++--
 drivers/ata/pata_cs5520.c |    5 +++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bfc59a1..e57a9f8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6424,14 +6424,14 @@ int ata_host_activate(struct ata_host *host, int irq,
 	if (rc)
 		return rc;
 
+	/* Used to print device info at probe */
+	host->irq = irq;
+
 	rc = ata_host_register(host, sht);
 	/* if failed, just free the IRQ and leave ports alone */
 	if (rc)
 		devm_free_irq(host->dev, irq, host);
 
-	/* Used to print device info at probe */
-	host->irq = irq;
-
 	return rc;
 }
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index ce84805..fa1c22c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1065,10 +1065,11 @@ int ata_pci_init_one(struct pci_dev *pdev,
 	if (rc)
 		goto err_out;
 
-	if (!legacy_mode)
+	if (!legacy_mode) {
 		rc = devm_request_irq(dev, pdev->irq, pi->port_ops->irq_handler,
 				      IRQF_SHARED, DRV_NAME, host);
-	else {
+		host->irq = pdev->irq;
+	} else {
 		irq_handler_t handler[2] = { host->ops->irq_handler,
 					     host->ops->irq_handler };
 		unsigned int irq_flags[2] = { IRQF_SHARED, IRQF_SHARED };
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 1aabe15..00cf013 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -284,6 +284,11 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 				      ata_interrupt, 0, DRV_NAME, host);
 		if (rc)
 			return rc;
+
+		if (i == 0)
+			host->irq = irq[0];
+		else
+			host->irq2 = irq[1];
 	}
 
 	return ata_host_register(host, &cs5520_sht);
