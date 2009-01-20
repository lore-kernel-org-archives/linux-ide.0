From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 2/5] pata-rb532-cf: replace rb532_pata_finish_io()
Date: Tue, 20 Jan 2009 17:40:57 +0100
Message-ID: <20090120164259.54630400E125@mail.nwl.cc>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net>
 <1232469660-22335-1-git-send-email-n0-1@freewrt.org>
 <1232469660-22335-2-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:53827 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757868AbZATQtn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 11:49:43 -0500
In-Reply-To: <1232469660-22335-2-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, bzolnier@gmail.com, florian@openwrt.org

Since the delay used internally is just the same as ata_sff_pause()
uses, rb532_pata_finish_io() does exactly the same as ata_sff_pause()
and thus can be replaced by the later one.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index cd2eecd..9305eee 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -54,22 +54,11 @@ struct rb532_cf_info {
 
 /* ------------------------------------------------------------------------ */
 
-static inline void rb532_pata_finish_io(struct ata_port *ap)
-{
-	struct ata_host *ah = ap->host;
-	struct rb532_cf_info *info = ah->private_data;
-
-	/* FIXME: Keep previous delay. If this is merely a fence then
-	   ata_sff_sync might be sufficient. */
-	ata_sff_dma_pause(ap);
-	ndelay(RB500_CF_IO_DELAY);
-}
-
 static void rb532_pata_exec_command(struct ata_port *ap,
 				const struct ata_taskfile *tf)
 {
 	writeb(tf->command, ap->ioaddr.command_addr);
-	rb532_pata_finish_io(ap);
+	ata_sff_pause(ap);
 }
 
 static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
@@ -83,7 +72,7 @@ static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char
 	else
 		readsl(ioaddr, buf, buflen / sizeof(u32));
 
-	rb532_pata_finish_io(adev->link->ap);
+	ata_sff_pause(ap);
 	return buflen - buflen % sizeof(u32);
 }
 
-- 
1.5.6.4

