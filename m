From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 2/2] libata: disable preemption during PIO copy
Date: Sun, 21 Mar 2010 22:53:08 +0100
Message-ID: <20100321215308.GB27709@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:34736 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753308Ab0CUVxJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2010 17:53:09 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

If the request has been made in user context it could be moved to a
different CPU on a SMP machine between the copy and cache flush. Thus we
could flush the dcache on the wrong CPU.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 drivers/ata/libata-sff.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 83ecf48..dca9f90 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -874,6 +874,9 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
+#ifdef CONFIG_SMP
+	preempt_disable();
+#endif
 	if (PageHighMem(page)) {
 		unsigned long flags;
 
@@ -896,6 +899,9 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	if (!do_write && !PageSlab(page))
 		flush_dcache_page(page);
 
+#ifdef CONFIG_SMP
+	preempt_enable();
+#endif
 	qc->curbytes += qc->sect_size;
 	qc->cursg_ofs += qc->sect_size;
 
-- 
1.6.6

