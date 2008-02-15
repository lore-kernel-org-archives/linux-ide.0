From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 5/11v2] ata: replace macro with static inline in libata.h
Date: Fri, 15 Feb 2008 14:06:55 -0800
Message-ID: <1203113215.15275.53.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:6970 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbYBOWG4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 17:06:56 -0500
Received: by rv-out-0910.google.com with SMTP id k20so605229rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 14:06:56 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>

Move to using a static inline which will force the same typechecking
that min_t/max_t do (in this case, short).  As a bonus, avoid a ton
of sparse warnings like:

drivers/ata/pata_ali.c:176:14: warning: symbol '__x' shadows an earlier one
drivers/ata/pata_ali.c:176:14: originally declared here

Due to nesting min_t macro inside max_t macro which both use a __x
identifier internally.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/linux/libata.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index bc5a8d0..b5590fb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -764,7 +764,14 @@ struct ata_timing {
 	unsigned short udma;		/* t2CYCTYP/2 */
 };
 
-#define FIT(v, vmin, vmax)	max_t(short, min_t(short, v, vmax), vmin)
+static inline short FIT(short v, short vmin, short vmax)
+{
+	if (v >= vmax)
+		return vmax;
+	if (v <= vmin)
+		return vmin;
+	return v;
+}
 
 extern const unsigned long sata_deb_timing_normal[];
 extern const unsigned long sata_deb_timing_hotplug[];
-- 
1.5.4.1.1278.gc75be



