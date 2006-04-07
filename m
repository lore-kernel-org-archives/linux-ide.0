From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/13] sata_sil24: implement sil24_init_port()
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <11443978133834-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:64990 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932374AbWDGIRD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:03 -0400
Received: by wproxy.gmail.com with SMTP id 36so300023wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:02 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Implement sil24_init_port which performs port initialization via
PORT_CS_INIT.  To be used later by softreset and EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

85433646e8335528b6cd754efa8c8b9607c6c340
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 5f3a17d..ccb442f 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -438,6 +438,22 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
+static int sil24_init_port(struct ata_port *ap)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	u32 tmp;
+
+	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
+	ata_wait_register(port + PORT_CTRL_STAT,
+			  PORT_CS_INIT, PORT_CS_INIT, 10, 100);
+	tmp = ata_wait_register(port + PORT_CTRL_STAT,
+				PORT_CS_RDY, 0, 10, 100);
+
+	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY)
+		return -EIO;
+	return 0;
+}
+
 static int sil24_softreset(struct ata_port *ap, unsigned int *class)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-- 
1.2.4


