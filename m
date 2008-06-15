From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cs: fix releasing I/O resources
Date: Sun, 15 Jun 2008 20:23:58 +0200
Message-ID: <200806152023.59096.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:62275 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758856AbYFOSXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 14:23:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2934519ywe.1
        for <linux-ide@vger.kernel.org>; Sun, 15 Jun 2008 11:23:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

hwif content is already freed after ide_release() call so cache
hwif->io_ports.{data,ctl}_addr in local variables in ide_detach().

This fixes 2.6.26 regression.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
for 2.6.26

 drivers/ide/legacy/ide-cs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: b/drivers/ide/legacy/ide-cs.c
===================================================================
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -135,13 +135,17 @@ static void ide_detach(struct pcmcia_dev
 {
     ide_info_t *info = link->priv;
     ide_hwif_t *hwif = info->hwif;
+    unsigned long data_addr, ctl_addr;
 
     DEBUG(0, "ide_detach(0x%p)\n", link);
 
+    data_addr = hwif->io_ports.data_addr;
+    ctl_addr  = hwif->io_ports.ctl_addr;
+
     ide_release(link);
 
-    release_region(hwif->io_ports.ctl_addr, 1);
-    release_region(hwif->io_ports.data_addr, 8);
+    release_region(ctl_addr, 1);
+    release_region(data_addr, 8);
 
     kfree(info);
 } /* ide_detach */
