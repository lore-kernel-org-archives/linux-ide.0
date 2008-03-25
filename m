From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] pdc_adma: kill adma_host_stop()
Date: Tue, 25 Mar 2008 21:36:06 +0900
Message-ID: <47E8F1B6.5080405@gmail.com>
References: <47E8F15F.50601@gmail.com> <47E8F192.7000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:63421 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbYCYMgM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 08:36:12 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1746542rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 05:36:11 -0700 (PDT)
In-Reply-To: <47E8F192.7000709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

adma_host_stop() does the same thing that adma_port_stop() does.  Kill
it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>
---
 drivers/ata/pdc_adma.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 6a4654e..c431bf3 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -131,7 +131,6 @@ struct adma_port_priv {
 static int adma_ata_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent);
 static int adma_port_start(struct ata_port *ap);
-static void adma_host_stop(struct ata_host *host);
 static void adma_port_stop(struct ata_port *ap);
 static void adma_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int adma_qc_issue(struct ata_queued_cmd *qc);
@@ -159,7 +158,6 @@ static struct ata_port_operations adma_ata_ops = {
 
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
-	.host_stop		= adma_host_stop,
 };
 
 static struct ata_port_info adma_port_info[] = {
@@ -591,14 +589,6 @@ static void adma_port_stop(struct ata_port *ap)
 	adma_reset_engine(ap);
 }
 
-static void adma_host_stop(struct ata_host *host)
-{
-	unsigned int port_no;
-
-	for (port_no = 0; port_no < ADMA_PORTS; ++port_no)
-		adma_reset_engine(host->ports[port_no]);
-}
-
 static void adma_host_init(struct ata_host *host, unsigned int chip_id)
 {
 	unsigned int port_no;
-- 
1.5.2.4

