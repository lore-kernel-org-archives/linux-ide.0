From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH 2/4] docbook: fix libata content
Date: Mon, 15 Oct 2007 17:29:46 -0700
Message-ID: <20071015172946.ff34b548.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755602AbXJPAaj@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, jgarzik <jgarzik@pobox.com>
Cc: torvalds <torvalds@linux-foundation.org>, akpm <akpm@linux-foundation.org>, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix libata docbook warnings.

Warning(linux-2.6.23-git8//drivers/ata/libata-scsi.c:3251): No description found for parameter 'dev'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.23-git8.orig/drivers/ata/libata-scsi.c
+++ linux-2.6.23-git8/drivers/ata/libata-scsi.c
@@ -3239,7 +3239,7 @@ static void ata_scsi_handle_link_detach(
 
 /**
  *	ata_scsi_media_change_notify - send media change event
- *	@atadev: Pointer to the disk device with media change event
+ *	@dev: Pointer to the disk device with media change event
  *
  *	Tell the block layer to send a media change notification
  *	event.
