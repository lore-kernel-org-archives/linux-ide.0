From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_cmd640: don't read CFR pointlessly
Date: Sat, 8 May 2010 22:27:18 +0400
Message-ID: <201005082227.19096.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48114 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751213Ab0EHS2G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 May 2010 14:28:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

cmd640_hardware_init() reads CFR but doesn't use the value read...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_cmd640.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6/drivers/ata/pata_cmd640.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_cmd640.c
+++ linux-2.6/drivers/ata/pata_cmd640.c
@@ -181,13 +181,10 @@ static struct ata_port_operations cmd640
 
 static void cmd640_hardware_init(struct pci_dev *pdev)
 {
-	u8 r;
 	u8 ctrl;
 
 	/* CMD640 detected, commiserations */
 	pci_write_config_byte(pdev, 0x5B, 0x00);
-	/* Get version info */
-	pci_read_config_byte(pdev, CFR, &r);
 	/* PIO0 command cycles */
 	pci_write_config_byte(pdev, CMDTIM, 0);
 	/* 512 byte bursts (sector) */
