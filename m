From: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] ide: Use inline function for eieio
Date: Tue, 10 Jul 2007 00:23:10 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0707100018020.5814@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34503 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbXGJFXg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 01:23:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp

Move to using inline function variant of eieio instead of inline assmebly.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit ff6ce6329e19cb82ee12447fe16c76c3dae7c1f4
tree ef830cd02624a79d7fa8c33b41f7229ff25a7d77
parent b30083183bf4987c8f7e9a8f753002a7ca5dc084
author Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jul 2007 00:13:54 -0500
committer Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jul 2007 00:13:54 -0500

 drivers/ide/pci/scc_pata.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/pci/scc_pata.c b/drivers/ide/pci/scc_pata.c
index 55bc0a3..b9fd2ac 100644
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -165,9 +165,9 @@ scc_ide_outbsync(ide_drive_t * drive, u8 addr, unsigned long port)
 	ide_hwif_t *hwif = HWIF(drive);

 	out_be32((void*)port, addr);
-	__asm__ __volatile__("eieio":::"memory");
+	eieio();
 	in_be32((void*)(hwif->dma_base + 0x01c));
-	__asm__ __volatile__("eieio":::"memory");
+	eieio();
 }

 static void
