From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] libata: quickly trigger SATA SPD down after debouncing failed
Date: Sun, 1 Jul 2007 18:53:38 +0900
Message-ID: <11832836181110-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:30760 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431AbXGAJxq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876599wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:46 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Debouncing failure is a good indicator of basic link problem.  Use
-EPIPE to indicate debouncing failure and make ata_eh_reset() invoke
sata_down_spd_limit() if the error occurs during reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    6 ++++--
 drivers/ata/libata-eh.c   |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 49fe30a..c0a2b6c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3294,9 +3294,11 @@ int sata_phy_debounce(struct ata_port *ap, const unsigned long *params,
 		last = cur;
 		last_jiffies = jiffies;
 
-		/* check deadline */
+		/* Check deadline.  If debouncing failed, return
+		 * -EPIPE to tell upper layer to lower link speed.
+		 */
 		if (time_after(jiffies, deadline))
-			return -EBUSY;
+			return -EPIPE;
 	}
 }
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d18c475..1c50fae 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1725,7 +1725,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			schedule_timeout_uninterruptible(delta);
 		}
 
-		if (reset == hardreset &&
+		if (rc == -EPIPE ||
 		    try == ARRAY_SIZE(ata_eh_reset_timeouts) - 1)
 			sata_down_spd_limit(ap);
 		if (hardreset)
-- 
1.5.0.3


