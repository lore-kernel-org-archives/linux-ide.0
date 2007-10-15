From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata build fix
Date: Mon, 15 Oct 2007 18:13:29 -0400
Message-ID: <20071015221329.GA8778@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:38055 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbXJOWNa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 18:13:30 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


And it becomes obvious I normally do my building and testing on x86-64...

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/pata_cs5536.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

Jeff Garzik (1):
      [libata] pata_cs5536: new API build fix

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 21405bf..53070f6 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -239,7 +239,6 @@ static struct scsi_host_template cs5536_sht = {
 };
 
 static struct ata_port_operations cs5536_port_ops = {
-	.port_disable		= ata_port_disable,
 	.set_piomode		= cs5536_set_piomode,
 	.set_dmamode		= cs5536_set_dmamode,
 	.mode_filter		= ata_pci_default_filter,
@@ -269,7 +268,6 @@ static struct ata_port_operations cs5536_port_ops = {
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
-	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
