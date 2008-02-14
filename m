From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [RFC-UGLYPATCH] ata: small optimization in linux/libata.h
Date: Thu, 14 Feb 2008 11:16:18 -0800
Message-ID: <1203016578.2748.69.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:59656 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757422AbYBNTQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 14:16:22 -0500
Received: by py-out-1112.google.com with SMTP id u52so529830pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 11:16:20 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

This patch may be too ugly to live, it suppresses a lot of
sparse warnings in the libata build and produces slightly
tighter code. (4 instructions vs 5 and a few bytes saved).

include/linux/libata.h:1214:13: warning: potentially expensive pointer subtraction

Original:
	if (++link - ap->pmp_link < ap->nr_pmp_links)
		return link;

     52b:	89 d8                	mov    %ebx,%eax
     52d:	2b 82 60 26 00 00    	sub    0x2660(%edx),%eax
     533:	c1 f8 02             	sar    $0x2,%eax
     536:	69 c0 dd 3d c8 44    	imul   $0x44c83ddd,%eax,%eax
     53c:	3b 82 5c 26 00 00    	cmp    0x265c(%edx),%eax
     542:	7d 04                	jge    548 <sata_pmp_detach+0xbe>

Next:
	if ((char*)++link - (char *)ap->pmp_link < ap->nr_pmp_links * sizeof(*link))
		return link;

     52b:	69 81 5c 26 00 00 d4 	imul   $0x9d4,0x265c(%ecx),%eax
     532:	09 00 00
     535:	89 da                	mov    %ebx,%edx
     537:	2b 91 60 26 00 00    	sub    0x2660(%ecx),%edx
     53d:	39 c2                	cmp    %eax,%edx
     53f:	73 04                	jae    545 <sata_pmp_detach+0xbb>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
I know it's ugly, but I had it done anyways.  The one real problem I have
with it is that if link and ap->pmp_link ever get changed to different types
the compiler will not even warn as we cast away to (char *).  To make it
a bit more robust, a BUILD_BUG_ON checking the pointer types may be a
good idea.

 include/linux/libata.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2845983..f0e1178 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1211,7 +1211,7 @@ static inline struct ata_link *ata_port_next_link(struct ata_link *link)
 		return ap->pmp_link;
 	}
 
-	if (++link - ap->pmp_link < ap->nr_pmp_links)
+	if ((char*)++link - (char *)ap->pmp_link < ap->nr_pmp_links * sizeof(*link))
 		return link;
 	return NULL;
 }
-- 
1.5.4.1.1278.gc75be



