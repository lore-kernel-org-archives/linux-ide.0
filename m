From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/14] libata: clear only affected flags during ata_dev_configure()
Date: Sat, 1 Apr 2006 19:48:36 +0900
Message-ID: <1143888516769-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:25460 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751350AbWDAKsp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:45 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210250nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:45 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_configure() should not clear dynamic device flags determined
elsewhere.  Only mask out ATA_DFLAG_CFG_MASK before configuring.
Without this patch, ATA_DFLAG_PIO gets turned off during revalidation
making PIO mode unuseable.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b5318e739bed15eb68a16b4d61bcd7d7c21ea8fa
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0df994d..0bc81c3 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1241,7 +1241,7 @@ static int ata_dev_configure(struct ata_
 		       id[84], id[85], id[86], id[87], id[88]);
 
 	/* initialize to-be-configured parameters */
-	dev->flags = 0;
+	dev->flags &= ~ATA_DFLAG_CFG_MASK;
 	dev->max_sectors = 0;
 	dev->cdb_len = 0;
 	dev->n_sectors = 0;
-- 
1.2.4


