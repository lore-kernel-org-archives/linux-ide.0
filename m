From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] tx4938ide: Avoid underflow on calculation of a wait cycle
Date: Tue, 28 Oct 2008 22:09:04 +0900 (JST)
Message-ID: <20081028.220904.128617360.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:57674 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbYJ1NJG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 09:09:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org, sshtylyov@ru.mvista.com

Make 'wt' variable signed while it can be negative during calculation.

Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4938ide.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 796289c..9120063 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -26,12 +26,13 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
 	unsigned int sp = (cr >> 4) & 3;
 	unsigned int clock = gbus_clock / (4 - sp);
 	unsigned int cycle = 1000000000 / clock;
-	unsigned int wt, shwt;
+	unsigned int shwt;
+	int wt;
 
 	/* Minimum DIOx- active time */
 	wt = DIV_ROUND_UP(t->act8b, cycle) - 2;
 	/* IORDY setup time: 35ns */
-	wt = max(wt, DIV_ROUND_UP(35, cycle));
+	wt = max_t(int, wt, DIV_ROUND_UP(35, cycle));
 	/* actual wait-cycle is max(wt & ~1, 1) */
 	if (wt > 2 && (wt & 1))
 		wt++;
-- 
1.5.6.3
