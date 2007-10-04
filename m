From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add ST9160821AS / 3.ALD to NCQ blacklist
Date: Fri, 5 Oct 2007 08:54:39 +0900
Message-ID: <20071004235439.GC12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:60758 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbXJDXyq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 19:54:46 -0400
Received: by nz-out-0506.google.com with SMTP id s18so317439nze
        for <linux-ide@vger.kernel.org>; Thu, 04 Oct 2007 16:54:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

ST9160821AS / 3.ALD also does spurious NCQ completions.  Disable NCQ.

Signed-off-by: Tejun Heo <teheo@suse.de>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index aecbdad..7155a41 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3973,6 +3973,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
 	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
+	{ "ST9160821AS",	"3.ALD",	ATA_HORKAGE_NONCQ, },
 	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
 	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
