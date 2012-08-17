From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 1/2] ahci: un-staticize ahci_dev_classify
Date: Fri, 17 Aug 2012 09:51:50 -0500
Message-ID: <1345215111-11051-2-git-send-email-mark.langsdorf@calxeda.com>
References: <1345215111-11051-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp161.dfw.emailsrvr.com ([67.192.241.161]:58793 "EHLO
	smtp161.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756256Ab2HQPBf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 11:01:35 -0400
In-Reply-To: <1345215111-11051-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, probinson@gmail.com, jonathon@jonmasters.org, dmarlin@redhat.com, Rob Herring <rob.herring@calxeda.com>

From: Rob Herring <rob.herring@calxeda.com>

Make ahci_dev_classify available to the ahci platform driver for custom
hard reset function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/ata/ahci.h    |    1 +
 drivers/ata/libahci.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index c2594dd..57eb1c2 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -320,6 +320,7 @@ extern struct device_attribute *ahci_sdev_attrs[];
 extern struct ata_port_operations ahci_ops;
 extern struct ata_port_operations ahci_pmp_retry_srst_ops;
 
+unsigned int ahci_dev_classify(struct ata_port *ap);
 void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
 			u32 opts);
 void ahci_save_initial_config(struct device *dev,
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index f9eaa82..555c07a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1139,7 +1139,7 @@ static void ahci_dev_config(struct ata_device *dev)
 	}
 }
 
-static unsigned int ahci_dev_classify(struct ata_port *ap)
+unsigned int ahci_dev_classify(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ata_taskfile tf;
@@ -1153,6 +1153,7 @@ static unsigned int ahci_dev_classify(struct ata_port *ap)
 
 	return ata_dev_classify(&tf);
 }
+EXPORT_SYMBOL_GPL(ahci_dev_classify);
 
 void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
 			u32 opts)
-- 
1.7.9.5

