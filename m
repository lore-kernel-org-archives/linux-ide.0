From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: fix NULL pointer dereference detected by Coverity
Date: Sat, 11 Mar 2006 12:47:54 +0900
Message-ID: <20060311034754.GA31198@htj.dyndns.org>
References: <20060310193414.GT21864@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:5618 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932379AbWCKDr7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 22:47:59 -0500
Received: by zproxy.gmail.com with SMTP id 14so909268nzn
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 19:47:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060310193414.GT21864@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Fix NULL pointer dereference detected by the Coverity checker.  Kill
dev -> pdev -> dev conversion while at it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>

--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -778,23 +778,17 @@ static irqreturn_t ahci_interrupt (int i
 			struct ata_queued_cmd *qc;
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (!ahci_host_intr(ap, qc))
-				if (ata_ratelimit()) {
-					struct pci_dev *pdev =
-						to_pci_dev(ap->host_set->dev);
-					dev_printk(KERN_WARNING, &pdev->dev,
+				if (ata_ratelimit())
+					dev_printk(KERN_WARNING, host_set->dev,
 					  "unhandled interrupt on port %u\n",
 					  i);
-				}
 
 			VPRINTK("port %u\n", i);
 		} else {
 			VPRINTK("port %u (no irq)\n", i);
-			if (ata_ratelimit()) {
-				struct pci_dev *pdev =
-					to_pci_dev(ap->host_set->dev);
-				dev_printk(KERN_WARNING, &pdev->dev,
+			if (ata_ratelimit())
+				dev_printk(KERN_WARNING, host_set->dev,
 					"interrupt on disabled port %u\n", i);
-			}
 		}
 
 		irq_ack |= (1 << i);
