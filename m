From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/14] ahci: add HOST_CAP_NCQ constant
Date: Mon, 3 Apr 2006 17:32:40 +0900
Message-ID: <11440531602451-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:59876 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751662AbWDCIc6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:58 -0400
Received: by wproxy.gmail.com with SMTP id i22so1247733wra
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:58 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add HOST_CAP_NCQ.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

daf357752b747466ef5f6e6ddd1cbfb76049de1c
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index c01e58a..bd4faa1 100644
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


