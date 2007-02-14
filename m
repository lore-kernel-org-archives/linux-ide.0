From: Richard Knutsson <ricknu-0@student.ltu.se>
Subject: [PATCH] ide/pci/delkin_cb.c: pci_module_init to pci_register_driver
Date: Wed, 14 Feb 2007 01:39:42 +0100 (MET)
Message-ID: <20070214003942.4331.78713.sendpatchset@thinktank.campus.ltu.se>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932109AbXBNAjs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Knutsson <ricknu-0@student.ltu.se>
List-Id: linux-ide@vger.kernel.org

Convert pci_module_init() to pci_register_driver().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
Compile-tested with "allyes", "allmod" & "allno" on i386


diff --git a/drivers/ide/pci/delkin_cb.c b/drivers/ide/pci/delkin_cb.c
index e2672fc..d4b753e 100644
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -122,7 +122,7 @@ static struct pci_driver driver = {
 static int
 delkin_cb_init (void)
 {
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void
