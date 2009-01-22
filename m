From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/8] ide: unify code for reading device identify data
Date: Thu, 22 Jan 2009 15:18:01 +0100
Message-ID: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757959AbZAVORt@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Transform try_to_identify() into globally usable ide_dev_read_id() and update
ide_driveid_update() to use it instead of duplicating the functionality.  Also
remove broken/dead EXABYTENEST handling while at it.

Based on top of pata-2.6 tree.

diffstat:
 drivers/ide/ide-iops.c  |  118 +++++++++++++++++++-----------------------------
 drivers/ide/ide-probe.c |   87 ++++++++++-------------------------
 include/linux/ata.h     |    2 
 include/linux/ide.h     |    2 
 4 files changed, 75 insertions(+), 134 deletions(-)
