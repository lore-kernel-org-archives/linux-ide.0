From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/9] ide: fix ide_register_hw() to check hwif->io_ports[]
Date: Mon, 24 Sep 2007 22:35:21 +0200
Message-ID: <200709242235.21740.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29604 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbXIXUqE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:04 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485932nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


hwif->hw.io_ports[] and hwif->io_ports[] should be the same but "4drives"
support and scc_pata host driver set only hwif->io_ports[].

To compensate for this check hwif->io_ports[] instead of hwif->hw.io_ports[]
in ide_register_hw() (instead of fixing "4drives" and scc_pata because hwif->hw
is to be removed).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -709,7 +709,7 @@ int ide_register_hw(hw_regs_t *hw, void 
 	do {
 		for (index = 0; index < MAX_HWIFS; ++index) {
 			hwif = &ide_hwifs[index];
-			if (hwif->hw.io_ports[IDE_DATA_OFFSET] == hw->io_ports[IDE_DATA_OFFSET])
+			if (hwif->io_ports[IDE_DATA_OFFSET] == hw->io_ports[IDE_DATA_OFFSET])
 				goto found;
 		}
 		for (index = 0; index < MAX_HWIFS; ++index) {
@@ -717,7 +717,7 @@ int ide_register_hw(hw_regs_t *hw, void 
 			if (hwif->hold)
 				continue;
 			if ((!hwif->present && !hwif->mate && !initializing) ||
-			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && initializing))
+			    (!hwif->io_ports[IDE_DATA_OFFSET] && initializing))
 				goto found;
 		}
 		for (index = 0; index < MAX_HWIFS; index++)
