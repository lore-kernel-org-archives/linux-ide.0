From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 1/5] pata-rb532-cf: remove set_irq_type from finish_io
Date: Tue, 20 Jan 2009 17:40:56 +0100
Message-ID: <20090120164253.C5D59400E106@mail.nwl.cc>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net>
 <1232469660-22335-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:53825 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757774AbZATQtl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 11:49:41 -0500
In-Reply-To: <1232469660-22335-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, bzolnier@gmail.com, florian@openwrt.org

The driver has been tested without the call to set_irq_type at this
point and occurs to work fine, so it should be safe to remove it.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 362af11..cd2eecd 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -63,8 +63,6 @@ static inline void rb532_pata_finish_io(struct ata_port *ap)
 	   ata_sff_sync might be sufficient. */
 	ata_sff_dma_pause(ap);
 	ndelay(RB500_CF_IO_DELAY);
-
-	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
 }
 
 static void rb532_pata_exec_command(struct ata_port *ap,
-- 
1.5.6.4

