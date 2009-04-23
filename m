From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: clear ering on resume
Date: Thu, 23 Apr 2009 09:55:28 +0900
Message-ID: <49EFBC80.6070109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60013 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbZDWA4g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Apr 2009 20:56:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, vbotka@novell.com

Error timestamps are in jiffies which doesn't run while suspended and
PHY events during resume isn't too uncommon.  When the two are
combined, it can lead to unnecessary speed downs if the machine is
suspended and resumed repeatedly.  Clear error history on resume.

This was reported and verified in bnc#486803 by Vladimir Botka.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Vladimir Botka <vbotka@novell.com>
---
 drivers/ata/libata-eh.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0183131..ff0f496 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3494,6 +3494,8 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
  */
 static void ata_eh_handle_port_resume(struct ata_port *ap)
 {
+	struct ata_link *link;
+	struct ata_device *dev;
 	unsigned long flags;
 	int rc = 0;
 
@@ -3508,6 +3510,17 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 
 	WARN_ON(!(ap->pflags & ATA_PFLAG_SUSPENDED));
 
+	/*
+	 * Error timestamps are in jiffies which doesn't run while
+	 * suspended and PHY events during resume isn't too uncommon.
+	 * When the two are combined, it can lead to unnecessary speed
+	 * downs if the machine is suspended and resumed repeatedly.
+	 * Clear error history.
+	 */
+	ata_for_each_link(link, ap, HOST_FIRST)
+		ata_for_each_dev(dev, link, ALL)
+			ata_ering_clear(&dev->ering);
+
 	ata_acpi_set_state(ap, PMSG_ON);
 
 	if (ap->ops->port_resume)
