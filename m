From: akpm@osdl.org
Subject: [patch 08/12] ahci: readability tweak
Date: Fri, 20 Oct 2006 14:39:41 -0700
Message-ID: <200610202139.k9KLdfOP003583@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:45955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422887AbWJTVkt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:40:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/ahci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/ahci.c~ahci-readability-tweak drivers/ata/ahci.c
--- a/drivers/ata/ahci.c~ahci-readability-tweak
+++ a/drivers/ata/ahci.c
@@ -1041,7 +1041,7 @@ static void ahci_host_intr(struct ata_po
 	/* hmmm... a spurious interupt */
 
 	/* some devices send D2H reg with I bit set during NCQ command phase */
-	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
+	if (ap->sactive && (status & PORT_IRQ_D2H_REG_FIS))
 		return;
 
 	/* ignore interim PIO setup fis interrupts */
_
