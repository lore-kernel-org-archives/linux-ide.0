From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/50] it8213: fix return value in it8213_init_one()
Date: Sun, 06 Jul 2008 19:20:11 +0200
Message-ID: <4871022d.1ade660a.3458.6263@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13310 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbYGFRek (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:40 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985611ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:38 -0700 (PDT)
Content-Disposition: inline; filename=it8213-fix-return-value-in-it8213_init_one.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it8213.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -184,8 +184,7 @@ static const struct ide_port_info it8213
 
 static int __devinit it8213_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &it8213_chipsets[id->driver_data]);
-	return 0;
+	return ide_setup_pci_device(dev, &it8213_chipsets[id->driver_data]);
 }
 
 static const struct pci_device_id it8213_pci_tbl[] = {

-- 

