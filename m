From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] pata_it821x: fix section mismatch warning
Date: Mon, 25 Jun 2007 10:42:22 -0700
Message-ID: <20070625104222.6bc805e9.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:21071 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbXFYRmH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 13:42:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: alan@redhat.com, jgarzik <jgarzik@pobox.com>, bzolnier@gmail.com

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix section mismatch when CONFIG_HOTPLUG=n (but functions are used
for resume):

WARNING: drivers/ata/pata_it821x.o(.text+0x3f): Section mismatch: reference to .init.text: (between 'it821x_reinit_one' and 'it821x_program_udma')
WARNING: drivers/ata/pata_it821x.o(.text+0x691): Section mismatch: reference to .init.text: (between 'it821x_init_one' and 'it821x_passthru_set_dmamode')

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/pata_it821x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.22-rc6.orig/drivers/ata/pata_it821x.c
+++ linux-2.6.22-rc6/drivers/ata/pata_it821x.c
@@ -690,7 +690,7 @@ static struct ata_port_operations it821x
 	.port_start	= it821x_port_start,
 };
 
-static void __devinit it821x_disable_raid(struct pci_dev *pdev)
+static void it821x_disable_raid(struct pci_dev *pdev)
 {
 	/* Reset local CPU, and set BIOS not ready */
 	pci_write_config_byte(pdev, 0x5E, 0x01);
