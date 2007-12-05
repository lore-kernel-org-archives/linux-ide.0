From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/15] cdrom: add more GPCMD_* constants
Date: Wed,  5 Dec 2007 16:43:04 +0900
Message-ID: <11968405963401-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:33171 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXLEHn7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895624wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:59 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

Add GPCMD_* constants for READ_BUFFER, WRITE_12 and WRITE_BUFFER for
completeness.  These will be used libata.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/cdrom.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index c6d3e22..fcdc11b 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -451,6 +451,7 @@ struct cdrom_generic_command
 #define GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL  0x1e
 #define GPCMD_READ_10			    0x28
 #define GPCMD_READ_12			    0xa8
+#define GPCMD_READ_BUFFER		    0x3c
 #define GPCMD_READ_BUFFER_CAPACITY	    0x5c
 #define GPCMD_READ_CDVD_CAPACITY	    0x25
 #define GPCMD_READ_CD			    0xbe
@@ -480,7 +481,9 @@ struct cdrom_generic_command
 #define GPCMD_TEST_UNIT_READY		    0x00
 #define GPCMD_VERIFY_10			    0x2f
 #define GPCMD_WRITE_10			    0x2a
+#define GPCMD_WRITE_12			    0xaa
 #define GPCMD_WRITE_AND_VERIFY_10	    0x2e
+#define GPCMD_WRITE_BUFFER		    0x3b
 /* This is listed as optional in ATAPI 2.6, but is (curiously) 
  * missing from Mt. Fuji, Table 57.  It _is_ mentioned in Mt. Fuji
  * Table 377 as an MMC command for SCSi devices though...  Most ATAPI
-- 
1.5.2.4

