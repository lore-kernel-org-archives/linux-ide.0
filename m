From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] small ide-scan-pci.c cleanup
Date: Tue, 29 Jan 2008 00:09:50 +0200
Message-ID: <20080128220950.GJ8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:52175 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757202AbYA1WJY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 17:09:24 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

- ide_scan_pcibus() can become static
- instead of ide_scan_pci() we can use ide_scan_pcibus() directly
  in module_init()

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/ide/ide-scan-pci.c |    9 ++-------
 include/linux/ide.h        |    1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

03f221931265eda3ae7dfad9eaa8191e171d2c0c 
diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
index 7ffa332..93d2e41 100644
--- a/drivers/ide/ide-scan-pci.c
+++ b/drivers/ide/ide-scan-pci.c
@@ -81,7 +81,7 @@ static int __init ide_scan_pcidev(struct pci_dev *dev)
  *	module ordering not traditionally ordered.
  */
 
-int __init ide_scan_pcibus(void)
+static int __init ide_scan_pcibus(void)
 {
 	struct pci_dev *dev = NULL;
 	struct pci_driver *d;
@@ -113,9 +113,4 @@ int __init ide_scan_pcibus(void)
 	return 0;
 }
 
-static int __init ide_scan_pci(void)
-{
-	return ide_scan_pcibus();
-}
-
-module_init(ide_scan_pci);
+module_init(ide_scan_pcibus);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 5d3d88e..7072c53 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1015,7 +1015,6 @@ void ide_init_disk(struct gendisk *, ide_drive_t *);
 
 #ifdef CONFIG_IDEPCI_PCIBUS_ORDER
 extern int ide_scan_direction;
-int __init ide_scan_pcibus(void);
 extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *owner, const char *mod_name);
 #define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_MODULE, KBUILD_MODNAME)
 #else

