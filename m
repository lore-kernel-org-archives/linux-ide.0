From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_vsc: s/host_set/host/
Date: Thu, 9 Nov 2006 12:03:04 +0900
Message-ID: <20061109030304.GY13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:38326 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754517AbWKIDDN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Nov 2006 22:03:13 -0500
Received: by ug-out-1314.google.com with SMTP id m3so100479ugc
        for <linux-ide@vger.kernel.org>; Wed, 08 Nov 2006 19:03:11 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

sata_vsc MSI support merge brought in now renamed host_set and breaks
build.  s/host_set/host/

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 8d6a288..9778911 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -124,17 +124,17 @@ static void vsc_sata_scr_write (struct a
 }
 
 
-static void vsc_sata_host_stop(struct ata_host_set *host_set)
+static void vsc_sata_host_stop(struct ata_host *host)
 {
-	struct vsc_sata_host_priv *hpriv = host_set->private_data;
-	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+	struct vsc_sata_host_priv *hpriv = host->private_data;
+	struct pci_dev *pdev = to_pci_dev(host->dev);
 
 	if (hpriv->hp_flags & VSC_SATA_HP_FLAG_MSI)
 		pci_disable_msi(pdev);
 	else
 		pci_intx(pdev, 0);
 	kfree (hpriv);
-	ata_pci_host_stop(host_set);
+	ata_pci_host_stop(host);
 }
 
 static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
