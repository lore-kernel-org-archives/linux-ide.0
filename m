From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/8] sata_sil24: put port into known state before softresetting
Date: Wed, 5 Apr 2006 22:29:02 +0900
Message-ID: <11442437424151-git-send-email-htejun@gmail.com>
References: <11442437413563-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:7450 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751132AbWDEN3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:29:13 -0400
Received: by wproxy.gmail.com with SMTP id i7so187751wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:29:13 -0700 (PDT)
In-Reply-To: <11442437413563-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make sure the controller has no pending commands and ready for command
before issuing SRST.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

522c4966f33a80e263e018bbeb1a8a84bd1087e8
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index f50a728..e9058f0 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -470,6 +470,15 @@ static int sil24_softreset(struct ata_po
 	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
 	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
 
+	/* put the port into known state */
+	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
+	if (sil24_poll_register(port + PORT_CTRL_STAT,
+				PORT_CS_INIT | PORT_CS_RDY, PORT_CS_RDY,
+				10, 100)) {
+		DPRINTK("port not ready\n");
+		return -EIO;
+	}
+
 	/*
 	 * XXX: Not sure whether the following sleep is needed or not.
 	 * The original driver had it.  So....
-- 
1.2.4


