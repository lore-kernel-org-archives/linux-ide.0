From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] ata_generic: Skip is_intel_ider() check when ata_generic=1 is set
Date: Fri, 11 May 2012 09:33:23 -0700
Message-ID: <1336754003-31487-1-git-send-email-andi@firstfloor.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:13422 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511Ab2EKQda (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2012 12:33:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, alan@linux.intel.com

From: Andi Kleen <ak@linux.intel.com>

When ata_generic_ide=1 is set don't do the is_intel_ider() magic
check. We found at least one box who needed that.

Cc: alan@linux.intel.com
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/ata/ata_generic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 7df56ec..aae1156 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -177,7 +177,7 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 	if ((id->driver_data & ATA_GEN_CLASS_MATCH) && all_generic_ide == 0)
 		return -ENODEV;
 
-	if (id->driver_data & ATA_GEN_INTEL_IDER)
+	if ((id->driver_data & ATA_GEN_INTEL_IDER) && !all_generic_ide)
 		if (!is_intel_ider(dev))
 			return -ENODEV;
 
-- 
1.7.7.6

