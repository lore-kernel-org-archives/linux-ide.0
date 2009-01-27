From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/4] m68k related IDE cleanups
Date: Tue, 27 Jan 2009 19:02:46 +0100
Message-ID: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:45394 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbZA0SCG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 13:02:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-m68k@vger.kernel.org


Based on top of pata-2.6 tree (& hopefully tomorrow's linux-next).

This removes m68k-specific IDE_ARCH_{INTR,LOCK}, switches m68k host drivers
to use core code's MMIO support and cleanups <asm-m68k/ide.h> significantly.

Geert/Michael: please take a look when possible.

diffstat:
 drivers/ide/buddha.c    |    6 ---
 drivers/ide/falconide.c |   32 +++++++++++++++++----
 drivers/ide/gayle.c     |    6 +--
 drivers/ide/ide-io.c    |   13 ++++----
 drivers/ide/ide-probe.c |    2 +
 drivers/ide/macide.c    |    2 -
 drivers/ide/q40ide.c    |    6 +--
 include/asm-m68k/ide.h  |   73 ------------------------------------------------
 include/linux/ide.h     |   21 ++++++-------
 9 files changed, 53 insertions(+), 108 deletions(-)
