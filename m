From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 3/5] pata-rb532-cf: use ata_sff_exec_command()
Date: Tue, 20 Jan 2009 17:40:58 +0100
Message-ID: <20090120164256.89B08400E123@mail.nwl.cc>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net>
 <1232469660-22335-1-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-2-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-3-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:53822 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756685AbZATQtl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 11:49:41 -0500
In-Reply-To: <1232469660-22335-3-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, bzolnier@gmail.com, florian@openwrt.org

The only difference between rb532_pata_exec_command() and
ata_sff_exec_command() is added debugging output, so it can be dropped
and the standard op used instead.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 9305eee..11a4411 100644
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
@@ -108,7 +101,6 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 
 static struct ata_port_operations rb532_pata_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.sff_exec_command	= rb532_pata_exec_command,
 	.sff_data_xfer		= rb532_pata_data_xfer,
 	.freeze			= rb532_pata_freeze,
 	.thaw			= rb532_pata_thaw,
-- 
1.5.6.4

