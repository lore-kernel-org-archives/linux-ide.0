From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH]ata:ahci.c Fix warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'
Date: Sat,  3 Jul 2010 07:29:25 -0700
Message-ID: <1278167365-16011-1-git-send-email-justinmattock@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49846 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab0GCO30 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jul 2010 10:29:26 -0400
Received: by pvc7 with SMTP id 7so1637662pvc.19
        for <linux-ide@vger.kernel.org>; Sat, 03 Jul 2010 07:29:24 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org, jgarzik@pobox.com, "Justin P. Mattock" <justinmattock@gmail.com>

The below patch casts ATA_MAX_QUEUE to int because GCC will 
give a warning message about the two different enum blocks:
  CC      drivers/ata/ahci.o
drivers/ata/ahci.c: In function 'ahci_init_one':
drivers/ata/ahci.c:1045:2: warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'
 
Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/ata/ahci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f252253..fe75d8b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1042,7 +1042,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	VPRINTK("ENTER\n");
 
-	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
+	WARN_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
-- 
1.7.1.rc1.21.gf3bd6

