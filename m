From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ata: hpt366: fix constant cast warning
Date: Tue, 19 May 2015 16:34:05 +0200
Message-ID: <2549322.XbiTlcDvMS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56903 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899AbbESOen (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2015 10:34:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

gcc-5.x warns about a preexisting problem in the hpt36x pata driver:

drivers/ata/pata_hpt366.c: In function 'hpt36x_init_one':
drivers/ata/pata_hpt366.c:376:9: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-array-qualifiers]

Other ata drivers have the same problem, as ata_pci_bmdma_init_one
takes a non-const pointer, and they solve it by using a cast to
turn that pointer into a normal non-const pointer.

I also tried to change the ata core code to make host->private_data
a const pointer, but that quickly got out of hand, as some other
drivers expect it to be writable, so I ended up using the same
hack as the others here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index cbc3de793d1d..0038dc4c06c7 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -352,7 +352,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 	const struct ata_port_info *ppi[] = { &info_hpt366, NULL };
 
-	void *hpriv = NULL;
+	const void *hpriv = NULL;
 	u32 reg1;
 	int rc;
 
@@ -383,7 +383,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		break;
 	}
 	/* Now kick off ATA set up */
-	return ata_pci_bmdma_init_one(dev, ppi, &hpt36x_sht, hpriv, 0);
+	return ata_pci_bmdma_init_one(dev, ppi, &hpt36x_sht, (void *)hpriv, 0);
 }
 
 #ifdef CONFIG_PM_SLEEP

