From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] ide: make 1-bit fields unsigned
Date: Wed, 16 Feb 2005 15:49:28 -0800
Message-ID: <20050216154928.0cf7c1ec.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from fire.osdl.org ([65.172.181.4]:38629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262139AbVBPXth (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2005 18:49:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl

It's a bit difficult to have a value and a sign bit in a
1-bit field.

Fix (90) boolean/bitfield sparse warnings:
include/linux/ide.h:937:18: warning: dubious one-bit signed bitfield
include/linux/ide.h:939:17: warning: dubious one-bit signed bitfield

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 include/linux/ide.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./include/linux/ide.h~ide_bool ./include/linux/ide.h
--- ./include/linux/ide.h~ide_bool	2005-02-15 13:48:46.615266448 -0800
+++ ./include/linux/ide.h	2005-02-15 20:07:17.682659408 -0800
@@ -934,9 +934,9 @@ typedef struct hwgroup_s {
 		/* BOOL: protects all fields below */
 	volatile int busy;
 		/* BOOL: wake us up on timer expiry */
-	int sleeping	: 1;
+	unsigned int sleeping	: 1;
 		/* BOOL: polling active & poll_timeout field valid */
-	int polling	: 1;
+	unsigned int polling	: 1;
 		/* current drive */
 	ide_drive_t *drive;
 		/* ptr to current hwif in linked-list */


---
