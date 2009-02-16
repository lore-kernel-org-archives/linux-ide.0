From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/20] ide-cd: remove dead URLs
Date: Mon, 16 Feb 2009 01:13:29 +0100
Message-ID: <20090216001329.27491.49628.sendpatchset@localhost.localdomain>
References: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:35554 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbZBPAMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:12:05 -0500
In-Reply-To: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: remove dead URLs

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -12,12 +12,9 @@
  * See Documentation/cdrom/ide-cd for usage information.
  *
  * Suggestions are welcome. Patches that work are more welcome though. ;-)
- * For those wishing to work on this driver, please be sure you download
- * and comply with the latest Mt. Fuji (SFF8090 version 4) and ATAPI
- * (SFF-8020i rev 2.6) standards. These documents can be obtained by
- * anonymous ftp from:
- * ftp://fission.dt.wdc.com/pub/standards/SFF_atapi/spec/SFF8020-r2.6/PS/8020r26.ps
- * ftp://ftp.avc-pioneer.com/Mtfuji4/Spec/Fuji4r10.pdf
+ *
+ * Documentation:
+ *	Mt. Fuji (SFF8090 version 4) and ATAPI (SFF-8020i rev 2.6) standards.
  *
  * For historical changelog please see:
  *	Documentation/ide/ChangeLog.ide-cd.1994-2004
