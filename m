From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/2] ATA: sata_promise, do not freeze ports
Date: Sat,  5 May 2007 16:50:05 +0200 (CEST)
Message-ID: <248077021012417739@wsc.cz>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cacti.profiwh.com ([85.93.165.66]:42079 "EHLO smtp.wsc.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933975AbXEEQy1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 May 2007 12:54:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

If no objections, here comes the revert of the return 1 issue.

--

sata_promise, do not freeze ports

revert return 1 thing in the error isr, that causes port freezing, so that the
system is unusable when exception is thrown.

See http://lkml.org/lkml/2007/4/30/268

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit a38d21f4b5d5029b0b083fe2651e78c7657fda3b
tree 0a2019a34227906bc5fb0e60d90cc7f4759ee934
parent b5c1fc64195b18d3919bfa7dddfb76e9f2a05786
author Jiri Slaby <jirislaby@gmail.com> Sat, 05 May 2007 16:43:22 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sat, 05 May 2007 16:43:22 +0200

 drivers/ata/sata_promise.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index f56549b..a0024ae 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -668,10 +668,8 @@ static inline unsigned int pdc_host_intr( struct ata_port *ap,
 	else
 		err_mask &= ~PDC2_ERR_MASK;
 	port_status = readl(port_mmio + PDC_GLOBAL_CTL);
-	if (unlikely(port_status & err_mask)) {
+	if (unlikely(port_status & err_mask))
 		pdc_error_intr(ap, qc, port_status, err_mask);
-		return 1;
-	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
