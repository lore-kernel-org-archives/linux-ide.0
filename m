From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] Revert "Revert "ide: try to use PIO Mode 0 during probe if possible""
Date: Wed, 7 Oct 2009 00:27:45 +0200
Message-ID: <200910070027.45678.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:61350 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbZJFW2G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 18:28:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Joao Ramos <joao.ramos@inov.pt>, David Fries <david@fries.net>, d.stussy@yahoo.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] Revert "Revert "ide: try to use PIO Mode 0 during probe if possible""

This reverts commit 24df31acaff8465d797f0006437b45ad0f2a5cb1.

The root cause of reported system hangs was (now fixed) sis5513 bug
and not "ide: try to use PIO Mode 0 during probe if possible" change
(commit 6029336426a2b43e4bc6f4a84be8789a047d139e) so the revert was
incorrect (it simply replaced one regression with the other one).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Joao Ramos <joao.ramos@inov.pt>
Cc: David Fries <david@fries.net>
Cc: d.stussy@yahoo.com
---
 drivers/ide/ide-probe.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 4d76ba4..63c53d6 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1046,6 +1046,15 @@ static void ide_port_init_devices(ide_hwif_t *hwif)
 		if (port_ops && port_ops->init_dev)
 			port_ops->init_dev(drive);
 	}
+
+	ide_port_for_each_dev(i, drive, hwif) {
+		/*
+		 * default to PIO Mode 0 before we figure out
+		 * the most suited mode for the attached device
+		 */
+		if (port_ops && port_ops->set_pio_mode)
+			port_ops->set_pio_mode(drive, 0);
+	}
 }
 
 static void ide_init_port(ide_hwif_t *hwif, unsigned int port,
-- 
1.6.5.rc2

