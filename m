From: domen@coderock.org
Subject: [patch 4/6] drivers/ide/*: convert to pci_register_driver
Date: Sun, 06 Mar 2005 11:42:13 +0100
Message-ID: <20050306104214.56FE71F203@trashy.coderock.org>
Received: from coderock.org ([193.77.147.115]:32682 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261375AbVCFKmT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2005 05:42:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, domen@coderock.org, c.lucas@ifrance.com


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/setup-pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ide/setup-pci.c~pci_register_driver-drivers_ide drivers/ide/setup-pci.c
--- kj/drivers/ide/setup-pci.c~pci_register_driver-drivers_ide	2005-03-05 16:12:20.000000000 +0100
+++ kj-domen/drivers/ide/setup-pci.c	2005-03-05 16:12:20.000000000 +0100
@@ -803,7 +803,7 @@ static LIST_HEAD(ide_pci_drivers);
 int ide_pci_register_driver(struct pci_driver *driver)
 {
 	if(!pre_init)
-		return pci_module_init(driver);
+		return pci_register_driver(driver);
 	list_add_tail(&driver->node, &ide_pci_drivers);
 	return 0;
 }
_
