From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH 2/2] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Thu, 10 Nov 2011 19:26:06 +0400
Message-ID: <20111110152606.GB3207@oksana.dev.rtsoft.ru>
References: <20111110151852.GA7465@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61738 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933924Ab1KJP0J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2011 10:26:09 -0500
Content-Disposition: inline
In-Reply-To: <20111110151852.GA7465@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Drivers should not use NO_IRQ; moreover, some architectures don't
have it nowadays. '0' is the 'no irq' case.

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/ata/pata_of_platform.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index f99e17b..2a472c5 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -16,11 +16,6 @@
 #include <linux/of_platform.h>
 #include <linux/ata_platform.h>
 
-/* For archs that don't support NO_IRQ (such as x86), provide a dummy value */
-#ifndef NO_IRQ
-#define NO_IRQ 0
-#endif
-
 static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 {
 	int ret;
@@ -57,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 	}
 
 	ret = of_irq_to_resource(dn, 0, &irq_res);
-	if (ret == NO_IRQ)
+	if (!ret)
 		irq_res.start = irq_res.end = 0;
 	else
 		irq_res.flags = 0;
-- 
1.7.5.3
