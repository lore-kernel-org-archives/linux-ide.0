From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/27] libata: drop ata_dev_select() from ata_dev_read_id
Date: Tue, 25 Mar 2008 22:16:39 +0900
Message-ID: <12064510253869-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:15483 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbYCYNR1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:27 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3539072wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:26 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

There is no reason to issue device select in read_id, it will be done
by ops->qc_issue() when IDENTIFY[_PACKET] is issued via
ata_exec_internal().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f389ae9..d7e7ac6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2118,7 +2118,6 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	if (ata_msg_ctl(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER\n", __func__);
 
-	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
  retry:
 	ata_tf_init(dev, &tf);
 
-- 
1.5.2.4

