From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 2/3] ata: fix sparse warning in libata-core.c
Date: Thu, 14 Feb 2008 10:45:23 -0800
Message-ID: <1203014723.2748.64.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:12638 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbYBNSp0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 13:45:26 -0500
Received: by py-out-1112.google.com with SMTP id u52so519877pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 10:45:25 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>

rc is used to test the return value and possibly return an error.
No need to redeclare inside the loop.

drivers/ata/libata-core.c:7089:7: warning: symbol 'rc' shadows an earlier one
drivers/ata/libata-core.c:7030:9: originally declared here

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/libata-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 004dae4..beaa3a9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7086,7 +7086,6 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	DPRINTK("probe begin\n");
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		int rc;
 
 		/* probe */
 		if (ap->ops->error_handler) {
-- 
1.5.4.1.1278.gc75be


