From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/8] sata_sil24: kill 10ms sleep in softreset
Date: Wed, 5 Apr 2006 22:29:02 +0900
Message-ID: <1144243742914-git-send-email-htejun@gmail.com>
References: <11442437413563-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.230]:10522 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751134AbWDEN3O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:29:14 -0400
Received: by wproxy.gmail.com with SMTP id 68so150136wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:29:14 -0700 (PDT)
In-Reply-To: <11442437413563-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Nothing, not the datasheet nor the errats, says this delay is
necessary and with the previous PORT_CS_INIT change, we know the
controller is in good state.  Kill 10ms sleep.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

5f8f23ba275973ce1582a8816816ba872316d820
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index e9058f0..3d8047e 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -479,12 +479,7 @@ static int sil24_softreset(struct ata_po
 		return -EIO;
 	}
 
-	/*
-	 * XXX: Not sure whether the following sleep is needed or not.
-	 * The original driver had it.  So....
-	 */
-	msleep(10);
-
+	/* do SRST */
 	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
 	prb->fis[1] = 0; /* no PM yet */
 
-- 
1.2.4


