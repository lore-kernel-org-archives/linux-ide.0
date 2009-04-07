From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] hpt366: fix HPT370 DMA timeouts
Date: Tue, 7 Apr 2009 20:09:32 +0400
Message-ID: <200904072009.32070.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40631 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758958AbZDGQIx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 12:08:53 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org

The big driver change in 2.4.19-rc1 introduced a regression for many HPT370[A]
chips -- DMA stopped to work completely, only causing endless timeouts...

The culprit has been identified (at last!): it turned to be the code resetting
the DMA state machine before each transfer. Stop doing it now as this counter-
measure has clearly caused more harm than good.

This should fix the kernel.org bug #7703.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree.
It should go into all stable kernels as it fixes post-2.4.18 (!) regression.

 drivers/ide/hpt366.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/hpt366.c
+++ linux-2.6/drivers/ide/hpt366.c
@@ -114,6 +114,8 @@
  *   the register setting lists into the table indexed by the clock selected
  * - set the correct hwif->ultra_mask for each individual chip
  * - add Ultra and MW DMA mode filtering for the HPT37[24] based SATA cards
+ * - stop resetting HPT370's state machine before each DMA transfer as that has
+ *   caused more harm than good
  *	Sergei Shtylyov, <sshtylyov@ru.mvista.com> or <source@mvista.com>
  */
 
@@ -133,7 +135,7 @@
 #define DRV_NAME "hpt366"
 
 /* various tuning parameters */
-#define HPT_RESET_STATE_ENGINE
+#undef	HPT_RESET_STATE_ENGINE
 #undef	HPT_DELAY_INTERRUPT
 
 static const char *quirk_drives[] = {

