From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] ata: fix sparse warning in libata.h
Date: Fri, 15 Feb 2008 13:41:32 -0800
Message-ID: <1203111692.15275.50.camel@brick>
References: <1203016578.2748.69.camel@brick>
	 <20080215223250.0f229dbe@weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:32078 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbYBOVle (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 16:41:34 -0500
Received: by py-out-1112.google.com with SMTP id u52so1032885pyb.10
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 13:41:34 -0800 (PST)
In-Reply-To: <20080215223250.0f229dbe@weinigel.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Avoids lots of these, also is more readable.
include/linux/libata.h:1210:13: warning: potentially expensive pointer subtraction

Change the subtraction to addition on the other side of the comparison.

Thanks to Christer Weinigel for the suggestion.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/linux/libata.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index bc5a8d0..a6243bb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1207,7 +1207,7 @@ static inline struct ata_link *ata_port_next_link(struct ata_link *link)
 		return ap->pmp_link;
 	}
 
-	if (++link - ap->pmp_link < ap->nr_pmp_links)
+	if (++link < ap->nr_pmp_links + ap->pmp_link)
 		return link;
 	return NULL;
 }
-- 
1.5.4.1.1278.gc75be



