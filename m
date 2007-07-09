From: akpm@linux-foundation.org
Subject: [patch 01/11] libata: CONFIG_PM=n compile fix
Date: Mon, 09 Jul 2007 11:46:12 -0700
Message-ID: <200707091846.l69IkCOH001364@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57336 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754102AbXGISqu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 14:46:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, olof@lixom.net

From: olof@lixom.net (Olof Johansson)

CONFIG_PM=n compile fix.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ahci.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -puN drivers/ata/ahci.c~libata-config_pm=n-compile-fix drivers/ata/ahci.c
--- a/drivers/ata/ahci.c~libata-config_pm=n-compile-fix
+++ a/drivers/ata/ahci.c
@@ -1519,6 +1519,14 @@ static void ahci_post_internal_cmd(struc
 	}
 }
 
+static int ahci_port_resume(struct ata_port *ap)
+{
+	ahci_power_up(ap);
+	ahci_start_port(ap);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
@@ -1536,14 +1544,6 @@ static int ahci_port_suspend(struct ata_
 	return rc;
 }
 
-static int ahci_port_resume(struct ata_port *ap)
-{
-	ahci_power_up(ap);
-	ahci_start_port(ap);
-
-	return 0;
-}
-
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
_
