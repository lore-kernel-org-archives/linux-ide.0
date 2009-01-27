From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 3/5] pata-rb532-cf: use ata_sff_exec_command()
Date: Tue, 27 Jan 2009 14:35:51 +0100
Message-ID: <20090127133631.89AE34CD65@mail.nwl.cc>
References: <20090127133329.3A3F04CD65@mail.nwl.cc>
 <1233063353-12770-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:35248 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZA0Ngc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 08:36:32 -0500
In-Reply-To: <1233063353-12770-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, florian@openwrt.org

The only difference between rb532_pata_exec_command() and
ata_sff_exec_command() is added debugging output, so it can be dropped
and the standard op used instead.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 6fe660b..9d61ce5 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -54,13 +54,6 @@ struct rb532_cf_info {
 
 /* ------------------------------------------------------------------------ */
 
-static void rb532_pata_exec_command(struct ata_port *ap,
-				const struct ata_taskfile *tf)
-{
-	writeb(tf->command, ap->ioaddr.command_addr);
-	ata_sff_pause(ap);
-}
-
 static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
 				unsigned int buflen, int write_data)
 {
@@ -112,7 +105,6 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 
 static struct ata_port_operations rb532_pata_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.sff_exec_command	= rb532_pata_exec_command,
 	.sff_data_xfer		= rb532_pata_data_xfer,
 	.freeze			= rb532_pata_freeze,
 	.thaw			= rb532_pata_thaw,
-- 
1.5.6.4

