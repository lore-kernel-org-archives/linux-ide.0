From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] (resend) 2.6.x libata fix
Date: Wed, 27 Oct 2004 02:26:05 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041027062605.GA15330@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:45530 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262306AbUJ0G2F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Oct 2004 02:28:05 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org


Re-sending mainly because I accidentally blew away the upstream tree.

Anyone who keeps a local clone of the libata-2.6 queue, please erase and
re-clone.  Thanks.



Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/libata-scsi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/10/26 1.2067.4.2)
   [libata] use kunmap_atomic() correctly

diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-27 02:24:55 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-27 02:24:55 -04:00
@@ -742,13 +742,13 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd)
+static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf)
 {
 	if (cmd->use_sg) {
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		kunmap_atomic(sg->page, KM_USER0);
+		kunmap_atomic(buf - sg->offset, KM_USER0);
 	}
 }
 
@@ -778,7 +778,7 @@
 	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
 	memset(rbuf, 0, buflen);
 	rc = actor(args, rbuf, buflen);
-	ata_scsi_rbuf_put(cmd);
+	ata_scsi_rbuf_put(cmd, rbuf);
 
 	if (rc)
 		ata_bad_cdb(cmd, args->done);
@@ -1264,7 +1264,7 @@
 			buflen = ata_scsi_rbuf_get(cmd, &buf);
 			buf[2] = 0x5;
 			buf[3] = (buf[3] & 0xf0) | 2;
-			ata_scsi_rbuf_put(cmd);
+			ata_scsi_rbuf_put(cmd, buf);
 		}
 		cmd->result = SAM_STAT_GOOD;
 	}
