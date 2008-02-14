From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 1/3] ata: make ata_scsiop_inq_89 static in libata-scsi.c
Date: Thu, 14 Feb 2008 10:45:20 -0800
Message-ID: <1203014720.2748.63.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:27142 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbYBNSpY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 13:45:24 -0500
Received: by wr-out-0506.google.com with SMTP id c48so764790wra.23
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 10:45:23 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c02c490..1cea18f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1862,7 +1862,7 @@ unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf,
  *	spin_lock_irqsave(host lock)
  */
 
-unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf,
+static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf,
 			      unsigned int buflen)
 {
 	u8 pbuf[60];
-- 
1.5.4.1.1278.gc75be


