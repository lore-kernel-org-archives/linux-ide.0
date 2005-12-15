From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [git patches] ide update
Date: Thu, 15 Dec 2005 03:03:23 +0100 (CET)
Message-ID: <Pine.GSO.4.64.0512150224180.19479@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030384AbVLOCui@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Some missing bits for 2.6.15.


Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to obtain following changes:

Bartlomiej Zolnierkiewicz:
   ide-disk: flush cache after calling del_gendisk()
   ide: cleanup ide.h
   ide: cleanup ide_driver_t
   ide-cd: remove write-only cmd field from struct cdrom_info

Daniel Drake:
   via82cxxx IDE: Add VT8251 ISA bridge

Jeremy Higdon:
   sgiioc4: check for no hwifs available

Jordan Crouse:
   ide: core modifications for AU1200
   ide: AU1200 IDE update

Marcelo Tosatti:
   ide: MPC8xx IDE depends on IDE=y && BLK_DEV_IDE=y


  drivers/ide/Kconfig                       |   10
  drivers/ide/ide-cd.c                      |    7
  drivers/ide/ide-cd.h                      |    1
  drivers/ide/ide-disk.c                    |    4
  drivers/ide/ide-dma.c                     |   15
  drivers/ide/mips/Makefile                 |    3
  drivers/ide/mips/au1xxx-ide.c             | 1496 ++++++++++--------------------
  drivers/ide/pci/sgiioc4.c                 |    8
  drivers/ide/pci/via82cxxx.c               |    1
  include/asm-mips/mach-au1x00/au1xxx_ide.h |   22
  include/linux/ide.h                       |  131 --
  include/linux/pci_ids.h                   |    1
  12 files changed, 566 insertions(+), 1133 deletions(-)
