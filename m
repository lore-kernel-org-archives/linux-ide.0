From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pata_sil680: compile fix
Date: Sat, 19 May 2007 12:29:39 +0200
Message-ID: <464ED193.2020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:2036 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbXESK3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2007 06:29:52 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1617990nza
        for <linux-ide@vger.kernel.org>; Sat, 19 May 2007 03:29:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Recent mmio change broke compilation if PM is turned on.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 pata_sil680.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 557a37b..89f59d1 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -431,7 +431,9 @@ use_ioports:
 #ifdef CONFIG_PM
 static int sil680_reinit_one(struct pci_dev *pdev)
 {
-	sil680_init_chip(pdev);
+	int try_mmio;
+
+	sil680_init_chip(pdev, &try_mmio);
 	return ata_pci_device_resume(pdev);
 }
 #endif
