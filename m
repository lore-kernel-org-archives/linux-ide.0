From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/21] libata: quickly trigger SATA SPD down after debouncing failed
Date: Mon, 16 Jul 2007 14:29:40 +0900
Message-ID: <11845637801929-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:11862 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762489AbXGPF3v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:51 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736630nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:51 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
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
index c60155e..58bc40e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3267,9 +3267,11 @@ int sata_phy_debounce(struct ata_port *ap, const unsigned long *params,
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
index 183eaf4..1a4397a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1790,7 +1790,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			schedule_timeout_uninterruptible(delta);
 		}
 
-		if (reset == hardreset &&
+		if (rc == -EPIPE ||
 		    try == ARRAY_SIZE(ata_eh_reset_timeouts) - 1)
 			sata_down_spd_limit(ap);
 		if (hardreset)
-- 
1.5.0.3


