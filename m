From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH]ata:ahci.c Fix warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'
Date: Tue, 29 Jun 2010 19:53:26 -0700
Message-ID: <1277866406-8253-1-git-send-email-justinmattock@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:64615 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0F3Cxb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2010 22:53:31 -0400
Received: by pxi8 with SMTP id 8so158911pxi.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2010 19:53:30 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, tj@kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>

I'm seeing this while compiling. Not sure if it's from
gcc 4.6.0 or not:
  CC      drivers/ata/ahci.o
drivers/ata/ahci.c: In function 'ahci_init_one':
drivers/ata/ahci.c:1045:2: warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'

I also noticed there's a patch out there that addresses the this issue:
http://kerneltrap.org/mailarchive/linux-kernel/2010/3/18/4549546
but theres not much after the thread to tell what happened.
In any case I'll let you guys decide on what fixes this issue
in the best way.

 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/ata/ahci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8ca16f5..5282e93 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1038,11 +1038,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct ata_host *host;
-	int n_ports, i, rc;
+	int n_ports, i, rc, sum = 32;
 
 	VPRINTK("ENTER\n");
 
-	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
+	WARN_ON(ATA_MAX_QUEUE > sum);
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
-- 
1.7.1.rc1.21.gf3bd6

