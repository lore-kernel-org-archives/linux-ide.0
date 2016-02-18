From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-4.6] libata: fix unbalanced
 spin_lock_irqsave/spin_unlock_irq() in ata_scsi_park_show()
Date: Thu, 18 Feb 2016 11:54:18 -0500
Message-ID: <20160218165418.GE13177@mtj.duckdns.org>
References: <20160217192435.GA14960@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36506 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946282AbcBRQyU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Feb 2016 11:54:20 -0500
Received: by mail-yw0-f182.google.com with SMTP id e63so45182025ywc.3
        for <linux-ide@vger.kernel.org>; Thu, 18 Feb 2016 08:54:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160217192435.GA14960@mwanda>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: eo@nebensachen.de, linux-ide@vger.kernel.org

>From 3948b6f2b7677165324afe52c3bd0088ca7c776c Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 18 Feb 2016 11:50:37 -0500

ata_scsi_park_show() was pairing spin_lock_irqsave() with
spin_unlock_irq().  As the function is always called with irq enabled,
it didn't actually break anything.  Use spin_lock_irq() instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Elias Oltmanns <eo@nebensachen.de>
---
Applied to libata/for-4.6.

Thanks.

 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e417e1a..567859c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -174,13 +174,13 @@ static ssize_t ata_scsi_park_show(struct device *device,
 	struct ata_port *ap;
 	struct ata_link *link;
 	struct ata_device *dev;
-	unsigned long flags, now;
+	unsigned long now;
 	unsigned int uninitialized_var(msecs);
 	int rc = 0;
 
 	ap = ata_shost_to_port(sdev->host);
 
-	spin_lock_irqsave(ap->lock, flags);
+	spin_lock_irq(ap->lock);
 	dev = ata_scsi_find_dev(ap, sdev);
 	if (!dev) {
 		rc = -ENODEV;
-- 
2.5.0

i
