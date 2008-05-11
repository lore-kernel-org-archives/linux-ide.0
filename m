From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata no-works fix (RESEND)
Date: Sun, 11 May 2008 12:43:12 -0400
Message-ID: <20080511164312.GA1924@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:59527 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYEKQnO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 May 2008 12:43:14 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Resent from yesterday. Please apply, a ton of people are broken because of this.


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 include/linux/libata.h |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

Jeff Garzik (1):
      [libata] revert new check-ready Status register logic

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7e206da..0f17643 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1384,17 +1384,14 @@ static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
 
 static inline int ata_check_ready(u8 status)
 {
-	/* Some controllers report 0x77 or 0x7f during intermediate
-	 * not-ready stages.
-	 */
-	if (status == 0x77 || status == 0x7f)
-		return 0;
+	if (!(status & ATA_BUSY))
+		return 1;
 
 	/* 0xff indicates either no device or device not ready */
 	if (status == 0xff)
 		return -ENODEV;
 
-	return !(status & ATA_BUSY);
+	return 0;
 }
 
 
