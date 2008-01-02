From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] pata_pcmcia: convert to new data_xfer prototype
Date: Wed, 02 Jan 2008 22:51:13 +0900
Message-ID: <477B96D1.2010003@gmail.com>
References: <11992723701811-git-send-email-htejun@gmail.com> <11992723713373-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:42658 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYABNvU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 08:51:20 -0500
Received: by wa-out-1112.google.com with SMTP id v27so9097526wah.23
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 05:51:20 -0800 (PST)
In-Reply-To: <11992723713373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

While merging data_xfer prototype change, pata_pcmcia was left out.
Convert it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Subject updated.

 drivers/ata/pata_pcmcia.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index ceba93b..3e7f6a9 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -102,10 +102,10 @@ static int pcmcia_set_mode_8bit(struct ata_link *link,
 
 /**
  *	ata_data_xfer_8bit	 -	Transfer data by 8bit PIO
- *	@adev: device to target
+ *	@dev: device to target
  *	@buf: data buffer
  *	@buflen: buffer length
- *	@write_data: read/write
+ *	@rw: read/write
  *
  *	Transfer data from/to the device data register by 8 bit PIO.
  *
@@ -113,14 +113,17 @@ static int pcmcia_set_mode_8bit(struct ata_link *link,
  *	Inherited from caller.
  */
 
-static void ata_data_xfer_8bit(struct ata_device *adev, unsigned char *buf,
-		   unsigned int buflen, int write_data)
+static unsigned int ata_data_xfer_8bit(struct ata_device *dev,
+				unsigned char *buf, unsigned int buflen, int rw)
 {
-	struct ata_port *ap = adev->link->ap;
-	if (write_data)
-		iowrite8_rep(ap->ioaddr.data_addr, buf, buflen);
-	else
+	struct ata_port *ap = dev->link->ap;
+
+	if (rw == READ)
 		ioread8_rep(ap->ioaddr.data_addr, buf, buflen);
+	else
+		iowrite8_rep(ap->ioaddr.data_addr, buf, buflen);
+
+	return buflen;
 }
 
 
--
1.5.2.4
