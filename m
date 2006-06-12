From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix comment above ata_exec_internal()
Date: Mon, 12 Jun 2006 14:09:49 +0900
Message-ID: <20060612050949.GA9166@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:45692 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751338AbWFLFJ4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 01:09:56 -0400
Received: by py-out-1112.google.com with SMTP id x31so1574321pye
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 22:09:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Add RETURNS comment above ata_exec_internal() and kill extra blank
line.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

5be2821da324087a7f3f89ddb79b1391c6d7917d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ddaad1a..014855e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -981,8 +981,10 @@ void ata_qc_complete_internal(struct ata
  *
  *	LOCKING:
  *	None.  Should be called with kernel context, might sleep.
+ *
+ *	RETURNS:
+ *	Zero on success, AC_ERR_* mask on failure
  */
-
 unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
-- 
1.3.2
