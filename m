From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/8] libata: separate out sil24_poll_register()
Date: Wed, 5 Apr 2006 22:29:02 +0900
Message-ID: <1144243742725-git-send-email-htejun@gmail.com>
References: <11442437413563-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:7141 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbWDEN7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:59:23 -0400
Received: by pproxy.gmail.com with SMTP id i49so1090295pye
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:59:22 -0700 (PDT)
In-Reply-To: <11442437413563-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This will be used by later patches.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

dbf21a7fbc3fe926671416fecebfea70aef78c8a
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 86233ac..0941f74 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -431,6 +431,24 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
+static int sil24_poll_register(void __iomem *reg, u32 mask, u32 val,
+			       unsigned long interval_msec,
+			       unsigned long timeout_msec)
+{
+	unsigned long timeout;
+	u32 tmp;
+
+	timeout = jiffies + (timeout_msec * HZ) / 1000;
+	do {
+		tmp = readl(reg);
+		if ((tmp & mask) == val)
+			return 0;
+		msleep(interval_msec);
+	} while (time_before(jiffies, timeout));
+
+	return -1;
+}
+
 static int sil24_softreset(struct ata_port *ap, unsigned int *class)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -949,13 +967,12 @@ static int sil24_init_one(struct pci_dev
 			probe_ent->host_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
 	}
 
-	/* Mask interrupts during initialization */
+	/* Clear global reset & mask interrupts during initialization */
 	writel(0, host_base + HOST_CTRL);
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
 		void __iomem *port = port_base + i * PORT_REGS_SIZE;
 		unsigned long portu = (unsigned long)port;
-		int cnt;
 
 		probe_ent->port[i].cmd_addr = portu + PORT_PRB;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
@@ -975,16 +992,11 @@ static int sil24_init_one(struct pci_dev
 		tmp = readl(port + PORT_CTRL_STAT);
 		if (tmp & PORT_CS_PORT_RST) {
 			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
-			readl(port + PORT_CTRL_STAT);	/* sync */
-			for (cnt = 0; cnt < 10; cnt++) {
-				msleep(10);
-				tmp = readl(port + PORT_CTRL_STAT);
-				if (!(tmp & PORT_CS_PORT_RST))
-					break;
-			}
-			if (tmp & PORT_CS_PORT_RST)
+			if (sil24_poll_register(port + PORT_CTRL_STAT,
+						PORT_CS_PORT_RST, 0, 10, 100))
 				dev_printk(KERN_ERR, &pdev->dev,
-				           "failed to clear port RST\n");
+					   "failed to clear RST for port %d\n",
+					   i);
 		}
 
 		/* Zero error counters. */
-- 
1.2.4


