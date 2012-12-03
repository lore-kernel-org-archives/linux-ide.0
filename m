From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] libata: set dma_mode to 0xff in reset
Date: Mon, 03 Dec 2012 11:35:02 +0800
Message-ID: <50BC1DE6.7080008@intel.com>
References: <50BBFA94.2070105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8720 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916Ab2LCDeo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2012 22:34:44 -0500
In-Reply-To: <50BBFA94.2070105@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Borislav Petkov <bp@alien8.de>, Dutra Julio <dutra.julio@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Szymon Janc <szymon@janc.net.pl>, Bernd Buschinski <b.buschinski@googlemail.com>, linux-ide@vger.kernel.org


ata_device->dma_mode's initial value is zero, which is not a valid dma
mode, but ata_dma_enabled will return true for this value. This patch
sets dma_mode to 0xff in reset function, so that ata_dma_enabled will
not return true for this case, or it will cause problem for pata_acpi.

The corrsponding bugzilla page is at:
https://bugzilla.kernel.org/show_bug.cgi?id=49151

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Szymon Janc <szymon@janc.net.pl>
Tested-by: Dutra Julio <dutra.julio@gmail.com>
Cc: <stable@kernel.org>
---
 drivers/ata/libata-core.c | 1 +
 drivers/ata/libata-eh.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f46fbd3..586362e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2560,6 +2560,7 @@ int ata_bus_probe(struct ata_port *ap)
 		 * bus as we may be talking too fast.
 		 */
 		dev->pio_mode = XFER_PIO_0;
+		dev->dma_mode = 0xff;
 
 		/* If the controller has a pio mode setup function
 		 * then use it to set the chipset to rights. Don't
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e60437c..bf039b0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2657,6 +2657,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		 * bus as we may be talking too fast.
 		 */
 		dev->pio_mode = XFER_PIO_0;
+		dev->dma_mode = 0xff;
 
 		/* If the controller has a pio mode setup function
 		 * then use it to set the chipset to rights. Don't
-- 
1.7.12.4

