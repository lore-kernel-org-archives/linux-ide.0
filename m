From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/13] sata_sil24: kill 10ms sleep in softreset
Date: Fri, 7 Apr 2006 17:16:54 +0900
Message-ID: <1144397814965-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932375AbWDGIRE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:04 -0400
Received: by wproxy.gmail.com with SMTP id i11so294611wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:03 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Nothing, not the datasheet nor the errats, says this delay is
necessary and with the previous PORT_CS_INIT change, we know the
controller is in good state.  Kill 10ms sleep.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

2963e81690dadcb59329709422d7b6c2e22f53e0
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index b739c23..55f51e1 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -481,12 +481,7 @@ static int sil24_softreset(struct ata_po
 		goto err;
 	}
 
-	/*
-	 * XXX: Not sure whether the following sleep is needed or not.
-	 * The original driver had it.  So....
-	 */
-	msleep(10);
-
+	/* do SRST */
 	prb->ctrl = PRB_CTRL_SRST;
 	prb->fis[1] = 0; /* no PM yet */
 
-- 
1.2.4


