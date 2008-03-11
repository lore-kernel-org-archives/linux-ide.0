From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: use atapi_cmd_type() to determine
 cmd type instead of transfer size
Date: Tue, 11 Mar 2008 11:35:00 +0900
Message-ID: <47D5EFD4.2090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:62314 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbYCKCfK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 22:35:10 -0400
Received: by wr-out-0506.google.com with SMTP id 50so1172095wra.13
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 19:35:07 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>

pata_ali and pata_it821x were using qc->nbytes to determine whether a
command is data transfer type or not.  As now qc->nbytes can be
extended by padding and draining buffers, this tests are not useful
anymore.  Use atapi_cmd_type() instead.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/ata/pata_ali.c    |    2 +-
 drivers/ata/pata_it821x.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 7e68edf..8786455 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -295,7 +295,7 @@ static void ali_lock_sectors(struct ata_device *adev)
 static int ali_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	/* If its not a media command, its not worth it */
-	if (qc->nbytes < 2048)
+	if (atapi_cmd_type(qc->cdb[0]) == ATAPI_MISC)
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 109ddd4..f751749 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -564,7 +564,7 @@ static int it821x_check_atapi_dma(struct ata_queued_cmd *qc)
 	struct it821x_dev *itdev = ap->private_data;
 
 	/* Only use dma for transfers to/from the media. */
-	if (qc->nbytes < 2048)
+	if (atapi_cmd_type(qc->cdb[0]) == ATAPI_MISC)
 		return -EOPNOTSUPP;
 
 	/* No ATAPI DMA in smart mode */
