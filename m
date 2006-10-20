From: akpm@osdl.org
Subject: [patch 09/12] libata-sff: Allow for wacky systems
Date: Fri, 20 Oct 2006 14:39:42 -0700
Message-ID: <200610202139.k9KLdgUI003586@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:42627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992744AbWJTVkm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:40:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

There are some Linux supported platforms that simply cannot hit the low I/O
addresses used by ATA legacy mode PCI mappings.  These platforms have a window
for PCI space that is fixed by the board logic and doesn't include the
neccessary locations.

Provide a config option so that such platforms faced with a controller that
they cannot support simply error it and punt

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/libata-sff.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN drivers/ata/libata-sff.c~libata-sff-allow-for-wacky-systems drivers/ata/libata-sff.c
--- a/drivers/ata/libata-sff.c~libata-sff-allow-for-wacky-systems
+++ a/drivers/ata/libata-sff.c
@@ -981,6 +981,15 @@ int ata_pci_init_one (struct pci_dev *pd
 		mask = (1 << 2) | (1 << 0);
 		if ((tmp8 & mask) != mask)
 			legacy_mode = (1 << 3);
+#if defined(CONFIG_NO_ATA_LEGACY)
+		/* Some platforms with PCI limits cannot address compat
+		   port space. In that case we punt if their firmware has
+		   left a device in compatibility mode */
+		if (legacy_mode) {
+			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
+			return -EOPNOTSUPP;
+		}
+#endif
 	}
 
 	rc = pci_request_regions(pdev, DRV_NAME);
_
