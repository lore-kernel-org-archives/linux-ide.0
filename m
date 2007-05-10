From: olof@lixom.net (Olof Johansson)
Subject: [PATCH] pata_platform: don't use generic ata_port_start
Date: Wed, 9 May 2007 23:00:20 -0500
Message-ID: <20070510040020.GA17530@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:58756 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbXEJEbq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 00:31:46 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: lethal@linux-sh.org, linux-ide@vger.kernel.org

Hi,

I have a system where I have a simple IDE controller that sits on a
local bus without bus master dma capability, and thus no dma_mapping
ops defined for the device/bus.

pata_platform works great for me, with the exception of using the generic
ata_port_start which tries to do a dmam_alloc_coherent.

Looks like it doesn't need to allocate a prd table at all, so replace it
with a dummy function instead.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 4b82a54..a0aede1 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -48,6 +48,8 @@ static int pata_platform_set_mode(struct ata_port *ap, struct ata_device **unuse
 	return 0;
 }
 
+static int ata_dummy_ret0(struct ata_port *ap)	{ return 0; }
+
 static struct scsi_host_template pata_platform_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -91,7 +93,7 @@ static struct ata_port_operations pata_platform_port_ops = {
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_dummy_ret0,
 };
 
 static void pata_platform_setup_port(struct ata_ioports *ioaddr,
