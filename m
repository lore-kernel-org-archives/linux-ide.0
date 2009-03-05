From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] libata: add CFA specific identify data words
Date: Thu, 5 Mar 2009 10:40:40 -0500
Message-ID: <20090305154040.GA23182@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:41421 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754188AbZCEPkm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Mar 2009 10:40:42 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Declare and use constants for CFA specific identify data words 162 and 163.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

---
Sergei said:
This patch is against the current pata-2.6 series. I'd prefer that Bart merged
it thru his tree as my next patch adding CF mode support to IDE depends on it.

jgarzik adds:
I didn't see this in your latest submission, Bart.  It is simple and
harmless and might as well go ahead upstream, to eliminate the
cross-tree dependency that Sergei speaks of (his patch also touched
drivers/ata/libata-core.c, but I excluded that from below).

 include/linux/ata.h       |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

Index: linux-2.6/include/linux/ata.h
===================================================================
--- linux-2.6.orig/include/linux/ata.h
+++ linux-2.6/include/linux/ata.h
@@ -89,6 +89,8 @@ enum {
 	ATA_ID_DLF		= 128,
 	ATA_ID_CSFO		= 129,
 	ATA_ID_CFA_POWER	= 160,
+	ATA_ID_CFA_KEY_MGMT	= 162,
+	ATA_ID_CFA_MODES	= 163,
 	ATA_ID_ROT_SPEED	= 217,
 	ATA_ID_PIO4		= (1 << 1),
 

