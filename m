From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: lengthen interval between SRST set and clear
Date: Thu, 28 Sep 2006 14:14:15 +0900
Message-ID: <20060928051415.GG25800@htj.dyndns.org>
References: <20060927082005.GA14569@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:42031 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751615AbWI1FOY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 01:14:24 -0400
Received: by nf-out-0910.google.com with SMTP id o25so645338nfa
        for <linux-ide@vger.kernel.org>; Wed, 27 Sep 2006 22:14:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060927082005.GA14569@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>, mail@philipp-wagner.com
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

20us isn't enough for some SATA controllers (sata_nv) ending up not
sending the second FIS27 to clear SRST.  This usually results in SRST
timeout causing excessive delays during hotplug.

This patch lengthens the delay from 20us to 1ms and also converts it
to msleep() instead of busy wait.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Hello, Jim Paris, Philipp Wagner.

Can you guys please give this patch a shot?  This patch is againt
libata-dev#upstream so if you're using 2.6.18, the patched file
(libata-core.c) wouldn't be there.  If that's the case, just edit
drivers/scsi/libata-core.c accordng to the following patch (replace
udelay(20)s in ata_bus_softreset() w/ msleep(1)).

Jeff, this function is called from both old EH and new EH's
ata_std_softreset().  I think this change is safe but curious about
your opinion.

Thanks.

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
 
