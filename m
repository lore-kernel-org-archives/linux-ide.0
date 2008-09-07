From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/18] ide: add generic ATA/ATAPI disk driver
Date: Mon, 08 Sep 2008 00:14:24 +0200
Message-ID: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:54949 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbYIGWQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:16:34 -0400
Received: by gv-out-0910.google.com with SMTP id e6so75275gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:16:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


[ Borislav, this is the 'futuristic' stuff that we were talking about. :) ]

Hi,

This patch series adds a generic ATA/ATAPI disk driver (ide-gd) replacing
ide-disk and ide-floppy drivers.  It is achieved by moving the common code
to ide-gd.c, adding struct ide_disk_ops (which is used to abstract protocol
specific details) and updating ide-{disk,floppy}.c accordingly.

The main goal is to make the code more maintainable / easier to extend later.
As an immediate result we get driver specific debugging support for ATA disks
and ability for driver specific Power Management for ATAPI devices.  Otherwise
it is really an initial merge (which means that in the future the code can be
further unified, struct ide_disk_ops can be made more fine-grained etc.).

patches:
 #01-02 drive-by bugfixes
 #03-04 small improvements (good on their own)
 #05-12 small cleanups (good on their own)
 #13-17 preparatory patches (just to make the review easier)
 #18    the main patch

diffstat:
 drivers/ide/Kconfig            |   64 +--
 drivers/ide/Makefile           |   23 -
 drivers/ide/ide-atapi.c        |    2 
 drivers/ide/ide-cd.c           |   22 -
 drivers/ide/ide-cd_ioctl.c     |    8 
 drivers/ide/ide-disk.c         |  434 ++++------------------
 drivers/ide/ide-disk.h         |   35 -
 drivers/ide/ide-disk_ioctl.c   |    6 
 drivers/ide/ide-disk_proc.c    |    2 
 drivers/ide/ide-floppy.c       |  419 +++------------------
 drivers/ide/ide-floppy.h       |   79 +---
 drivers/ide/ide-floppy_ioctl.c |   15 
 drivers/ide/ide-floppy_proc.c  |    2 
 drivers/ide/ide-gd-floppy.c    |  802 ++++++++++++++++++++---------------------
 drivers/ide/ide-gd.c           |  437 +++++++++++++++++++++-
 drivers/ide/ide-gd.h           |   44 ++
 drivers/ide/ide-probe.c        |    1 
 drivers/ide/ide-proc.c         |    6 
 drivers/ide/ide-tape.c         |   16 
 drivers/leds/Kconfig           |    2 
 drivers/scsi/ide-scsi.c        |   26 -
 include/linux/ide.h            |   34 +
 22 files changed, 1209 insertions(+), 1270 deletions(-)
