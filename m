From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2 #upstream,REGENERATED] libata: assume ATA_DEV_ATA on diagnostic failure
Date: Sun, 2 Sep 2007 23:24:48 +0900
Message-ID: <20070902142448.GB21527@htj.dyndns.org>
References: <20070808053739.GS13674@htj.dyndns.org> <46D7DCE5.8090700@garzik.org> <20070902142357.GA21527@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:48388 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935AbXIBOY6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 10:24:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so746840rvb
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 07:24:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070902142357.GA21527@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, amsden_linux@earthlink.net

Certain device which reports diagnostic failure also reports invalid
device signature.  Assume ATA_DEV_ATA on diagnostic failure if reset
indicates device presence.

This is fix for bugzilla bug 8784.

  http://bugzilla.kernel.org/show_bug.cgi?id=8784

Signed-off-by: Tejun Heo <htejun@gmail.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Edward Amsden <amsden_linux@earthlink.net>
---
 drivers/ata/libata-core.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -751,10 +751,20 @@ unsigned int ata_dev_try_classify(struct
 	/* determine if device is ATA or ATAPI */
 	class = ata_dev_classify(&tf);
 
-	if (class == ATA_DEV_UNKNOWN)
-		return ATA_DEV_NONE;
-	if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
-		return ATA_DEV_NONE;
+	if (class == ATA_DEV_UNKNOWN) {
+		/* If the device failed diagnostic, it's likely to
+		 * have reported incorrect device signature too.
+		 * Assume ATA device if the device seems present but
+		 * device signature is invalid with diagnostic
+		 * failure.
+		 */
+		if (present && (dev->horkage & ATA_HORKAGE_DIAGNOSTIC))
+			class = ATA_DEV_ATA;
+		else
+			class = ATA_DEV_NONE;
+	} else if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
+		class = ATA_DEV_NONE;
+
 	return class;
 }
 
