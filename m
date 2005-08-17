From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 02/08] sil24: remove irq disable code on spurious interrupt
Date: Wed, 17 Aug 2005 13:08:47 +0900 (KST)
Message-ID: <20050817040611.5C56CED5@htj.dyndns.org>
References: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:51465 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750830AbVHQEJD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:09:03 -0400
Received: by wproxy.gmail.com with SMTP id i2so85468wra
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:08:52 -0700 (PDT)
In-Reply-To: <20050817040611.C0A53974@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

02_sil24_remove-irq-disable-on-spurious-intr.patch

	If interrupt occurs on a disabled port, the driver used to
        mask the port's interrupt, but we don't know if such action is
        necessary yet and that's not what other drives do.  So, just
        do nothing and tell IRQ subsystem that it's not our interrupt.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-08-17 13:06:06.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-08-17 13:06:07.000000000 +0900
@@ -535,17 +535,12 @@ static irqreturn_t sil24_interrupt(int i
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

