From: "Gerry Rozema" <gerryr@rozeware.bc.ca>
Subject: [PATCH 2.6.9] libata:  Add another drive to the blacklist for SIL_QUIRK_MOD15WRITE
Date: Sun, 21 Nov 2004 04:35:42 -0800
Message-ID: <IJEHJPPHAHEBOOMNBBIHGECPGKAA.gerryr@rozeware.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.divebc.com ([64.246.48.85]:39887 "EHLO www.ibtalk.net")
	by vger.kernel.org with ESMTP id S261705AbUKUMfp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Nov 2004 07:35:45 -0500
Received: from mail.divebc.com (S01060080c77cb685.vc.shawcable.net [24.85.33.80])
	by www.ibtalk.net (8.11.6/8.11.6) with ESMTP id iALDFiB15981
	for <linux-ide@vger.kernel.org>; Sun, 21 Nov 2004 07:15:44 -0600
Received: from antigua (S01060050bab3486f.vc.shawcable.net [24.85.58.167])
	by mail.divebc.com (Postfix) with SMTP id 2ACAEB34016
	for <linux-ide@vger.kernel.org>; Sun, 21 Nov 2004 04:40:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Add a western digital 200 gig drive to the blacklist for
SIL_QUIRK_MOD15WRITE

I just finished building a raid with 3 new WD drives, and the
Silicon Image 3114 4 port controller.  I had data corruption problems
even before I was finished installing onto the new system.  This patch
corrected that, and it's been running reliably under heavy read/write
load for a few days now.

Signed-off-by:  Gerry Rozema <gerryr@rozeware.bc.ca>

----
diff -Naur a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c

--- a/drivers/scsi/sata_sil.c	2004-11-18 20:08:05.000000000 -0800
+++ b/drivers/scsi/sata_sil.c	2004-11-18 19:47:15.000000000 -0800
@@ -92,6 +92,7 @@
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "WDC WD2000JD-00H",	SIL_QUIRK_MOD15WRITE },
 	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
 	{ }
 };

----


