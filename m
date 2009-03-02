From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 2/2] libata: don't use on-stack sense buffer
Date: Mon, 02 Mar 2009 18:55:16 +0900
Message-ID: <49ABAD04.90402@kernel.org>
References: <49ABAC96.3060109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60221 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759005AbZCBJzW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Mar 2009 04:55:22 -0500
In-Reply-To: <49ABAC96.3060109@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Chuck Ebbert <cebbert@redhat.com>, Robert Hancock <hancockr@shaw.ca>, FUJITA Tomonori <fujita.tom>

sense_buffer is used as DMA target and shouldn't be allocated on
stack.  Use ap->sector_buf instead.  This problem is spotted by Chuck
Ebbert.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Chuck Ebbert <cebbert@redhat.com>
---
 drivers/ata/libata-eh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ce2ef04..009ccc7 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2901,7 +2901,7 @@ static int atapi_eh_clear_ua(struct ata_device *dev)
 	int i;
 
 	for (i = 0; i < ATA_EH_UA_TRIES; i++) {
-		u8 sense_buffer[SCSI_SENSE_BUFFERSIZE];
+		u8 *sense_buffer = dev->link->ap->sector_buf;
 		u8 sense_key = 0;
 		unsigned int err_mask;
 
