From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/9] ide: core code housekeeping
Date: Thu, 15 Jan 2009 21:00:32 +0100
Message-ID: <20090115200032.17294.84745.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:56109 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760574AbZAOUAT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 15:00:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Some housekeeping for core IDE code... against pata-2.6 tree...

diffstat:
 drivers/ide/Kconfig         |    8 +
 drivers/ide/Makefile        |    7 -
 drivers/ide/ide-atapi.c     |    5
 drivers/ide/ide-cd.c        |    4
 drivers/ide/ide-devsets.c   |  190 +++++++++++++++++++++++++++++++++
 drivers/ide/ide-dma.c       |   57 ++++++++++
 drivers/ide/ide-io.c        |  245 +++++++++++--------------------------------
 drivers/ide/ide-iops.c      |   34 ------
 drivers/ide/ide-lib.c       |  240 ------------------------------------------
 drivers/ide/ide-park.c      |   25 ++++
 drivers/ide/ide-xfer-mode.c |  246 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide.c           |  154 ---------------------------
 include/linux/ide.h         |   21 ++-
 13 files changed, 613 insertions(+), 623 deletions(-)
