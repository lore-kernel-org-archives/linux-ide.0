From: Terry Suereth <terry.suereth@gmail.com>
Subject: [PATCH] libata: apply behavioral quirks to sil3826 PMP
Date: Mon, 14 Jan 2013 13:01:32 -0800
Message-ID: <CANQSiW0zKNcg5tgmR=3_X5rJSDu0gr=qNS3=2naannGxgn52fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:39914 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459Ab3ANVBd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2013 16:01:33 -0500
Received: by mail-qc0-f179.google.com with SMTP id b14so2776577qcs.38
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2013 13:01:32 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Fixing support for the Silicon Image 3826 port multiplier, by applying to it
the same quirks applied to the Silicon Image 3726.  Specifically fixes the
repeated timeout/reset process which previously afflicted the 3726, as
described from line 290.  Slightly based on notes from:

https://bugzilla.redhat.com/show_bug.cgi?id=890237

Signed-off-by: Terry Suereth <terry.suereth@gmail.com>
---
diff -up drivers/ata/libata-pmp.c.old drivers/ata/libata-pmp.c
--- drivers/ata/libata-pmp.c.old	2013-01-13 13:42:56.582780772 -0800
+++ drivers/ata/libata-pmp.c	2013-01-13 13:43:33.670964680 -0800
@@ -289,24 +289,24 @@ static int sata_pmp_configure(struct ata

 	/* Disable sending Early R_OK.
 	 * With "cached read" HDD testing and multiple ports busy on a SATA
-	 * host controller, 3726 PMP will very rarely drop a deferred
+	 * host controller, 3x26 PMP will very rarely drop a deferred
 	 * R_OK that was intended for the host. Symptom will be all
 	 * 5 drives under test will timeout, get reset, and recover.
 	 */
-	if (vendor == 0x1095 && devid == 0x3726) {
+	if (vendor == 0x1095 && (devid == 0x3726 || devid == 0x3826)) {
 		u32 reg;

 		err_mask = sata_pmp_read(&ap->link, PMP_GSCR_SII_POL, &reg);
 		if (err_mask) {
 			rc = -EIO;
-			reason = "failed to read Sil3726 Private Register";
+			reason = "failed to read Sil3x26 Private Register";
 			goto fail;
 		}
 		reg &= ~0x1;
 		err_mask = sata_pmp_write(&ap->link, PMP_GSCR_SII_POL, reg);
 		if (err_mask) {
 			rc = -EIO;
-			reason = "failed to write Sil3726 Private Register";
+			reason = "failed to write Sil3x26 Private Register";
 			goto fail;
 		}
 	}
@@ -383,8 +383,8 @@ static void sata_pmp_quirks(struct ata_p
 	u16 devid = sata_pmp_gscr_devid(gscr);
 	struct ata_link *link;

-	if (vendor == 0x1095 && devid == 0x3726) {
-		/* sil3726 quirks */
+	if (vendor == 0x1095 && (devid == 0x3x26 || devid == 0x3826)) {
+		/* sil3x26 quirks */
 		ata_for_each_link(link, ap, EDGE) {
 			/* link reports offline after LPM */
 			link->flags |= ATA_LFLAG_NO_LPM;
