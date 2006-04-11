From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/15] ahci: add HOST_CAP_NCQ constant
Date: Tue, 11 Apr 2006 22:53:37 +0900
Message-ID: <11447636174116-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.234]:56740 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750987AbWDKNxp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:45 -0400
Received: by wproxy.gmail.com with SMTP id i11so927605wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:44 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add HOST_CAP_NCQ.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

868de01742b3cf25a5b053269737196690a75e53
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 405d4da..375857b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -92,6 +92,7 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
+	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
 
 	/* registers for each SATA port */
-- 
1.2.4


