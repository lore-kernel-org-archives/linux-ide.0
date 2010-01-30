From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/9] few more ide2libata patches
Date: Sat, 30 Jan 2010 20:49:18 +0100
Message-ID: <20100130194918.30779.25485.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:50554 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab0A3Tt1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jan 2010 14:49:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


On top of atang-v4.0:
- pata_cs5536 fixes (forward ported from cs5536)
- siimage cleanup
- cs5536 & siimage ported over ide2libata (400 LOC gone)


The following changes since commit 02a4edce515b374e01068be6c954c7f90dfac861:
  Bartlomiej Zolnierkiewicz (1):
        via82cxxx: convert to ide2libata

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bart/misc.git atang-v4.1

Bartlomiej Zolnierkiewicz (9):
      pata_cs5536: forward port changes from cs5536
      pata_sil680: CodingStyle fixes
      siimage: cleanup I/O helpers
      piix: move documentation to ata_piix.h
      ide2libata: add missing credits
      pata_cs5536: move code to be re-used by ide2libata to pata_cs5536.h
      cs5536: convert to ide2libata
      pata_sil680: move code to be re-used by ide2libata to pata_sil680.h
      siimage: convert to ide2libata

 drivers/ata/ata_piix.c    |   45 ------
 drivers/ata/ata_piix.h    |   46 ++++++
 drivers/ata/pata_cs5536.c |  191 +-------------------------
 drivers/ata/pata_cs5536.h |  195 ++++++++++++++++++++++++++
 drivers/ata/pata_sil680.c |  228 +------------------------------
 drivers/ata/pata_sil680.h |  284 +++++++++++++++++++++++++++++++++++++
 drivers/ide/aec62xx.c     |    4 +-
 drivers/ide/atiixp.c      |    4 +-
 drivers/ide/cs5520.c      |    3 +-
 drivers/ide/cs5530.c      |    4 +-
 drivers/ide/cs5535.c      |    4 +-
 drivers/ide/cs5536.c      |  189 +------------------------
 drivers/ide/it8213.c      |    4 +-
 drivers/ide/it821x.c      |    4 +-
 drivers/ide/piix.c        |   40 +-----
 drivers/ide/sc1200.c      |    4 +-
 drivers/ide/siimage.c     |  342 +++------------------------------------------
 drivers/ide/sl82c105.c    |    2 +-
 drivers/ide/slc90e66.c    |    3 +-
 drivers/ide/triflex.c     |    4 +-
 20 files changed, 578 insertions(+), 1022 deletions(-)
 create mode 100644 drivers/ata/pata_cs5536.h
 create mode 100644 drivers/ata/pata_sil680.h
