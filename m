From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/13] libata-hp: add more SERR_* constants in preparation for hotplug support
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <11447643811115-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:36020 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750823AbWDKOGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:23 -0400
Received: by wproxy.gmail.com with SMTP id i11so930347wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:22 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add PHY status related SERR_* constants in preparation for hotplug
support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/ata.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

55f539ff11bacd214ae47e1f0e7ea8d57869dc76
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 0509340..9c18526 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -208,6 +208,8 @@ enum {
 	SERR_PERSISTENT		= (1 << 9), /* persistent data/comm error */
 	SERR_PROTOCOL		= (1 << 10), /* protocol violation */
 	SERR_INTERNAL		= (1 << 11), /* host internal error */
+	SERR_PHYRDY_CHG		= (1 << 16), /* PHY RDY changed */
+	SERR_DEV_XCHG		= (1 << 26), /* device exchanged */
 
 	/* struct ata_taskfile flags */
 	ATA_TFLAG_LBA48		= (1 << 0), /* enable 48-bit LBA and "HOB" */
-- 
1.2.4


