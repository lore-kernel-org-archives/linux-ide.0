From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 05/11v2] ata: replace macro with static inline in libata.h
Date: Thu, 14 Feb 2008 10:11:37 -0800
Message-ID: <1203012697.2748.55.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
	 <1202966058.2748.19.camel@brick>  <20080214120101.150a3284@core>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:38092 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbYBNSLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 13:11:40 -0500
Received: by wx-out-0506.google.com with SMTP id h31so387583wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 10:11:39 -0800 (PST)
In-Reply-To: <20080214120101.150a3284@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Instead of using min/max_t(short... use a static inline to get
typechecking.

As a bonus, avoid a metric ton of sparse warnings like:
drivers/ata/pata_ali.c:176:14: warning: symbol '__x' shadows an earlier one
drivers/ata/pata_ali.c:176:14: originally declared here

Due to nesting min_t macro inside max_t macro which both use a __x
identifier internally.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
Alan, is this more to your liking?

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



