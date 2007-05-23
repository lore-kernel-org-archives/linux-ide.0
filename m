From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] ata: pata_platform: Disable prereset logic.
Date: Wed, 23 May 2007 15:44:08 +0900
Message-ID: <20070523064408.GA29593@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:42311 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756617AbXEWGpE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 02:45:04 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On a number of boards the current prereset logic seems to misbehave:

scsi0 : pata_platform
ata1: PATA max PIO0 cmd 0xb06001f0 ctl 0xb06003f6 bmdma 0x00000000 irq 0
ata1: device not ready (errno=-19), forcing hardreset
ata1: BUG: prereset() requested invalid reset type

This triggers when there is no card inserted in the slot.

Simply disabling the prereset gets rid of this, and doesn't seem to cause
any problems for either PCMCIA or CF cards when they're actually present.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 drivers/ata/pata_platform.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index cbb7866..8a569c7 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -1,7 +1,7 @@
 /*
  * Generic platform device PATA driver
  *
- * Copyright (C) 2006  Paul Mundt
+ * Copyright (C) 2006 - 2007  Paul Mundt
  *
  * Based on pata_pcmcia:
  *
@@ -22,7 +22,7 @@
 #include <linux/pata_platform.h>
 
 #define DRV_NAME "pata_platform"
-#define DRV_VERSION "1.0"
+#define DRV_VERSION "1.1"
 
 static int pio_mask = 1;
 
@@ -30,7 +30,8 @@ static int pio_mask = 1;
  * Provide our own set_mode() as we don't want to change anything that has
  * already been configured..
  */
-static int pata_platform_set_mode(struct ata_port *ap, struct ata_device **unused)
+static int pata_platform_set_mode(struct ata_port *ap,
+				  struct ata_device **unused)
 {
 	int i;
 
@@ -48,6 +49,12 @@ static int pata_platform_set_mode(struct ata_port *ap, struct ata_device **unuse
 	return 0;
 }
 
+static void pata_platform_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, NULL, ata_std_softreset, NULL,
+			ata_std_postreset);
+}
+
 static int ata_dummy_ret0(struct ata_port *ap)	{ return 0; }
 
 static struct scsi_host_template pata_platform_sht = {
@@ -80,7 +87,7 @@ static struct ata_port_operations pata_platform_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= pata_platform_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.cable_detect		= ata_cable_unknown,
 
