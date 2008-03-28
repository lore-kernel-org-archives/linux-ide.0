From: akpm@linux-foundation.org
Subject: [patch 1/2] pata_atiixp: simplex clear
Date: Fri, 28 Mar 2008 14:33:55 -0700
Message-ID: <200803282133.m2SLXupx011467@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46150 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755436AbYC1Ve1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 17:34:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Some of the other quirks changes seem to have left some users with the simplex
bits mis-set by the time the driver loads.  Clear simplex mode before we probe
the controller therefore.

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_atiixp.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff -puN drivers/ata/pata_atiixp.c~pata_atiixp-simplex-clear drivers/ata/pata_atiixp.c
--- a/drivers/ata/pata_atiixp.c~pata_atiixp-simplex-clear
+++ a/drivers/ata/pata_atiixp.c
@@ -22,7 +22,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_atiixp"
-#define DRV_VERSION "0.4.6"
+#define DRV_VERSION "0.4.7"
 
 enum {
 	ATIIXP_IDE_PIO_TIMING	= 0x40,
@@ -243,6 +243,9 @@ static int atiixp_init_one(struct pci_de
 		.port_ops = &atiixp_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
+	/* Some of the quirk reconfiguration messes up the simplex
+	   flag, so clear it again */
+	ata_pci_clear_simplex(dev);
 	return ata_pci_init_one(dev, ppi, &atiixp_sht, NULL);
 }
 
@@ -279,7 +282,7 @@ static void __exit atiixp_exit(void)
 }
 
 MODULE_AUTHOR("Alan Cox");
-MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400");
+MODULE_DESCRIPTION("low-level driver for ATI IXP series");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, atiixp);
 MODULE_VERSION(DRV_VERSION);
_
