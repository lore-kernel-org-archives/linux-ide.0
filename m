From: Omkhar Arasaratnam <omkhar@rogers.com>
Subject: [PATCH] drivers/ide/ide-probe.c MOD_INC/DEC_USE_COUNT fixup
Date: Mon, 29 Dec 2003 18:16:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031229231653.GA17346@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: b.zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kernel-janitors-disucss@lists.sf.net, trivial@rustcorp.com
List-Id: linux-ide@vger.kernel.org

Minor fixup to replace MOD_DEC_USE_COUNT/MOD_INC_USE_COUNT with module_put(THIS_MODULE)
and try_module_get(THIS_MODULE)

I am new are this so feel free to tell me if I have done something incorrectly.

This is mainly to clean up compiler #warnings since MOD_*_USE_COUNT macros are
depreciated in 2.6


--- linux-clean/drivers/ide/ide-probe.c.org	2003-12-29 18:06:21.000000000 -0500
+++ linux-clean/drivers/ide/ide-probe.c	2003-12-29 15:38:03.000000000 -0500
@@ -1323,7 +1323,7 @@
 	unsigned int index;
 	int probe[MAX_HWIFS];
 	
-	MOD_INC_USE_COUNT;
+	try_module_get(THIS_MODULE);
 	memset(probe, 0, MAX_HWIFS * sizeof(int));
 	for (index = 0; index < MAX_HWIFS; ++index)
 		probe[index] = !ide_hwifs[index].present;
@@ -1350,7 +1350,7 @@
 	}
 	if (!ide_probe)
 		ide_probe = &ideprobe_init;
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return 0;
 }


O
