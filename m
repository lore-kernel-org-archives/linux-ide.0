From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 2/5] pata-rb532-cf: replace rb532_pata_finish_io()
Date: Tue, 27 Jan 2009 14:35:50 +0100
Message-ID: <20090127133616.8A6C14CD65@mail.nwl.cc>
References: <20090127133329.3A3F04CD65@mail.nwl.cc>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:35234 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290AbZA0NgS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 08:36:18 -0500
In-Reply-To: <20090127133329.3A3F04CD65@mail.nwl.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, florian@openwrt.org

Since the delay used internally is just the same as ata_sff_pause()
uses, rb532_pata_finish_io() does exactly the same as ata_sff_pause()
and thus can be replaced by the later one.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index ebfcda2..6fe660b 100644
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
@@ -87,7 +76,7 @@ static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char
 			*buf = readb(ioaddr);
 	}
 
-	rb532_pata_finish_io(adev->link->ap);
+	ata_sff_pause(ap);
 	return retlen;
 }
 
-- 
1.5.6.4

