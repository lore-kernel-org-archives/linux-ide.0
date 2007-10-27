From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] unexport ide_fix_driveid
Date: Sat, 27 Oct 2007 16:18:33 +0200
Message-ID: <20071027141833.GT30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56331 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750702AbXJ0OSN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 10:18:13 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

ide_fix_driveid can now be unexported.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
627c730e21e5010a5bdb1f4f9968cfd5e0b4df2a 
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 9516883..d3c5672 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -403,9 +403,6 @@ void ide_fix_driveid (struct hd_driveid *id)
 #endif
 }
 
-/* FIXME: exported for use by the USB storage (isd200.c) code only */
-EXPORT_SYMBOL(ide_fix_driveid);
-
 void ide_fixstring (u8 *s, const int bytecount, const int byteswap)
 {
 	u8 *p = s, *end = &s[bytecount & ~1]; /* bytecount must be even */

