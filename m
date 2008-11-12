From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] pata-rb532-cf: fix signature of the xfer function
Date: Wed, 12 Nov 2008 01:14:09 +0100
Message-ID: <1226448849-11460-1-git-send-email-n0-1@freewrt.org>
References: <1226448821-10933-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:38315 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYKLAON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 19:14:13 -0500
In-Reply-To: <1226448821-10933-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>

Per definition, this function should return the number of bytes
consumed. Also take care of the unlikely case when buflen is not a
multiple of four; while transferring, the division cuts the remaining
bytes, so alter the return value accordingly.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index b919012..95a0d66 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -75,7 +75,7 @@ static void rb532_pata_exec_command(struct ata_port *ap,
 	rb532_pata_finish_io(ap);
 }
 
-static void rb532_pata_data_xfer(struct ata_device *adev,
+static unsigned int rb532_pata_data_xfer(struct ata_device *adev,
 		unsigned char *buf, unsigned int buflen, int write_data)
 {
 	struct ata_port *ap = adev->link->ap;
@@ -87,6 +87,7 @@ static void rb532_pata_data_xfer(struct ata_device *adev,
 		readsl(ioaddr, buf, buflen / sizeof(u32));
 
 	rb532_pata_finish_io(adev->link->ap);
+	return buflen - (buflen % sizeof(u32));
 }
 
 static void rb532_pata_freeze(struct ata_port *ap)
-- 
1.5.6.4

