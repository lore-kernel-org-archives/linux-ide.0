From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: [PATCH 2.6.21-rc2-git3] ata: fix pata_jmicron compile failure
Date: Sun, 4 Mar 2007 07:30:32 +0800
Message-ID: <200703032330.l23NUW1L009889@freya.yggdrasil.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.216.57.249] ([221.216.57.249]:23671 "EHLO
	freya.yggdrasil.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750925AbXCCX6c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Mar 2007 18:58:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@redhat.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

	linux-2.6.21-rc2-git3/drivers/ata/pata_jmicron.c has an extra
#endif.  The 2.6.21-rc2-git2 version compiled fine.  Here is a patch
that removes the offending line.

	I do not have hardware to test this change.  I can verify that
the resulting driver compiles to a binary that successfully loads and
unloads with insmod and rmmod.

---

Signed-off-by: adam@yggdrasil.com <Adam J. Richter>

--- a/drivers/ata/pata_jmicron.c	2007-03-04 05:36:08.000000000 +0800
+++ b/drivers/ata/pata_jmicron.c	2007-03-04 07:04:45.000000000 +0800
@@ -243,9 +243,8 @@ static int __init jmicron_init(void)
 static void __exit jmicron_exit(void)
 {
 	pci_unregister_driver(&jmicron_pci_driver);
 }
-#endif
 
 module_init(jmicron_init);
 module_exit(jmicron_exit);
 
