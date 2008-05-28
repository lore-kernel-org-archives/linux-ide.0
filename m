From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/21] ide: convert ide-timing.h to ide-timings.c library
Date: Wed, 28 May 2008 23:39:44 +0200
Message-ID: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:50110 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbYE1VmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:42:15 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2393895mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:42:11 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


This (fairly obvious/trivial) patchset converts drivers/ide/ide-timing.h
into ide-timings.c library (enabled by host drivers that want to use it by
selecting CONFIG_IDE_TIMINGS config option) and updates host drivers still
using ide_pio_timings[] to use ide_timing_find_mode() instead.

Also as a bonus it moves PIO blacklist from ide-lib.c to ide-pio-blacklist.c.

diffstat:

 drivers/ide/Kconfig             |   16 +
 drivers/ide/Makefile            |    4 
 drivers/ide/arm/palm_bk3710.c   |    2 
 drivers/ide/ide-lib.c           |  151 -----------------
 drivers/ide/ide-pio-blacklist.c |   94 +++++++++++
 drivers/ide/ide-timing.h        |  341 +++++++---------------------------------
 drivers/ide/ide-timings.c       |  201 +++++++++++++++++++++++
 drivers/ide/legacy/ali14xx.c    |    3 
 drivers/ide/legacy/ht6560b.c    |    7 
 drivers/ide/legacy/qd65xx.c     |    3 
 drivers/ide/pci/alim15x3.c      |    6 
 drivers/ide/pci/amd74xx.c       |    2 
 drivers/ide/pci/cmd640.c        |    8 
 drivers/ide/pci/cmd64x.c        |    6 
 drivers/ide/pci/cs5535.c        |    6 
 drivers/ide/pci/cy82c693.c      |    9 -
 drivers/ide/pci/opti621.c       |   10 -
 drivers/ide/pci/sis5513.c       |    3 
 drivers/ide/pci/sl82c105.c      |    3 
 drivers/ide/pci/via82cxxx.c     |    2 
 drivers/ide/ppc/mpc8xx.c        |   33 +--
 drivers/ide/ppc/pmac.c          |   15 -
 include/linux/ide.h             |   45 ++++-
 23 files changed, 461 insertions(+), 509 deletions(-)
