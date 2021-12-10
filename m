Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD6EC43217
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhLJHdp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34976 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbhLJHdZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6C8B9218A9;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wANsrl+NTGHVH/3p9vBgAmwo9wDUpYFWc//q+VYv/dE=;
        b=DnVMIKQn5nARIoFGXF8FLL5wAOJlZiU0m9prVKH5WMb0AY3V6NLtSm+XbYu0CNfiEM2zc4
        ynoR18sf2j+5s2+kZYJL7iIFodjNsCmZNeL0/7LL4+anIPdMh5OyTzFIsBcVOSaVhC+AJd
        18BaJPy1A+b1ucAY9dxpcw2L1pnA1+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wANsrl+NTGHVH/3p9vBgAmwo9wDUpYFWc//q+VYv/dE=;
        b=irdp97h1lNDL+pIEktR7nY4I21NfMKbQbxyQQIxf1Hc41EgY6cg1bd/Z1Dw0HFH9zLWJuL
        Iz0mLdmJacEM7PCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 68D53A3BD7;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 66EC551920A9; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 68/68] sata_dwc_460ex: Remove debug compile options
Date:   Fri, 10 Dec 2021 08:29:05 +0100
Message-Id: <20211210072905.15666-69-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Driver has been converted to dynamic debugging, so the compile-time
options don't have any functionality left.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig          | 12 ------------
 drivers/ata/sata_dwc_460ex.c |  8 --------
 2 files changed, 20 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a7da8ea7b3ed..f6e943c74001 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -432,18 +432,6 @@ config SATA_DWC_OLD_DMA
 	  This option enables support for old device trees without the
 	  "dmas" property.
 
-config SATA_DWC_DEBUG
-	bool "Debugging driver version"
-	depends on SATA_DWC
-	help
-	  This option enables debugging output in the driver.
-
-config SATA_DWC_VDEBUG
-	bool "Verbose debug output"
-	depends on SATA_DWC_DEBUG
-	help
-	  This option enables the taskfile dumping and NCQ debugging.
-
 config SATA_HIGHBANK
 	tristate "Calxeda Highbank SATA support"
 	depends on ARCH_HIGHBANK || COMPILE_TEST
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e1024e062cc5..8fe740db37ac 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -14,14 +14,6 @@
  *          COPYRIGHT (C) 2005  SYNOPSYS, INC.  ALL RIGHTS RESERVED
  */
 
-#ifdef CONFIG_SATA_DWC_DEBUG
-#define DEBUG
-#endif
-
-#ifdef CONFIG_SATA_DWC_VDEBUG
-#define VERBOSE_DEBUG
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
-- 
2.29.2

