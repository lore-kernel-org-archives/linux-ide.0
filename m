From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/16] ide: various fixes/cleanups
Date: Tue, 22 Jan 2008 00:30:36 +0100
Message-ID: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:43432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbYAUXRf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:17:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975307ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:17:30 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Easy stuff done as relax from more hard-core changes...

diffstat:

 drivers/ide/cris/ide-cris.c |    6 -
 drivers/ide/ide-dma.c       |   20 ++++++
 drivers/ide/ide-iops.c      |  145 ++++++++++----------------------------------
 drivers/ide/ide-probe.c     |   35 ++++++----
 drivers/ide/ide-tape.c      |    4 -
 drivers/ide/ide-taskfile.c  |   11 ++-
 drivers/ide/ide.c           |    5 -
 drivers/ide/pci/siimage.c   |   25 ++++---
 drivers/ide/pci/trm290.c    |    5 -
 drivers/scsi/ide-scsi.c     |    7 --
 include/linux/hdreg.h       |    4 -
 include/linux/ide.h         |   15 ----
 12 files changed, 113 insertions(+), 169 deletions(-)
