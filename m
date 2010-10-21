From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] pata_bf54x: fix return type of bfin_set_devctl
Date: Thu, 21 Oct 2010 04:00:40 -0400
Message-ID: <1287648040-19759-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:42211 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab0JUIKM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2010 04:10:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org

The new devctl func added for us to the driver has the wrong return
type.  Which is to say there shouldn't be any.  This fixes compile
time warnings as there shouldn't be any runtime difference.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/ata/pata_bf54x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 9cae65d..5eeb922 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -826,7 +826,7 @@ static void bfin_dev_select(struct ata_port *ap, unsigned int device)
  *	@ctl: value to write
  */
 
-static u8 bfin_set_devctl(struct ata_port *ap, u8 ctl)
+static void bfin_set_devctl(struct ata_port *ap, u8 ctl)
 {
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
 	write_atapi_register(base, ATA_REG_CTRL, ctl);
-- 
1.7.3.1

