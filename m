From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/12] ide: limit legacy VLB host drivers to alpha, x86 and mips
Date: Sat, 16 Feb 2008 17:39:32 +0100
Message-ID: <20080216163932.10174.87755.sendpatchset@localhost.localdomain>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:28566 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758787AbYBPQZA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:25:00 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1114981fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:25:00 -0800 (PST)
In-Reply-To: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

These host drivers indirectly depend on CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS=y
which is defined only on alpha, x86, ia64, m32r, mips and ppc32.

Moreover:

- on ia64 there is no ISA

- m32r is too new for VLB

- on ppc32 ISA is available only on PPC_CHRP (no default IDE ports)
  and PPC_PREP (marked as BROKEN)

[ the common sense tells me that VLB was only used on x86 but there
  are urban legends that one of these host drivers was needed on some
  other arch - thus the extra care ]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1031,7 +1031,7 @@ config IDE_EXT_DIRECT
 endchoice
 
 # no isa -> no vlb
-if ISA
+if ISA && (ALPHA || X86 || MIPS)
 
 comment "Other IDE chipsets support"
 comment "Note: most of these also require special kernel boot parameters"
