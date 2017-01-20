From: Darren Stevens <darren@stevens-zone.net>
Subject: [PATCH] libata:pata_atiixp: Don't use unconnected secondary port
 on SB600/SB700
Date: Fri, 20 Jan 2017 18:03:32 +0000 (GMT)
Message-ID: <497611d4655.7b408682@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:49797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbdATSES (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 13:04:18 -0500
Received: from mintppc.lan ([86.156.215.177]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.179]) with ESMTPA (Nemesis) id 0Lzrl5-1cQ3A40w8R-0155vM
 for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2017 19:04:15 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The SB600 and SB700 southbridge chips from ATI/AMD only have
connections for the primary IDE port. As these chips have unique
pci device ID's use these to mark the secondary port as 'dummy'

Signed-off-by: Darren Stevens <darren@stevens-zone.net>
---

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 49d705c..588c473 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -278,6 +278,11 @@ static int atiixp_init_one(struct pci_dev *pdev, const
struct pci_device_id *id)
    };
    const struct ata_port_info *ppi[] = { &info, &info };
 
+   if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE) ||
+       (pdev->device == PCI_DEVICE_ID_ATI_IXP700_IDE))
+       /* SB600/700 don't have secondary port wired */
+       ppi[1] = &ata_dummy_port_info;
+
    return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
                      ATA_HOST_PARALLEL_SCAN);
 }

