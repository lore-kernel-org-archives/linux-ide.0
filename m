From: Arne Fitzenreiter <arne_f@ipfire.org>
Subject: [PATCH 2/2] libata: force disable trim for SuperSSpeed S238
Date: Tue, 14 Jul 2015 13:28:34 +0200
Message-ID: <1436873314-22563-3-git-send-email-arne_f@ipfire.org>
References: <1436873314-22563-1-git-send-email-arne_f@ipfire.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail01.ipfire.org ([178.63.73.247]:56158 "EHLO
	mail01.ipfire.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbbGNLew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 07:34:52 -0400
In-Reply-To: <1436873314-22563-1-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Arne Fitzenreiter <arne_f@ipfire.org>

this disc lose blocks if trim is used. most time the partition
area.
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

