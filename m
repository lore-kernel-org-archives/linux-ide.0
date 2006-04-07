From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/13] sata_sil24: put port into known state before softresetting
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <114439781367-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.238]:2015 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932370AbWDGIRD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:03 -0400
Received: by wproxy.gmail.com with SMTP id i11so294607wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:02 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Make sure the controller has no pending commands and ready for command
before issuing SRST.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

b2c3f8df81a80fae7e9c145a5b73939799c66447
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index ccb442f..b739c23 100644
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


