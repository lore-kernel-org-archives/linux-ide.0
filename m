From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/13] sata_sil24: don't do hardreset during driver initialization
Date: Fri, 7 Apr 2006 17:16:54 +0900
Message-ID: <11443978141901-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.228]:2015 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932381AbWDGIRE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:04 -0400
Received: by wproxy.gmail.com with SMTP id 37so325369wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:03 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

There's no need to perform hardreset during driver initialization.
It's already done during host reset and even if the controller is in
some wacky state, we now have proper hardreset to back us up.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

37a3de1972e581e9a1609be875720bb0f9a3f455
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index fb260e7..46c0f2a 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -1070,11 +1070,6 @@ static int sil24_init_one(struct pci_dev
 
 		/* Clear port multiplier enable and resume bits */
 		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
-
-		/* Reset itself */
-		if (__sil24_reset_controller(port))
-			dev_printk(KERN_ERR, &pdev->dev,
-			           "failed to reset controller\n");
 	}
 
 	/* Turn on interrupts */
-- 
1.2.4


