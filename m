From: Marios Andreopoulos <opensource@andmarios.com>
Subject: [PATCH] libata: disable queued TRIM for Crucial M500 mSATA SSDs
Date: Mon, 03 Mar 2014 18:19:59 +0200
Message-ID: <9306023.Q3rnH2c0bQ@miles>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61108 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbaCCQUM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2014 11:20:12 -0500
Received: by mail-wg0-f46.google.com with SMTP id z12so3507140wgg.5
        for <linux-ide@vger.kernel.org>; Mon, 03 Mar 2014 08:20:11 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

From: Marios Andreopoulos <opensource@andmarios.com>

Queued TRIM commands cause problems and silent file system corruption
on Crucial M500 SSDs. This patch disables them for the mSATA model of
the drive.

Signed-off-by: Marios Andreopoulos <opensource@andmarios.com>
---
More information can be found on this bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=71371

 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff -pruN a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c	2014-03-02 02:04:02.000000000 +0200
+++ b/drivers/ata/libata-core.c	2014-03-03 17:49:14.867332615 +0200
@@ -4225,6 +4225,7 @@ static const struct ata_blacklist_entry
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Crucial_CT???M500SSD1",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
+	{ "Crucial_CT???M500SSD3",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 
 	/*
 	 * Some WD SATA-I drives spin up and down erratically when the link

