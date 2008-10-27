From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] irq handler must disable the handled irq
Date: Mon, 27 Oct 2008 15:01:47 +0100
Message-ID: <1225116107-9753-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:43826 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbYJ0OMn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 10:12:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/ata/pata_rb532_cf.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index f8b3ffc..a1d44a6 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -116,6 +116,8 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
 	}
 
+	disable_irq(irq);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.5.6.4

