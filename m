From: Sam Ravnborg <sam@ravnborg.org>
Subject: ide: fix section mismatch warning
Date: Sun, 26 Feb 2006 12:17:50 +0100
Message-ID: <20060226111750.GA30135@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtp.tele.dk ([193.162.159.95]:1796 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751322AbWBZLR5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Feb 2006 06:17:57 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

In latest -mm ide-code.o gave a number of warnings like the following:

WARNING: drivers/ide/ide-core.o - Section mismatch: reference to    \
.init.text: from .text between 'init_module' (at offset 0x1f97) and \
'cleanup_module'

The warning was caused by init_module() calling parse_option() and
ide_init() both declared __init.

Declaring init_module() __init fixes the warnings.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
Compiletime tested with allmodconfig on amd64 only.

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index b2cc437..3fdab56 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -2058,7 +2058,7 @@ static void __init parse_options (char *
 	}
 }
 
-int init_module (void)
+int __init init_module (void)
 {
 	parse_options(options);
 	return ide_init();
