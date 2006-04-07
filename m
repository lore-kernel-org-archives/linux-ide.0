From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/13] sata_sil24: typo fix
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <11443978132691-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:16153 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932371AbWDGIQ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:16:59 -0400
Received: by zproxy.gmail.com with SMTP id v1so337955nzb
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:16:58 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Type fix.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

9afd6d085d6de7b961216befcb0a20e8186ce48e
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


