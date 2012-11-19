From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 066/493] ide: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:20:15 -0500
Message-ID: <1353349642-3677-66-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41683 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab2KSSiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2012 13:38:19 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: linux-ide@vger.kernel.org 
---
 drivers/ide/aec62xx.c      | 2 +-
 drivers/ide/cy82c693.c     | 2 +-
 drivers/ide/hpt366.c       | 2 +-
 drivers/ide/icside.c       | 2 +-
 drivers/ide/ide_platform.c | 2 +-
 drivers/ide/it821x.c       | 2 +-
 drivers/ide/pdc202xx_new.c | 2 +-
 drivers/ide/rapide.c       | 2 +-
 drivers/ide/scc_pata.c     | 2 +-
 drivers/ide/siimage.c      | 2 +-
 drivers/ide/sis5513.c      | 2 +-
 drivers/ide/tc86c001.c     | 2 +-
 drivers/ide/via82cxxx.c    | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/aec62xx.c b/drivers/ide/aec62xx.c
index 0145194..2b94583 100644
--- a/drivers/ide/aec62xx.c
+++ b/drivers/ide/aec62xx.c
@@ -307,7 +307,7 @@ static struct pci_driver aec62xx_pci_driver = {
 	.name		= "AEC62xx_IDE",
 	.id_table	= aec62xx_pci_tbl,
 	.probe		= aec62xx_init_one,
-	.remove		= __devexit_p(aec62xx_remove),
+	.remove		= aec62xx_remove,
 	.suspend	= ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
diff --git a/drivers/ide/cy82c693.c b/drivers/ide/cy82c693.c
index 3ffb49d..48326ad 100644
--- a/drivers/ide/cy82c693.c
+++ b/drivers/ide/cy82c693.c
@@ -209,7 +209,7 @@ static struct pci_driver cy82c693_pci_driver = {
 	.name		= "Cypress_IDE",
 	.id_table	= cy82c693_pci_tbl,
 	.probe		= cy82c693_init_one,
-	.remove		= __devexit_p(cy82c693_remove),
+	.remove		= cy82c693_remove,
 	.suspend	= ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 4aec3b8..db6553a 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -1525,7 +1525,7 @@ static struct pci_driver hpt366_pci_driver = {
 	.name		= "HPT366_IDE",
 	.id_table	= hpt366_pci_tbl,
 	.probe		= hpt366_init_one,
-	.remove		= __devexit_p(hpt366_remove),
+	.remove		= hpt366_remove,
 	.suspend	= ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index e640d0a..7a31f49 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -666,7 +666,7 @@ static const struct ecard_id icside_ids[] = {
 
 static struct ecard_driver icside_driver = {
 	.probe		= icside_probe,
-	.remove		= __devexit_p(icside_remove),
+	.remove		= icside_remove,
 	.shutdown	= icside_shutdown,
 	.id_table	= icside_ids,
 	.drv = {
diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index 962693b..073d9b9 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -130,7 +130,7 @@ static struct platform_driver platform_ide_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = plat_ide_probe,
-	.remove = __devexit_p(plat_ide_remove),
+	.remove = plat_ide_remove,
 };
 
 static int __init platform_ide_init(void)
diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index c5611db..6b1c72e 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -689,7 +689,7 @@ static struct pci_driver it821x_pci_driver = {
 	.name		= "ITE821x IDE",
 	.id_table	= it821x_pci_tbl,
 	.probe		= it821x_init_one,
-	.remove		= __devexit_p(it821x_remove),
+	.remove		= it821x_remove,
 	.suspend	= ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index 2e5ceb6..98110f8 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -539,7 +539,7 @@ static struct pci_driver pdc202new_pci_driver = {
 	.name		= "Promise_IDE",
 	.id_table	= pdc202new_pci_tbl,
 	.probe		= pdc202new_init_one,
-	.remove		= __devexit_p(pdc202new_remove),
+	.remove		= pdc202new_remove,
 	.suspend	= ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
diff --git a/drivers/ide/rapide.c b/drivers/ide/rapide.c
index 48d976a..200406d 100644
--- a/drivers/ide/rapide.c
+++ b/drivers/ide/rapide.c
@@ -82,7 +82,7 @@ static struct ecard_id rapide_ids[] = {
 
 static struct ecard_driver rapide_driver = {
 	.probe		= rapide_probe,
-	.remove		= __devexit_p(rapide_remove),
+	.remove		= rapide_remove,
 	.id_table	= rapide_ids,
 	.drv = {
 		.name	= "rapide",
diff --git a/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
index 9701038..f5c66be 100644
--- a/drivers/ide/scc_pata.c
+++ b/drivers/ide/scc_pata.c
@@ -869,7 +869,7 @@ static struct pci_driver scc_pci_driver = {
 	.name = "SCC IDE",
 	.id_table = scc_pci_tbl,
 	.probe = scc_init_one,
-	.remove = __devexit_p(scc_remove),
+	.remove = scc_remove,
 };
 
 static int __init scc_ide_init(void)
diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index 46f7e30..d8d9c0b 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -822,7 +822,7 @@ static struct pci_driver siimage_pci_driver = {
 	.name		= "SiI_IDE",
 	.id_table	= siimage_pci_tbl,
 	.probe		= siimage_init_one,
-	.remove		= __devexit_p(siimage_remove),
+	.remove		= siimage_remove,
 	.suspend	= ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
diff --git a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
index 09e61b4..2680dd7 100644
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -613,7 +613,7 @@ static struct pci_driver sis5513_pci_driver = {
 	.name		= "SIS_IDE",
 	.id_table	= sis5513_pci_tbl,
 	.probe		= sis5513_init_one,
-	.remove		= __devexit_p(sis5513_remove),
+	.remove		= sis5513_remove,
 	.suspend	= ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
diff --git a/drivers/ide/tc86c001.c b/drivers/ide/tc86c001.c
index 1794678..1c74504 100644
--- a/drivers/ide/tc86c001.c
+++ b/drivers/ide/tc86c001.c
@@ -249,7 +249,7 @@ static struct pci_driver tc86c001_pci_driver = {
 	.name		= "TC86C001",
 	.id_table	= tc86c001_pci_tbl,
 	.probe		= tc86c001_init_one,
-	.remove		= __devexit_p(tc86c001_remove),
+	.remove		= tc86c001_remove,
 };
 
 static int __init tc86c001_ide_init(void)
diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index eb77678..7c98e5d 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -514,7 +514,7 @@ static struct pci_driver via_pci_driver = {
 	.name 		= "VIA_IDE",
 	.id_table 	= via_pci_tbl,
 	.probe 		= via_init_one,
-	.remove		= __devexit_p(via_remove),
+	.remove		= via_remove,
 	.suspend	= ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
-- 
1.8.0

