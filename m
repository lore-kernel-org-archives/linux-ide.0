From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/63] ide-cd: remove unused struct atapi_cdrom_subchnl
Date: Thu, 20 Dec 2007 02:06:39 +0100
Message-ID: <200712200206.39408.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:12147 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758205AbXLTBeU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389253ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.h |   32 --------------------------------
 1 file changed, 32 deletions(-)

Index: b/drivers/ide/ide-cd.h
===================================================================
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -145,38 +145,6 @@ struct atapi_toc {
 	  /* One extra for the leadout. */
 };
 
-
-/* This structure is annoyingly close to, but not identical with,
-   the cdrom_subchnl structure from cdrom.h. */
-struct atapi_cdrom_subchnl {
- 	u_char  acdsc_reserved;
- 	u_char  acdsc_audiostatus;
- 	u_short acdsc_length;
-	u_char  acdsc_format;
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	u_char  acdsc_ctrl:     4;
-	u_char  acdsc_adr:      4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	u_char  acdsc_adr:	4;
-	u_char  acdsc_ctrl:	4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	u_char  acdsc_trk;
-	u_char  acdsc_ind;
-	union {
-		struct atapi_msf msf;
-		int	lba;
-	} acdsc_absaddr;
-	union {
-		struct atapi_msf msf;
-		int	lba;
-	} acdsc_reladdr;
-};
-
-
-
 /* This should probably go into cdrom.h along with the other
  * generic stuff now in the Mt. Fuji spec.
  */
