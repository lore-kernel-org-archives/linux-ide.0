From: Darren Stevens <darren@stevens-zone.net>
Subject: [PATCH] pata_atiixp: Fix IDE detection on SB7xx
Date: Tue, 28 Mar 2017 16:57:16 +0100 (BST)
Message-ID: <49ce56dc322.70129c23@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:61738 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755292AbdC1Q6O (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Mar 2017 12:58:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: tourula@gmail.com, linux-ide@vger.kernel.org

Commit: 5946fdaee4ba(pata_atiixp: Don't use unconnected secondary port on
SB600/SB700) disabled the check for secondary ports on AMD SB700/710/750

While these chips have only 1 IDE port, it can be reconfigured on SB7xx
to appear as a secondary channel, especially when 'Legacy IDE emulation'
is enabled, breaking IDE detection on some boards with this chipset.

Fix by removing the check for SB7xx.

Fixes: 5946fdaee4ba(pata_atiixp: Don't use unconnected secondary port
on SB600/SB700)
Signed-off-by: Darren Stevens <Darren@stevens-zone.net>
---
 drivers/ata/pata_atiixp.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 6c9aa95..843bb20 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -278,9 +278,8 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
    };
    const struct ata_port_info *ppi[] = { &info, &info };
 
-   /* SB600/700 don't have secondary port wired */
-   if ((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE) ||
-       (pdev->device == PCI_DEVICE_ID_ATI_IXP700_IDE))
+   /* SB600 doesn't have secondary port wired */
+   if (pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE)
        ppi[1] = &ata_dummy_port_info;
 
    return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
-- 
1.7.10.4


