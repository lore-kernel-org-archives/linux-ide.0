From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.33-rc3] sata_promise: don't classify overruns as HSM errors
Date: Sat, 9 Jan 2010 23:32:06 +0100
Message-ID: <19273.998.753256.526176@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:59488 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab0AIWcQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jan 2010 17:32:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, thomas schorpp <thomas.schorpp@googlemail.com>

When sata_promise encounters an overrun or underrun error it
translates that to a libata AC_ERR_HSM, causing a hard reset.
Since over/under-runs were thought to be rare and transient,
this action seemed reasonable.

Unfortunately it turns out that the controller throws overrun
errors when e.g. hal polls a CD or DVD writer containing blank
media, causing long sequences of hard resets and retries before
EH finally gives up.

This patch updates sata_promise to classify over/under-runs as
AC_ERR_OTHER instead. This allows libata EH and upper layers to
retry or fail the operation as they see fit without the disruption
caused by repeated hard resets.

This fixes a problem using a DVD-RAM drive with sata_promise,
reported by Thomas Schorpp. I also tested it on a DVD-RW drive.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
Tested-by: thomas schorpp <thomas.schorpp@googlemail.com>
---
 drivers/ata/sata_promise.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -rupN linux-2.6.33-rc3/drivers/ata/sata_promise.c linux-2.6.33-rc3.sata_promise-overrun-not-hsm/drivers/ata/sata_promise.c
--- linux-2.6.33-rc3/drivers/ata/sata_promise.c	2009-12-03 12:38:32.000000000 +0100
+++ linux-2.6.33-rc3.sata_promise-overrun-not-hsm/drivers/ata/sata_promise.c	2010-01-09 16:19:29.000000000 +0100
@@ -862,7 +862,7 @@ static void pdc_error_intr(struct ata_po
 	if (port_status & PDC_DRIVE_ERR)
 		ac_err_mask |= AC_ERR_DEV;
 	if (port_status & (PDC_OVERRUN_ERR | PDC_UNDERRUN_ERR))
-		ac_err_mask |= AC_ERR_HSM;
+		ac_err_mask |= AC_ERR_OTHER;
 	if (port_status & (PDC2_ATA_HBA_ERR | PDC2_ATA_DMA_CNT_ERR))
 		ac_err_mask |= AC_ERR_ATA_BUS;
 	if (port_status & (PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR | PDC2_HTO_ERR
