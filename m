From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/12] ide: IRQ setup fixes/sanitizations
Date: Mon, 19 Jan 2009 15:13:30 +0100
Message-ID: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36546 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZASONI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:13:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


IRQ setup fixes/sanitizations.

For IDE PCI controllers we now always use pci_get_legacy_ide_irq() if device
is in compatibility mode.  This in turn allows us to remove no longer needed:
- IRQ hackery from both core code and host drivers
- optional IRQ auto-probing from core code

These patches are on top of:
- pata-2.6 tree
- "[PATCH 0/6] ide: more core code housekeeping" patchset
- "[PATCH] mn10300: add pci_get_legacy_ide_irq() to <asm/pci.h>"

diffstat:
 drivers/ide/amd74xx.c         |   12 ----
 drivers/ide/atiixp.c          |    3 -
 drivers/ide/ide-pci-generic.c |    4 -
 drivers/ide/ide-probe.c       |  114 +++++++-----------------------------------
 drivers/ide/ns87415.c         |    4 -
 drivers/ide/piix.c            |   11 ----
 drivers/ide/serverworks.c     |    9 ---
 drivers/ide/setup-pci.c       |   36 ++++++++-----
 drivers/ide/sis5513.c         |    2 
 drivers/ide/slc90e66.c        |    1 
 drivers/ide/trm290.c          |    3 -
 drivers/ide/via82cxxx.c       |   10 ---
 include/linux/ide.h           |   19 -------
 13 files changed, 49 insertions(+), 179 deletions(-)
