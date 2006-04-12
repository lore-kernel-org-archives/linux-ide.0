From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata fix
Date: Wed, 12 Apr 2006 18:15:00 -0400
Message-ID: <20060412221500.GA20915@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:42418 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932351AbWDLWPB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 18:15:01 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/sata_mv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Dan Aloni:
      sata_mv: properly print HC registers

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index b64b077..d5fdcb9 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -747,7 +747,7 @@ static void mv_dump_all_regs(void __iome
 	mv_dump_mem(mmio_base+0xf00, 0x4);
 	mv_dump_mem(mmio_base+0x1d00, 0x6c);
 	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
-		hc_base = mv_hc_base(mmio_base, port >> MV_PORT_HC_SHIFT);
+		hc_base = mv_hc_base(mmio_base, hc);
 		DPRINTK("HC regs (HC %i):\n", hc);
 		mv_dump_mem(hc_base, 0x1c);
 	}
