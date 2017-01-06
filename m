From: Tejun Heo <tj@kernel.org>
Subject: [PATCH for-4.10-fixes] libata: apply MAX_SEC_1024 to all CX1-JB*-HP
 devices
Date: Fri, 6 Jan 2017 11:48:50 -0500
Message-ID: <20170106164850.GC16083@mtj.duckdns.org>
References: <e0d6b4dc-9f3f-f97b-4bc1-5b1bb746a801@koski-vahala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35566 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967698AbdAFQsx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2017 11:48:53 -0500
Received: by mail-qk0-f196.google.com with SMTP id u25so62759921qki.2
        for <linux-ide@vger.kernel.org>; Fri, 06 Jan 2017 08:48:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e0d6b4dc-9f3f-f97b-4bc1-5b1bb746a801@koski-vahala.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marko =?iso-8859-1?B?S29za2ktVuRo5Gzk?= <marko@koski-vahala.com>
Cc: linux-ide@vger.kernel.org

Marko reports that CX1-JB512-HP shows the same timeout issues as
CX1-JB256-HP.  Let's apply MAX_SEC_128 to all devices in the series.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Marko Koski-Vähälä <marko@koski-vahala.com>
Cc: stable@vger.kernel.org # v3.19+
---
Applying to libata/for-4.10-fixes.

Thanks.

 drivers/ata/libata-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc70b5f..f70eb6b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4356,10 +4356,10 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "ST380013AS",		"3.20",		ATA_HORKAGE_MAX_SEC_1024 },
 
 	/*
-	 * Device times out with higher max sects.
+	 * These devices time out with higher max sects.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=121671
 	 */
-	{ "LITEON CX1-JB256-HP", NULL,		ATA_HORKAGE_MAX_SEC_1024 },
+	{ "LITEON CX1-JB*-HP",	NULL,		ATA_HORKAGE_MAX_SEC_1024 },
 
 	/* Devices we expect to fail diagnostics */
 
