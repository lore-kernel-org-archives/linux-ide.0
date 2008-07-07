From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/10] ide: scale down <asm/ide.h>
Date: Mon, 7 Jul 2008 23:52:51 +0200
Message-ID: <200807072352.51710.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:41499 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090AbYGGWAp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 18:00:45 -0400
Received: by mu-out-0910.google.com with SMTP id w8so712930mue.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 15:00:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Hi,

This time bunch of fixups/cleanups which allow us to remove <asm/ide.h> for:

- alpha
- blackfin
- cris
- h8300
- ia64
- m32r
- sh
- x86
- xtensa

Archs that need more work for <asm/ide.h> removal:

- arm
- frv
- m68k
- mips
- mn10300
- parisc
- powerpc
- sparc[64]

...so it looks like we are halfway down the road.

diffstat:

 drivers/ide/Kconfig                 |    2 
 drivers/ide/ide-generic.c           |   34 ++++++++++++-
 include/asm-alpha/ide.h             |   44 -----------------
 include/asm-arm/ide.h               |    4 -
 include/asm-blackfin/ide.h          |   27 ----------
 include/asm-cris/arch-v10/ide.h     |   91 ------------------------------------
 include/asm-cris/arch-v32/ide.h     |   56 ----------------------
 include/asm-cris/ide.h              |    1 
 include/asm-frv/ide.h               |    4 -
 include/asm-h8300/ide.h             |   26 ----------
 include/asm-ia64/ide.h              |   51 --------------------
 include/asm-m32r/ide.h              |   86 +++-------------------------------
 include/asm-m68k/ide.h              |    4 -
 include/asm-mips/mach-generic/ide.h |   56 +---------------------
 include/asm-mn10300/ide.h           |    4 -
 include/asm-parisc/ide.h            |    4 -
 include/asm-powerpc/ide.h           |   26 ----------
 include/asm-sh/ide.h                |   21 --------
 include/asm-sparc/ide.h             |    3 -
 include/asm-sparc64/ide.h           |    8 ---
 include/asm-x86/ide.h               |   73 +---------------------------
 include/asm-xtensa/ide.h            |   39 ---------------
 include/linux/ide.h                 |   14 +++++
 23 files changed, 64 insertions(+), 614 deletions(-)
