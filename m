From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil24: lengthen softreset timeout
Date: Fri, 10 Mar 2006 16:25:27 +0900
Message-ID: <20060310072527.GB7510@htj.dyndns.org>
References: <20060308.143306.74747174.cyamauch@plamo.linet.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:38667 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751565AbWCJKMn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 05:12:43 -0500
Received: by zproxy.gmail.com with SMTP id 13so714003nzn
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 02:12:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060308.143306.74747174.cyamauch@plamo.linet.gr.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chisato Yamauchi <cyamauch@plamo.linet.gr.jp>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

sil24 softreset timeout was > 100ms (100 loops with msleep(1)), which
turned out to be too short for some devices (ASI ARAID99 2000).  This
patch converts sil24 softreset waiting loop to use proper timeout
condition and lengthen the timeout to 5 secs and check interval to
100ms.  Chisato Yamauchi discovered the problem and supplied initial
patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Chisato Yamauchi <cyamauch@plamo.linet.gr.jp>

---

Jeff, this patch is against the current #linus-git.  This doesn't
really count as regression but I think this should go upstream ASAP.
However, if that's not an option, this patch also applies to #upstream
with some offsets.

Chisato, thanks a lot for spotting it and sending fix.  :-)

 drivers/scsi/sata_sil24.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 9231301..13cdd22 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -433,8 +433,8 @@ static int sil24_issue_SRST(struct ata_p
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
+	unsigned long timeout = jiffies + 5 * HZ;
 	u32 irq_enable, irq_stat;
-	int cnt;
 
 	/* temporarily turn off IRQs during SRST */
 	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
@@ -451,7 +451,7 @@ static int sil24_issue_SRST(struct ata_p
 
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
 
-	for (cnt = 0; cnt < 100; cnt++) {
+	do {
 		irq_stat = readl(port + PORT_IRQ_STAT);
 		writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
 
@@ -459,8 +459,8 @@ static int sil24_issue_SRST(struct ata_p
 		if (irq_stat & (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR))
 			break;
 
-		msleep(1);
-	}
+		msleep(100);
+	} while (time_before(jiffies, timeout));
 
 	/* restore IRQs */
 	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
