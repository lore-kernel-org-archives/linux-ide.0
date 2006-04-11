From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/13] sata_sil24: put port into known state before softresetting
Date: Tue, 11 Apr 2006 22:32:19 +0900
Message-ID: <1144762339468-git-send-email-htejun@gmail.com>
References: <11447623382439-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.227]:2698 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750862AbWDKNc1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:32:27 -0400
Received: by wproxy.gmail.com with SMTP id i11so923321wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:32:26 -0700 (PDT)
In-Reply-To: <11447623382439-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make sure the controller has no pending commands and ready for command
before issuing SRST.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

538d286b508e9d611eeb1acdfeb0bfde395a0027
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 722b287..fed47cf 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -475,6 +475,12 @@ static int sil24_softreset(struct ata_po
 	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
 	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
 
+	/* put the port into known state */
+	if (sil24_init_port(ap)) {
+		reason ="port not ready";
+		goto err;
+	}
+
 	/*
 	 * XXX: Not sure whether the following sleep is needed or not.
 	 * The original driver had it.  So....
-- 
1.2.4


