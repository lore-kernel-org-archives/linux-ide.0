From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] ahci: add HOST_CAP_NCQ constant
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <11473586832521-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:9231 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751809AbWEKOoy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:54 -0400
Received: by wr-out-0506.google.com with SMTP id i12so381311wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:54 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add HOST_CAP_NCQ.

---

 drivers/scsi/ahci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

e0ec8cbb8c52825db6eb4c838bfc3a69f4f3c8a4
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1177ae5..beb269a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -93,6 +93,7 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
+	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
 
 	/* registers for each SATA port */
-- 
1.2.4


