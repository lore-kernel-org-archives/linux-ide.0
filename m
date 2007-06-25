From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc5] libata: fix ata_dev_disable()
Date: Mon, 25 Jun 2007 23:34:02 +0900
Message-ID: <467FD25A.2040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:43259 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbXFYOeK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 10:34:10 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1375492nzf
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 07:34:07 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Fix silly condition check bug in ata_dev_disable().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index adfae9d..09ade2a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -600,8 +600,9 @@ static const char *sata_spd_string(unsigned int spd)
 
 void ata_dev_disable(struct ata_device *dev)
 {
-	if (ata_dev_enabled(dev) && ata_msg_drv(dev->ap)) {
-		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
+	if (ata_dev_enabled(dev)) {
+		if (ata_msg_drv(dev->ap))
+			ata_dev_printk(dev, KERN_WARNING, "disabled\n");
 		ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 |
 					     ATA_DNXFER_QUIET);
 		dev->class++;
