From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix ata_irq_on()
Date: Mon, 9 Oct 2006 11:20:27 +0900
Message-ID: <20061009022027.GB10832@htj.dyndns.org>
References: <20061009021026.GA10832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:50141 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751623AbWJICUi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 22:20:38 -0400
Received: by py-out-1112.google.com with SMTP id n25so2127826pyg
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 19:20:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20061009021026.GA10832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

* IRQ must be cleared *before* unmasking not after.

* ata_wait_idle() causes spurious 1sec wait and there is no reason to
  wait for !DRQ.  DRQ waiting causes unnecessary delay on empty port
  which reports funky status like 0x7f.  !BSY waiting seems superflous
  too.  No caller depends on ata_irq_on() to wait for idle state.
  The port is either already idle on entry or the caller waits for
  idle status afterwards.  Wait only for !BSY without whining on
  failure.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Jeff, this fixes 'abnormal status 0xXX' messages for empty ports.  The
message was triggerd from ata_bmdma_thaw().  Unlike old EH, new EH
thaws empty ports (mainly for hotplugging) and controllers which
reports set DRQ on empty ports triggers the message.  I think this
update should be included in #uptream-fixes too.  People are getting
annoyed by the message.

Thanks.

 drivers/ata/libata-sff.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -51,7 +51,8 @@
 u8 ata_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
+
+	ap->ops->irq_clear(ap);
 
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
@@ -60,11 +61,8 @@ u8 ata_irq_on(struct ata_port *ap)
 		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
-	tmp = ata_wait_idle(ap);
-
-	ap->ops->irq_clear(ap);
 
-	return tmp;
+	return ata_busy_wait(ap, ATA_BUSY, 1000);
 }
 
 /**
