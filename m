From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: add ATA_HORKAGE_MAX_SEC_1024 to revert back to
 previous max_sectors limit
Date: Wed, 15 Jul 2015 11:44:20 -0400
Message-ID: <20150715154420.GC15934@mtj.duckdns.org>
References: <1436806103-16503-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35816 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbGOPoX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2015 11:44:23 -0400
Received: by ykdu72 with SMTP id u72so39741842ykd.2
        for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2015 08:44:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436806103-16503-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

Hello,

Applied with comment updates.  I don't think it's a good idea to refer
to BLK_DEF_MAX_SECTORS which doesn't exist in the tree.

Thanks!

----- 8< ------
>From b92168d52df86a389bd3f3435ea51ca2288d2a96 Mon Sep 17 00:00:00 2001
From: David Milburn <dmilburn@redhat.com>
Date: Mon, 13 Jul 2015 11:48:23 -0500
Subject: [PATCH] libata: add ATA_HORKAGE_MAX_SEC_1024 to revert back to
 previous max_sectors limit

Since no longer limiting max_sectors to BLK_DEF_MAX_SECTORS (commit 34b48db66e08),
data corruption may occur on ST380013AS drive configured on 82801JI (ICH10 Family)
SATA controller. This patch will allow the driver to limit max_sectors as before

# cat /sys/block/sdb/queue/max_sectors_kb
512

I was able to double the max_sectors_kb value up to 16384 on linux-4.2.0-rc2
before seeing corruption, but seems safer to use previous limit. Without this
patch max_sectors_kb will be 32767.

tj: Minor comment update.

Reported-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c | 10 ++++++++++
 include/linux/ata.h       |  1 +
 include/linux/libata.h    |  2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ed2b218..68202a8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2478,6 +2478,10 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
 					 dev->max_sectors);
 
+	if (dev->horkage & ATA_HORKAGE_MAX_SEC_1024)
+		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_1024,
+					 dev->max_sectors);
+
 	if (dev->horkage & ATA_HORKAGE_MAX_SEC_LBA48)
 		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
 
@@ -4146,6 +4150,12 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Slimtype DVD A  DS8A8SH", NULL,	ATA_HORKAGE_MAX_SEC_LBA48 },
 	{ "Slimtype DVD A  DS8A9SH", NULL,	ATA_HORKAGE_MAX_SEC_LBA48 },
 
+	/*
+	 * Causes silent data corruption with higher max sects.
+	 * http://lkml.kernel.org/g/x49wpy40ysk.fsf@segfault.boston.devel.redhat.com
+	 */
+	{ "ST380013AS",		"3.20",		ATA_HORKAGE_MAX_SEC_1024 },
+
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
diff --git a/include/linux/ata.h b/include/linux/ata.h
index fed3641..6c78956 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -45,6 +45,7 @@ enum {
 	ATA_SECT_SIZE		= 512,
 	ATA_MAX_SECTORS_128	= 128,
 	ATA_MAX_SECTORS		= 256,
+	ATA_MAX_SECTORS_1024    = 1024,
 	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
 	ATA_MAX_SECTORS_TAPE	= 65535,
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5c8bac6..c9cfbcd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -432,7 +432,7 @@ enum {
 	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
 	ATA_HORKAGE_NO_NCQ_LOG	= (1 << 23),	/* don't use NCQ for log read */
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
-
+	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
2.4.3

