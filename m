From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] libata-sff: trivial corrections to Kconfig help text
Date: Sat, 29 May 2010 12:47:45 +0200 (CEST)
Message-ID: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:52392 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab0E2Kxc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 May 2010 06:53:32 -0400
Content-Disposition: INLINE
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ata/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 73f8833..aa85a98 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -168,10 +168,10 @@ config ATA_BMDMA
 	default y
 	help
 	  This option adds support for SFF ATA controllers with BMDMA
-	  capability.  BMDMA stands for bus-master DMA and the
-	  de-facto DMA interface for SFF controllers.
+	  capability.  BMDMA stands for bus-master DMA and is the
+	  de facto DMA interface for SFF controllers.
 
-	  If unuser, say Y.
+	  If unsure, say Y.
 
 if ATA_BMDMA
 

By the way, is there something that could be said in a few words in the
help text when to enable that option and when not?

Or could that option even be hidden and 'select'ed by bus master DMA
capable ATA SFF drivers?
-- 
Stefan Richter
-=====-==-=- -=-= ===-=
http://arcgraph.de/sr/

