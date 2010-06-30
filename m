From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH v2]ata:ahci.c Fix warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'
Date: Tue, 29 Jun 2010 23:37:07 -0700
Message-ID: <1277879827-18233-1-git-send-email-justinmattock@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35121 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab0F3GhM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2010 02:37:12 -0400
Received: by pxi8 with SMTP id 8so223512pxi.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2010 23:37:11 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, tj@kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>

The below patch fixes a warning message during compiling of the kernel
  CC      drivers/ata/ahci.o
drivers/ata/ahci.c: In function 'ahci_init_one':
drivers/ata/ahci.c:1045:2: warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'

 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/ata/ahci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8ca16f5..68c9add 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1038,11 +1038,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct ata_host *host;
-	int n_ports, i, rc;
+	int n_ports, i, rc, sum = AHCI_MAX_CMDS;
 
 	VPRINTK("ENTER\n");
 
-	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
+	WARN_ON(ATA_MAX_QUEUE > sum);
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
-- 
1.7.1.rc1.21.gf3bd6

