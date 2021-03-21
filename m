Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BC6C433DB
	for <linux-ide@archiver.kernel.org>; Sun, 21 Mar 2021 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9865561941
	for <linux-ide@archiver.kernel.org>; Sun, 21 Mar 2021 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCUT4J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 Mar 2021 15:56:09 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38028 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhCUTzY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2021 15:55:24 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CC5FE92009D; Sun, 21 Mar 2021 20:55:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C8F3692009B;
        Sun, 21 Mar 2021 20:55:22 +0100 (CET)
Date:   Sun, 21 Mar 2021 20:55:22 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] pata_legacy: Properly document module parameters
In-Reply-To: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2103211909560.21463@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Most pata_legacy module parameters lack MODULE_PARM_DESC documentation 
and none is described in kernel-parameters.txt.  Also several comments 
are inaccurate or wrong.

Add the missing documentation pieces then and reorder parameters into a 
consistent block.  Remove inaccuracies as follows:

- `all' affects primary and secondary port ranges only rather than all,

- `probe_all' affects tertiary and further port ranges rather than all,

- `ht6560b' is for HT 6560B rather than HT 6560A.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 Documentation/admin-guide/kernel-parameters.txt |   72 ++++++++++++++++++
 drivers/ata/pata_legacy.c                       |   92 ++++++++++++++----------
 2 files changed, 128 insertions(+), 36 deletions(-)

linux-pata-legacy-parm-desc.diff
Index: linux-dolch/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-dolch.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-dolch/Documentation/admin-guide/kernel-parameters.txt
@@ -3568,6 +3568,78 @@
 			Currently this function knows 686a and 8231 chips.
 			Format: [spp|ps2|epp|ecp|ecpepp]
 
+	pata_legacy.all=	[HW,LIBATA]
+			Format: <int>
+			Set to non-zero to probe primary and secondary ISA
+			port ranges on PCI systems where no PCI PATA device
+			has been found at either range.  Disabled by default.
+
+	pata_legacy.autospeed=	[HW,LIBATA]
+			Format: <int>
+			Set to non-zero if a chip is present that snoops speed
+			changes.  Disabled by default.
+
+	pata_legacy.ht6560a=	[HW,LIBATA]
+			Format: <int>
+			Set to 1, 2, or 3 for HT 6560A on the primary channel,
+			the secondary channel, or both channels respectively.
+			Disabled by default.
+
+	pata_legacy.ht6560b=	[HW,LIBATA]
+			Format: <int>
+			Set to 1, 2, or 3 for HT 6560B on the primary channel,
+			the secondary channel, or both channels respectively.
+			Disabled by default.
+
+	pata_legacy.iordy_mask=	[HW,LIBATA]
+			Format: <int>
+			IORDY enable mask.  Set individual bits to allow IORDY
+			for the respective channel.  Bit 0 is for the first
+			legacy channel handled by this driver, bit 1 is for
+			the second channel, and so on.  The sequence will often
+			correspond to the primary legacy channel, the secondary
+			legacy channel, and so on, but the handling of a PCI
+			bus and the use of other driver options may interfere
+			with the sequence.  By default IORDY is allowed across
+			all channels.
+
+	pata_legacy.opti82c46x=	[HW,LIBATA]
+			Format: <int>
+			Set to 1, 2, or 3 for Opti 82c611A on the primary
+			channel, the secondary channel, or both channels
+			respectively.  Disabled by default.
+
+	pata_legacy.opti82c611a=	[HW,LIBATA]
+			Format: <int>
+			Set to 1, 2, or 3 for Opti 82c465MV on the primary
+			channel, the secondary channel, or both channels
+			respectively.  Disabled by default.
+
+	pata_legacy.pio_mask=	[HW,LIBATA]
+			Format: <int>
+			PIO mode mask for autospeed devices.  Set individual
+			bits to allow the use of the respective PIO modes.
+			Bit 0 is for mode 0, bit 1 is for mode 1, and so on.
+			All modes allowed by default.
+
+	pata_legacy.probe_all=	[HW,LIBATA]
+			Format: <int>
+			Set to non-zero to probe tertiary and further ISA
+			port ranges on PCI systems.  Disabled by default.
+
+	pata_legacy.qdi=	[HW,LIBATA]
+			Format: <int>
+			Set to non-zero to probe QDI controllers.  By default
+			set to 1 if CONFIG_PATA_QDI_MODULE, 0 otherwise.
+
+	pata_legacy.winbond=	[HW,LIBATA]
+			Format: <int>
+			Set to non-zero to probe Winbond controllers.  Use
+			the standard I/O port (0x130) if 1, otherwise the
+			value given is the I/O port to use (typically 0x1b0).
+			By default set to 1 if CONFIG_PATA_WINBOND_VLB_MODULE,
+			0 otherwise.
+
 	pause_on_oops=
 			Halt all CPUs after the first oops has been printed for
 			the specified number of seconds.  This is to be used if
Index: linux-dolch/drivers/ata/pata_legacy.c
===================================================================
--- linux-dolch.orig/drivers/ata/pata_legacy.c
+++ linux-dolch/drivers/ata/pata_legacy.c
@@ -63,7 +63,62 @@
 
 static int all;
 module_param(all, int, 0444);
-MODULE_PARM_DESC(all, "Grab all legacy port devices, even if PCI(0=off, 1=on)");
+MODULE_PARM_DESC(all,
+		 "Set to probe unclaimed pri/sec ISA port ranges even if PCI");
+
+static int probe_all;
+module_param(probe_all, int, 0);
+MODULE_PARM_DESC(probe_all,
+		 "Set to probe tertiary+ ISA port ranges even if PCI");
+
+static int autospeed;
+module_param(autospeed, int, 0);
+MODULE_PARM_DESC(autospeed, "Chip present that snoops speed changes");
+
+static int pio_mask = ATA_PIO4;
+module_param(pio_mask, int, 0);
+MODULE_PARM_DESC(pio_mask, "PIO range for autospeed devices");
+
+static int iordy_mask = 0xFFFFFFFF;
+module_param(iordy_mask, int, 0);
+MODULE_PARM_DESC(iordy_mask, "Use IORDY if available");
+
+static int ht6560a;
+module_param(ht6560a, int, 0);
+MODULE_PARM_DESC(ht6560a, "HT 6560A on primary 1, second 2, both 3");
+
+static int ht6560b;
+module_param(ht6560b, int, 0);
+MODULE_PARM_DESC(ht6560b, "HT 6560B on primary 1, secondary 2, both 3");
+
+static int opti82c611a;
+module_param(opti82c611a, int, 0);
+MODULE_PARM_DESC(opti82c611a,
+		 "Opti 82c611A on primary 1, secondary 2, both 3");
+
+static int opti82c46x;
+module_param(opti82c46x, int, 0);
+MODULE_PARM_DESC(opti82c46x,
+		 "Opti 82c465MV on primary 1, secondary 2, both 3");
+
+#ifdef CONFIG_PATA_QDI_MODULE
+static int qdi = 1;
+#else
+static int qdi;
+#endif
+module_param(qdi, int, 0);
+MODULE_PARM_DESC(qdi, "Set to probe QDI controllers");
+
+#ifdef CONFIG_PATA_WINBOND_VLB_MODULE
+static int winbond = 1;
+#else
+static int winbond;
+#endif
+module_param(winbond, int, 0);
+MODULE_PARM_DESC(winbond,
+		 "Set to probe Winbond controllers, "
+		 "give I/O port if non standard");
+
 
 enum controller {
 	BIOS = 0,
@@ -117,30 +172,6 @@ static struct ata_host *legacy_host[NR_H
 static int nr_legacy_host;
 
 
-static int probe_all;		/* Set to check all ISA port ranges */
-static int ht6560a;		/* HT 6560A on primary 1, second 2, both 3 */
-static int ht6560b;		/* HT 6560A on primary 1, second 2, both 3 */
-static int opti82c611a;		/* Opti82c611A on primary 1, sec 2, both 3 */
-static int opti82c46x;		/* Opti 82c465MV present(pri/sec autodetect) */
-static int autospeed;		/* Chip present which snoops speed changes */
-static int pio_mask = ATA_PIO4;	/* PIO range for autospeed devices */
-static int iordy_mask = 0xFFFFFFFF;	/* Use iordy if available */
-
-/* Set to probe QDI controllers */
-#ifdef CONFIG_PATA_QDI_MODULE
-static int qdi = 1;
-#else
-static int qdi;
-#endif
-
-#ifdef CONFIG_PATA_WINBOND_VLB_MODULE
-static int winbond = 1;		/* Set to probe Winbond controllers,
-					give I/O port if non standard */
-#else
-static int winbond;		/* Set to probe Winbond controllers,
-					give I/O port if non standard */
-#endif
-
 /**
  *	legacy_probe_add	-	Add interface to probe list
  *	@port: Controller port
@@ -1250,16 +1281,5 @@ MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("pata_qdi");
 MODULE_ALIAS("pata_winbond");
 
-module_param(probe_all, int, 0);
-module_param(autospeed, int, 0);
-module_param(ht6560a, int, 0);
-module_param(ht6560b, int, 0);
-module_param(opti82c611a, int, 0);
-module_param(opti82c46x, int, 0);
-module_param(qdi, int, 0);
-module_param(winbond, int, 0);
-module_param(pio_mask, int, 0);
-module_param(iordy_mask, int, 0);
-
 module_init(legacy_init);
 module_exit(legacy_exit);
