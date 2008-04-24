From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [patch 08/15] m68k: macide doesnt check for Mac
Date: Thu, 24 Apr 2008 20:29:48 +0200
Message-ID: <20080424183242.456519997@mail.of.borg>
References: <20080424182940.424312704@mail.of.borg>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yergi.telenet-ops.be ([195.130.132.36]:42815 "EHLO
	yergi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760621AbYDXSex (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 14:34:53 -0400
Received: from nelson.telenet-ops.be (unknown [195.130.133.66])
	by yergi.telenet-ops.be (Postfix) with ESMTP id 38CA45CB17F
	for <linux-ide@vger.kernel.org>; Thu, 24 Apr 2008 20:35:02 +0200 (CEST)
Content-Disposition: inline; filename=m68k-macide-breaks-multi-platform.diff
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

The Macintosh IDE driver (macide) doesn't check whether it's actually running
on Mac hardware, causing a crash if it isn't.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ide/legacy/macide.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -95,6 +95,9 @@ static int __init macide_init(void)
 	int irq;
 	hw_regs_t hw;
 
+	if (!MACH_IS_MAC)
+		return -ENODEV;
+
 	switch (macintosh_config->ide_type) {
 	case MAC_IDE_QUADRA:
 		base = IDE_BASE;

-- 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

