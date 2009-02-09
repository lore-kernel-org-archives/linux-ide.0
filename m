From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/9] ide: unify request completion methods
Date: Mon, 09 Feb 2009 21:00:42 +0100
Message-ID: <20090209200042.7985.94247.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757386AbZBIT7v@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Unify request completion methods so we (almost) always complete requests
using ide_complete_rq().  As a nice side-effect it de-convolutes a lot of
tricky code allowing further improvements later...

On top of pata-2.6 tree.

diffstat:
 drivers/ide/ide-atapi.c    |   20 +++-
 drivers/ide/ide-cd.c       |   18 ++--
 drivers/ide/ide-devsets.c  |    4 
 drivers/ide/ide-disk.c     |    4 
 drivers/ide/ide-dma.c      |    3 
 drivers/ide/ide-eh.c       |   14 ++-
 drivers/ide/ide-floppy.c   |   10 +-
 drivers/ide/ide-io.c       |  188 ++++++++++++++++-----------------------------
 drivers/ide/ide-tape.c     |    8 +
 drivers/ide/ide-taskfile.c |   10 +-
 include/linux/ide.h        |   10 +-
 11 files changed, 130 insertions(+), 159 deletions(-)
