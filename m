From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/20] ide-cd: use scatterlists also for PIO transfers
Date: Mon, 16 Feb 2009 01:13:09 +0100
Message-ID: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:51372 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbZBPALo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:11:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

The recent struct ide_cmd work allows us to finally convert ide-cd to use
scatterlists for PIO transfers which fixes a long-standing bug with potential
data integrity issue on write errors for PIO transfers and fs/pc requests
(DMA transfers were never affected so it is not as serious issue as it might
sound, still great that it is gone), greatly simiplifies the code and prepares
it for a lot more improvements once struct ide_{atapi_pc,cmd} merge is done.

The patchset also contains fixes for some smaller issues uncovered by the
main change and (as an added bonus) few unrelated minor cleanups.

[ Borislav, I hope that these changes don't interfere too much with your
  current work and sorry for the rush (OTOH it should make things so much
  easier for us that the rush may be well justified)... ]

I tested that CD/DVD reading, CD writing and CD audio extraction still work
after these changes (in both PIO and DMA modes).  I also verified the behavior
on the simulated media errors.

[ on top of pata-2.6 tree ]

diffstat:
 drivers/ide/ide-cd.c       |  638 +++++++++++++++------------------------------
 drivers/ide/ide-taskfile.c |   92 +++---
 include/linux/ide.h        |    9 
 3 files changed, 273 insertions(+), 466 deletions(-)
