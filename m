From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/10] sata_sil24: rename PORT_CS_RESUME to PORT_CS_PM_RESUME
Date: Fri, 12 May 2006 01:43:42 +0900
Message-ID: <11473658223021-git-send-email-htejun@gmail.com>
References: <11473658222012-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:19721 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030342AbWEKQny (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:43:54 -0400
Received: by nz-out-0102.google.com with SMTP id 13so248086nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:43:53 -0700 (PDT)
In-Reply-To: <11473658222012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Rename PORT_CS_RESUME to PORT_CS_PM_RESUME for clarification.

---

 drivers/scsi/sata_sil24.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

9509aa53e70d4bb8f4d20c54458637970ec15b62
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index e3d13d6..e38e1fc 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -138,7 +138,7 @@ enum {
 	PORT_CS_INIT		= (1 << 2), /* port initialize */
 	PORT_CS_IRQ_WOC		= (1 << 3), /* interrupt write one to clear */
 	PORT_CS_CDB16		= (1 << 5), /* 0=12b cdb, 1=16b cdb */
-	PORT_CS_RESUME		= (1 << 6), /* port resume */
+	PORT_CS_PM_RESUME	= (1 << 6), /* PM resume */
 	PORT_CS_32BIT_ACTV	= (1 << 10), /* 32-bit activation */
 	PORT_CS_PM_EN		= (1 << 13), /* port multiplier enable */
 	PORT_CS_RDY		= (1 << 31), /* port ready to accept commands */
@@ -1128,7 +1128,7 @@ static int sil24_init_one(struct pci_dev
 		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
 
 		/* Clear port multiplier enable and resume bits */
-		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
+		writel(PORT_CS_PM_EN | PORT_CS_PM_RESUME, port + PORT_CTRL_CLR);
 	}
 
 	/* Turn on interrupts */
-- 
1.2.4


