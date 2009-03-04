From: akpm@linux-foundation.org
Subject: [patch 1/3] libata: change drive ready wait after hard reset to 5s
Date: Wed, 04 Mar 2009 11:59:46 -0800
Message-ID: <200903041959.n24Jxl2X028532@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57660 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757315AbZCDUAy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 15:00:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, stuart_hayes@dell.com

From: Stuart Hayes <stuart_hayes@dell.com>

This fixes problems during resume with drives that take longer than 1s to
be ready.  The ATA-6 spec appears to allow 5 seconds for a drive to be
ready.

On one affected system, this patch changes "PM: resume devices took..."
message from 17 seconds to 4 seconds, and gets rid of a lot of ugly
timeout/error messages.

Without this patch, the libata code moves on after 1s, tries to send a
soft reset (which the drive doesn't see because it isn't ready) which also
times out, then an IDENTIFY command is sent to the drive which times out,
and finally the error handler will try to send another hard reset which
will finally get things working.

Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/libata.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/libata.h~libata-change-drive-ready-wait-after-hard-reset-to-5s include/linux/libata.h
--- a/include/linux/libata.h~libata-change-drive-ready-wait-after-hard-reset-to-5s
+++ a/include/linux/libata.h
@@ -275,7 +275,7 @@ enum {
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 1000,
+	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
_
