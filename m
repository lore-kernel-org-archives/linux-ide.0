From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/13] sata_sil24: typo fix
Date: Tue, 11 Apr 2006 22:32:18 +0900
Message-ID: <11447623382642-git-send-email-htejun@gmail.com>
References: <11447623382439-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.232]:6282 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750830AbWDKNcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:32:20 -0400
Received: by wproxy.gmail.com with SMTP id i11so923315wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:32:20 -0700 (PDT)
In-Reply-To: <11447623382439-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Type fix.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

806b9b1ee825c73a863bff9b0663346b790b1d89
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index edb62c3..76b6ffc 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -174,7 +174,7 @@ enum {
 	PORT_CERR_CMD_PCIPERR	= 27, /* ctrl[15:13] 110 - PCI parity err while fetching PRB */
 	PORT_CERR_XFR_UNDEF	= 32, /* PSD ecode 00 - undefined */
 	PORT_CERR_XFR_TGTABRT	= 33, /* PSD ecode 01 - target abort */
-	PORT_CERR_XFR_MSGABRT	= 34, /* PSD ecode 10 - master abort */
+	PORT_CERR_XFR_MSTABRT	= 34, /* PSD ecode 10 - master abort */
 	PORT_CERR_XFR_PCIPERR	= 35, /* PSD ecode 11 - PCI prity err during transfer */
 	PORT_CERR_SENDSERVICE	= 36, /* FIS received while sending service */
 
-- 
1.2.4


