From: Arne Fitzenreiter <arne_f@ipfire.org>
Subject: [PATCH 2/2] libata: force disable trim for SuperSSpeed S238
Date: Wed, 15 Jul 2015 13:54:37 +0200
Message-ID: <1436961277-4069-3-git-send-email-arne_f@ipfire.org>
References: <1436961277-4069-1-git-send-email-arne_f@ipfire.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail01.ipfire.org ([178.63.73.247]:35112 "EHLO
	mail01.ipfire.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbGOLyr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2015 07:54:47 -0400
In-Reply-To: <1436961277-4069-1-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org, arne_f@ipfire.org

This device loses blocks, often the partition table area, on trim.
Disable TRIM.
http://pcengines.ch/msata16a.htm

Signed-off-by: Arne Fitzenreiter <arne_f@ipfire.org>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e83fc3d..d2d3b21 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4238,6 +4238,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
+	/* devices that don't properly handle TRIM commands */
+	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
+
 	/*
 	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
 	 * (Return Zero After Trim) flags in the ATA Command Set are
-- 
2.4.4

