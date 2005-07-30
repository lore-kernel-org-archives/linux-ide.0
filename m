From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 04/07] sil24: remove irq disable code on spurious interrupt
Date: Sat, 30 Jul 2005 19:14:12 +0900 (KST)
Message-ID: <20050730101344.EB905F0C@htj.dyndns.org>
References: <20050730101344.1C985988@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:41859 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263039AbVG3KOS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2005 06:14:18 -0400
Received: by wproxy.gmail.com with SMTP id i27so760329wra
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2005 03:14:16 -0700 (PDT)
In-Reply-To: <20050730101344.1C985988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

04_sil24_remove-irq-disable-on-spurious-interrupt.patch

	If interrupt occurs on a disabled port, the driver used to
	mask the port's interrupt, but we don't know if such action is
	necessary yet and that's not what other drives do.  So, just
	do nothing and tell IRQ subsystem that it's not our interrupt.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
@@ -553,17 +553,12 @@ static irqreturn_t sil24_interrupt(int i
 	for (i = 0; i < host_set->n_ports; i++)
 		if (status & (1 << i)) {
 			struct ata_port *ap = host_set->ports[i];
-			if (ap && !(ap->flags & ATA_FLAG_PORT_DISABLED))
+			if (ap && !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 				sil24_host_intr(host_set->ports[i]);
-			else {
-				u32 tmp;
-				printk(KERN_WARNING DRV_NAME
-				       ": spurious interrupt from port %d\n", i);
-				tmp = readl(hpriv->host_base + HOST_CTRL);
-				tmp &= ~(1 << i);
-				writel(tmp, hpriv->host_base + HOST_CTRL);
-			}
-			handled++;
+				handled++;
+			} else
+				printk(KERN_ERR DRV_NAME
+				       ": interrupt from disabled port %d\n", i);
 		}
 
 	spin_unlock(&host_set->lock);

