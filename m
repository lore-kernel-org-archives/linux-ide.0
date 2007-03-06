From: akpm@linux-foundation.org
Subject: [patch 06/30] libata: handle ata_pci_device_do_resume() failure while resuming
Date: Tue, 06 Mar 2007 02:37:54 -0800
Message-ID: <200703061037.l26Abtiq019469@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34504 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934056AbXCFKin (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, dmonakhov@sw.ru, dmonakhov@openvz.org

From: Dmitriy Monakhov <dmonakhov@sw.ru>

Since commit:553c4aa630af7bc885e056d0436e4eb7f238579b
ata_pci_device_do_resume() can return error code, all callers was updated
except this one.

Signed-off-by: Monakhov Dmitriy <dmonakhov@openvz.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_inic162x.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/ata/sata_inic162x.c~libata-handle-ata_pci_device_do_resume-failure-while-resuming-v2 drivers/ata/sata_inic162x.c
--- a/drivers/ata/sata_inic162x.c~libata-handle-ata_pci_device_do_resume-failure-while-resuming-v2
+++ a/drivers/ata/sata_inic162x.c
@@ -642,7 +642,9 @@ static int inic_pci_device_resume(struct
 	void __iomem *mmio_base = host->iomap[MMIO_BAR];
 	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = init_controller(mmio_base, hpriv->cached_hctl);
_
