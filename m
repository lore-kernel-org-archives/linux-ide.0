From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] ahci: use "unsigned long flags;"
Date: Wed, 16 Jul 2008 08:43:47 +0400
Message-ID: <20080716044347.GA26573@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:40541 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYGPEq2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2008 00:46:28 -0400
Received: by ug-out-1314.google.com with SMTP id h2so462649ugf.16
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2008 21:46:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com, kristen.c.accardi@intel.com
Cc: linux-ide@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ata/ahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1273,7 +1273,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
 	u32 em_ctl;
 	u32 message[] = {0, 0};
-	unsigned int flags;
+	unsigned long flags;
 	int pmp;
 	struct ahci_em_priv *emp;
 

