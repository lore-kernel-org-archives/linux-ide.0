From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH] Fix a memory leak in piix_init_one
Date: Fri, 15 Dec 2006 23:14:20 +0000
Message-ID: <20061215231419.5107.46451.stgit@localhost.localdomain>
References: <b0943d9e0612141542s558d3768h57a7bb9b5440a246@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from queue03-winn.ispmail.ntl.com ([81.103.221.57]:39641 "EHLO
	queue03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932138AbWLOXaW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Dec 2006 18:30:22 -0500
In-Reply-To: <b0943d9e0612141542s558d3768h57a7bb9b5440a246@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

The piix_init_one() function in drivers/ata/ata_piix.c can return an
error without cleaning up the piix_host_priv structure
allocation. This patch adds a kfree() call on the error path.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 drivers/ata/ata_piix.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index dfe17e1..6717891 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1051,6 +1051,7 @@ static int piix_init_one (struct pci_dev
 	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
 	struct piix_host_priv *hpriv;
 	unsigned long port_flags;
+	int ret;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
@@ -1075,9 +1076,9 @@ static int piix_init_one (struct pci_dev
 		u8 tmp;
 		pci_read_config_byte(pdev, PIIX_SCC, &tmp);
 		if (tmp == PIIX_AHCI_DEVICE) {
-			int rc = piix_disable_ahci(pdev);
-			if (rc)
-				return rc;
+			ret = piix_disable_ahci(pdev);
+			if (ret)
+				goto cleanup;
 		}
 	}
 
@@ -1107,7 +1108,15 @@ static int piix_init_one (struct pci_dev
 		port_info[1].mwdma_mask = 0;
 		port_info[1].udma_mask = 0;
 	}
-	return ata_pci_init_one(pdev, ppinfo, 2);
+	ret = ata_pci_init_one(pdev, ppinfo, 2);
+	if (ret)
+		goto cleanup;
+	goto out;
+
+ cleanup:
+	kfree(hpriv);
+ out:
+	return ret;
 }
 
 static void piix_host_stop(struct ata_host *host)
