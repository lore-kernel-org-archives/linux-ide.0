From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.23-rc4] sata_promise: FastTrack TX4200 is a second-generation chip
Date: Wed, 29 Aug 2007 10:25:37 +0200 (MEST)
Message-ID: <200708290825.l7T8PbYL016964@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:49754 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbXH2I0b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Aug 2007 04:26:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, sziemba@ecn.purdue.edu

This patch corrects sata_promise to classify FastTrack TX4200
(DID 3515/3519) as a second-generation chip. Promise's partial-
source FT TX4200 driver confirms this classification.

Treating it as a first-generation chip causes several problems:
1. Detection failures. This is a recent regression triggered by
   the hotplug-enabling changes in 2.6.23-rc1.
2. Various "failed to resume link for reset" warnings.

This patch fixes <http://bugzilla.kernel.org/show_bug.cgi?id=8936>.

Thanks to Stephen Ziemba for reporting the bug and for testing the fix.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
Tested-by: Stephen Ziemba <sziemba@ecn.purdue.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
This patch is identical to the one Stephen tested, I've
just updated the description.

 drivers/ata/sata_promise.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -rupN linux-2.6.23-rc4/drivers/ata/sata_promise.c linux-2.6.23-rc4.sata_promise-ft_tx4200-is-gen2/drivers/ata/sata_promise.c
--- linux-2.6.23-rc4/drivers/ata/sata_promise.c	2007-08-28 18:15:26.000000000 +0200
+++ linux-2.6.23-rc4.sata_promise-ft_tx4200-is-gen2/drivers/ata/sata_promise.c	2007-08-28 20:13:42.000000000 +0200
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.09"
+#define DRV_VERSION	"2.10"
 
 enum {
 	PDC_MAX_PORTS		= 4,
@@ -328,8 +328,8 @@ static const struct pci_device_id pdc_at
 
 	{ PCI_VDEVICE(PROMISE, 0x3318), board_20319 },
 	{ PCI_VDEVICE(PROMISE, 0x3319), board_20319 },
-	{ PCI_VDEVICE(PROMISE, 0x3515), board_20319 },
-	{ PCI_VDEVICE(PROMISE, 0x3519), board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3515), board_40518 },
+	{ PCI_VDEVICE(PROMISE, 0x3519), board_40518 },
 	{ PCI_VDEVICE(PROMISE, 0x3d17), board_40518 },
 	{ PCI_VDEVICE(PROMISE, 0x3d18), board_40518 },
 
