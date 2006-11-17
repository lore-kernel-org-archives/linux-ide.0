From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: make sure IRQ is cleared after ata_bmdma_freeze()
Date: Fri, 17 Nov 2006 12:07:50 +0900
Message-ID: <20061117030750.GE2184@htj.dyndns.org>
References: <20061117030621.GD2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:56113 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424755AbWKQDH5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Nov 2006 22:07:57 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1203166nfa
        for <linux-ide@vger.kernel.org>; Thu, 16 Nov 2006 19:07:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061117030621.GD2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Now that BMDMA status is recorded in irq handler.  ata_bmdma_freeze()
is free to manipulate host status.  Under certain circumstances, some
controllers (ICH7 in enhanced mode w/ IRQ shared) raise IRQ when CTL
register is written to and ATA_NIEN doesn't mask it.

This patch makes ata_bmdma_freeze() clear all pending IRQs after
freezing a port.  This change makes explicit clearing in
ata_device_add() unnecessary and thus kills it.  The removed code was
SFF-specific and was in the wrong place.

Note that ->freeze() handler is always called under ap->lock held and
irq disabled.  Even if CTL manipulation causes stuck IRQ, it's cleared
immediately.  This should be safe (enough) even in SMP environment.
More correct solution is to mask the IRQ from IRQ controller but that
would be an overkill.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    5 ++---
 drivers/ata/libata-sff.c  |    6 ++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -5606,9 +5606,8 @@ int ata_device_add(const struct ata_prob
 				ap->ioaddr.bmdma_addr,
 				irq_line);
 
-		ata_chk_status(ap);
-		host->ops->irq_clear(ap);
-		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
+		/* freeze port before requesting IRQ */
+		ata_eh_freeze_port(ap);
 	}
 
 	/* obtain irq, that may be shared between channels */
Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -700,6 +700,12 @@ void ata_bmdma_freeze(struct ata_port *a
 		writeb(ap->ctl, (void __iomem *)ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
+
+	/* Many controllers fail to clear pending IRQ on ATA_NIEN
+	 * assertion.  Clear it.
+	 */
+	ata_chk_status(ap);
+	ap->ops->irq_clear(ap);
 }
 
 /**
