From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/13] sata_sil24: kill 10ms sleep in softreset
Date: Tue, 11 Apr 2006 22:32:19 +0900
Message-ID: <1144762339679-git-send-email-htejun@gmail.com>
References: <11447623382439-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.230]:6026 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750861AbWDKNc0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:32:26 -0400
Received: by wproxy.gmail.com with SMTP id i11so923319wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:32:26 -0700 (PDT)
In-Reply-To: <11447623382439-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Nothing, not the datasheet nor the errats, says this delay is
necessary and with the previous PORT_CS_INIT change, we know the
controller is in good state.  Kill 10ms sleep.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

3521764734fe58136495bd063c28f08e096f3b02
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index fed47cf..933bc44 100644
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


