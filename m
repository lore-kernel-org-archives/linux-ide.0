From: olof@lixom.net (Olof Johansson)
Subject: [PATCH] libata: CONFIG_PM=n compile fix
Date: Sun, 3 Jun 2007 17:58:40 -0500
Message-ID: <20070603225840.GA25465@lixom.net>
References: <20070527030954.GA18974@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:53229 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbXFCWwj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jun 2007 18:52:39 -0400
Content-Disposition: inline
In-Reply-To: <20070527030954.GA18974@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

CONFIG_PM=n compile fix.

Signed-off-by: Olof Johansson <olof@lixom.net>

---

Hi,

On Sat, May 26, 2007 at 11:09:54PM -0400, Jeff Garzik wrote:

> This is checked into the 'mv-ahci-pata' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Didn't build for me without this change, since I had CONFIG_PM=n.


diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 21df81e..07d5a95 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1818,6 +1836,14 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
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
@@ -1835,14 +1861,6 @@ static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
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
