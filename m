From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH REPOST] libata: lengthen interval between SRST set and clear
Date: Thu, 28 Sep 2006 18:13:34 +0900
Message-ID: <20060928091334.GM25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:41033 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751802AbWI1JNj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 05:13:39 -0400
Received: by py-out-1112.google.com with SMTP id n25so671828pyg
        for <linux-ide@vger.kernel.org>; Thu, 28 Sep 2006 02:13:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, justin@jmicron.com

20us delay is not enough for some controllers and they end up not
sending the second H2D FIS to clear SRST resulting in softreset
failure.  This problem has been spotted and diagnosed with SATA trace
by JMicron on sata_nv.

This patch makes ata_bus_softreset() use msleep(1) instead of
udelay(20) between SRST set and clear.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Justin Tsai <justin@jmicron.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 753b015..007020e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2414,15 +2414,15 @@ static unsigned int ata_bus_softreset(st
 	/* software reset.  causes dev0 to be selected */
 	if (ap->flags & ATA_FLAG_MMIO) {
 		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		udelay(20);	/* FIXME: flush */
+		msleep(1);	/* FIXME: flush */
 		writeb(ap->ctl | ATA_SRST, (void __iomem *) ioaddr->ctl_addr);
-		udelay(20);	/* FIXME: flush */
+		msleep(1);	/* FIXME: flush */
 		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 	} else {
 		outb(ap->ctl, ioaddr->ctl_addr);
-		udelay(10);
+		msleep(1);
 		outb(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
-		udelay(10);
+		msleep(1);
 		outb(ap->ctl, ioaddr->ctl_addr);
 	}
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
