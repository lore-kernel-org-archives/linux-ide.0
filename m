From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/18] ide: warm-plug support for IDE devices and other goodies
Date: Fri, 08 Feb 2008 01:44:21 +0100
Message-ID: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:22306 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYBHAaM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 19:30:12 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1041530nfb.21
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 16:30:08 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


- couple of fixes and preparatory patches

- rework of PowerMac media-bay support ([un]register IDE devices instead of
  [un]registering IDE interface) [ it is the main reason for spamming PPC ML ]

- IDE warm-plug support (though it is still experimental it should work fine,
  unlike the older method), to warm-plug devices on a port 'idex':

  # echo -n "1" > /sys/class/ide_port/idex/delete_devices

  unplug old device(s) and plug new device(s)

  # echo -n "1" > /sys/class/ide_port/idex/scan

  done

- ability to add new interfaces for ide-generic host driver through
  /sys/class/ide_generic/add, i.e.

  echo -n "0x168:0x36e:10" > /sys/class/ide_generic/add

- because of the above changes some obsoleted/broken code can be removed
  (thus the total effect of the patch series is -100 LOC)


diffstat:
 Documentation/ide.txt                 |   31 --
 Documentation/ide/warm-plug-howto.txt |   13 +
 block/compat_ioctl.c                  |    1 
 drivers/ide/Kconfig                   |   25 --
 drivers/ide/Makefile                  |    2 
 drivers/ide/arm/bast-ide.c            |    4 
 drivers/ide/arm/palm_bk3710.c         |    2 
 drivers/ide/arm/rapide.c              |    2 
 drivers/ide/ide-acpi.c                |    2 
 drivers/ide/ide-generic.c             |   85 +++++++
 drivers/ide/ide-pnp.c                 |    2 
 drivers/ide/ide-probe.c               |  108 ++++++++-
 drivers/ide/ide-proc.c                |    3 
 drivers/ide/ide.c                     |  386 ++++++++--------------------------
 drivers/ide/legacy/ide-cs.c           |    6 
 drivers/ide/legacy/ide_platform.c     |    2 
 drivers/ide/mips/au1xxx-ide.c         |    5 
 drivers/ide/pci/cmd640.c              |    2 
 drivers/ide/pci/delkin_cb.c           |    6 
 drivers/ide/pci/scc_pata.c            |    2 
 drivers/ide/ppc/pmac.c                |    4 
 drivers/ide/setup-pci.c               |   11 
 drivers/macintosh/mediabay.c          |   17 -
 include/asm-powerpc/mediabay.h        |    4 
 include/linux/hdreg.h                 |    4 
 include/linux/ide.h                   |   51 ----
 26 files changed, 339 insertions(+), 441 deletions(-)
