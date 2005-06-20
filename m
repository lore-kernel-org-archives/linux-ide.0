From: domen@coderock.org
Subject: [patch 4/6] drivers/ide/*: convert to pci_register_driver
Date: Mon, 20 Jun 2005 23:52:20 +0200
Message-ID: <20050620215220.626981000@nd47.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:35225 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261759AbVFTV4Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2005 17:56:16 -0400
Content-Disposition: inline; filename=pci_register_driver-drivers_ide.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, Christophe Lucas <c.lucas@ifrance.com>, domen@coderock.org

From: Christophe Lucas <c.lucas@ifrance.com>


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 setup-pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/ide/setup-pci.c
===================================================================
--- quilt.orig/drivers/ide/setup-pci.c
+++ quilt/drivers/ide/setup-pci.c
@@ -803,7 +803,7 @@ static LIST_HEAD(ide_pci_drivers);
 int ide_pci_register_driver(struct pci_driver *driver)
 {
 	if(!pre_init)
-		return pci_module_init(driver);
+		return pci_register_driver(driver);
 	list_add_tail(&driver->node, &ide_pci_drivers);
 	return 0;
 }

--
