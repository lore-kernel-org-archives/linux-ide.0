From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ATA: fix a problem that ata port print_id is used
	uninitialized
Date: Thu, 30 Jul 2009 09:11:56 +0800
Message-ID: <1248916316.2670.160.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11577 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756049AbZG3BLw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Jul 2009 21:11:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Tejun Heo <htejun@gmail.com>


fix a problem that ata port print_id is used uninitialized.

port print_id is initialized in ata_host_register, but it's
used in ata_host_start.
Now move it to ata_host_start, before it's invoked for the first time.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/ata/libata-core.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-core.c
+++ linux-2.6/drivers/ata/libata-core.c
@@ -5963,6 +5963,8 @@ int ata_host_start(struct ata_host *host
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		host->ports[i]->print_id = ata_print_id++;
+
 		if (ap->ops->port_start) {
 			rc = ap->ops->port_start(ap);
 			if (rc) {
@@ -6107,10 +6109,6 @@ int ata_host_register(struct ata_host *h
 	for (i = host->n_ports; host->ports[i]; i++)
 		kfree(host->ports[i]);
 
-	/* give ports names and add SCSI hosts */
-	for (i = 0; i < host->n_ports; i++)
-		host->ports[i]->print_id = ata_print_id++;
-
 	rc = ata_scsi_add_hosts(host, sht);
 	if (rc)
 		return rc;


