From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata-sff: Don't scan disabled ports when checking
 for legacy mode.
Date: Mon, 23 Jan 2017 14:41:14 -0500
Message-ID: <20170123194114.GC7820@htj.duckdns.org>
References: <4978ca2860b.2931a5b8@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36433 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAWTlS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2017 14:41:18 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so14455971pgf.3
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2017 11:41:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4978ca2860b.2931a5b8@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: linux-ide@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hello,

I did some minor edits and applied the following to libata/for-4.11.
When you're attaching the patch next time, please attach the whole
output of git-format-patch; otherwise, I have to stitch them back
together.

Thanks.
------ 8< ------
>From 589d572671fe7ca342d25cde07a0e310a6912971 Mon Sep 17 00:00:00 2001
From: Darren Stevens <darren@stevens-zone.net>
Date: Mon, 23 Jan 2017 14:33:36 -0500
Subject: [PATCH] libata-sff: Don't scan disabled ports when checking for
 legacy mode.

libata-sff.c checks for legacy mode by testing if both primary and
secondary ports on a controller are in legacy mode and selects legacy
if either one is. However on some south bridge chips (e.g AMD
SB600/SB700) the secondary port is not wired, and when it is disabled
by setting the disable bit in the PCI header it appears as a fixed
legacy port.

Prevent incorrect detection by not testing ports that are marked as
'dummy'

tj: Addressed Sergei's review points.  Other style edits.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
 drivers/ata/libata-sff.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4441b5c..2bd92dc 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2428,11 +2428,21 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		return rc;
 
 	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
-		u8 tmp8, mask;
+		u8 tmp8, mask = 0;
 
-		/* TODO: What if one channel is in native mode ... */
+		/*
+		 * ATA spec says we should use legacy mode when one
+		 * port is in legacy mode, but disabled ports on some
+		 * PCI hosts appear as fixed legacy ports, e.g SB600/700
+		 * on which the secondary port is not wired, so
+		 * ignore ports that are marked as 'dummy' during
+		 * this check
+		 */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-		mask = (1 << 2) | (1 << 0);
+		if (!ata_port_is_dummy(host->ports[0]))
+			mask |= (1 << 0);
+		if (!ata_port_is_dummy(host->ports[1]))
+			mask |= (1 << 2);
 		if ((tmp8 & mask) != mask)
 			legacy_mode = 1;
 	}
-- 
2.9.3

