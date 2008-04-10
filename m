From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_svw: 0x0241 has 8 ports not 4
Date: Thu, 10 Apr 2008 09:55:16 +0900
Message-ID: <47FD6574.8020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:33646 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbYDJAzY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Apr 2008 20:55:24 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2453989wra.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Apr 2008 17:55:23 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, y_honda_@d1.dion.ne.jp, Benjamin Herrenschmidt <benh@kernel.crashing.org>

From: Yohei Honda <y_honda_@d1.dion.ne.jp>

0x0241 has 8 ports not 4.

Reported by Yohei Honda on kernel bz 10424.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Benjamin, can you please verify this is correct?

 drivers/ata/sata_svw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 840d1c4..75c6853 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -531,7 +531,7 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
  * */
 static const struct pci_device_id k2_sata_pci_tbl[] = {
 	{ PCI_VDEVICE(SERVERWORKS, 0x0240), chip_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw8 },
 	{ PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw8 },
 	{ PCI_VDEVICE(SERVERWORKS, 0x024a), chip_svw4 },
 	{ PCI_VDEVICE(SERVERWORKS, 0x024b), chip_svw4 },
