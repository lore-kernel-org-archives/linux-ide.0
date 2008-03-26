From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_atiixp: Simplex clear
Date: Wed, 26 Mar 2008 11:35:03 +0000
Message-ID: <20080326113503.7c0218ce@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34734 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755246AbYCZLvs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2008 07:51:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Some of the other quirks changes seem to have left some users with the
simplex bits mis-set by the time the driver loads. Clear simplex mode
before we probe the controller therefore

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc5-mm1/drivers/ata/pata_atiixp.c linux-2.6.25-rc5-mm1/drivers/ata/pata_atiixp.c
--- linux.vanilla-2.6.25-rc5-mm1/drivers/ata/pata_atiixp.c	2008-03-18 15:52:08.000000000 +0000
+++ linux-2.6.25-rc5-mm1/drivers/ata/pata_atiixp.c	2008-03-26 09:41:09.000000000 +0000
@@ -22,7 +22,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_atiixp"
-#define DRV_VERSION "0.4.6"
+#define DRV_VERSION "0.4.7"
 
 enum {
 	ATIIXP_IDE_PIO_TIMING	= 0x40,
@@ -282,6 +282,9 @@
 		.port_ops = &atiixp_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
+	/* Some of the quirk reconfiguration messes up the simplex
+	   flag, so clear it again */
+	ata_pci_clear_simplex(dev);
 	return ata_pci_init_one(dev, ppi);
 }
 
@@ -318,7 +321,7 @@
 }
 
 MODULE_AUTHOR("Alan Cox");
-MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400");
+MODULE_DESCRIPTION("low-level driver for ATI IXP series");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, atiixp);
 MODULE_VERSION(DRV_VERSION);
