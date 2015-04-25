From: Silvan Wicki <linux_wi@tinag.ch>
Subject: [PATCH] Ata: ahci: reindent
Date: Sun, 26 Apr 2015 00:02:32 +0200
Message-ID: <1429999352-10942-1-git-send-email-linux_wi@tinag.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:10810 "EHLO
	mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750891AbbDYXTv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Apr 2015 19:19:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Silvan Wicki <linux_wi@tinag.ch>

This patch fixes checkpatch.pl warning:
- "WARNING: please, no space before tabs"

Signed-off-by: Silvan Wicki <linux_wi@tinag.ch>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 33bb06e..be3438f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2,7 +2,7 @@
  *  ahci.c - AHCI SATA support
  *
  *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
+ *		    Please ALWAYS copy linux-ide@vger.kernel.org
  *		    on emails.
  *
  *  Copyright 2004-2005 Red Hat, Inc.
-- 
2.1.4

