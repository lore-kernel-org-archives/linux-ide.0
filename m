From: Olaf Hering <olh@suse.de>
Subject: [PATCH] disable debug in IDE ppc/pmac driver
Date: Wed, 5 Jan 2005 09:07:40 +0100
Message-ID: <20050105080740.GA19267@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:58286 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262297AbVAEIHl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2005 03:07:41 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org


Ben did not disagree to hide the 3 additional lines printed when booting
my ibook with the 'quiet' cmdline option.
I think these debug printk have no real value for normal operation.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNx tags linux-2.6.10.orig/drivers/ide/ppc/pmac.c linux-2.6.10-olh/drivers/ide/ppc/pmac.c
--- linux-2.6.10.orig/drivers/ide/ppc/pmac.c	2004-12-31 09:29:17.000000000 +0100
+++ linux-2.6.10-olh/drivers/ide/ppc/pmac.c	2004-12-31 10:22:20.000000000 +0100
@@ -52,7 +52,7 @@
 
 #include "ide-timing.h"
 
-#define IDE_PMAC_DEBUG
+#undef IDE_PMAC_DEBUG
 
 #define DMA_WAIT_TIMEOUT	50
 
