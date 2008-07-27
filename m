From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/3] ide: /proc/ide/hd*/settings rework
Date: Sun, 27 Jul 2008 20:56:02 +0200
Message-ID: <20080727185602.4660.66530.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758937AbYG0S6Y@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Elias Oltmanns <eo@nebensachen.de>
List-Id: linux-ide@vger.kernel.org


Hi,

I finally dusted off /proc/ide/hd*/settings rework (this has been laying
on my hdd and waiting for the better days for at least 1.5 year, draft
version even longer like ~3 years... sigh).

The main motivation for doing it is that with infrastructure for private
IDE subsystem requests from Elias Oltmanns (which was merged recently)
and this patchset it should be possible (by using private requests for
device settings) to make IDE locking code a lot saner and get rid of
of ide_spin_wait_hwgroup()-ugliness completely.

Elias if you would like to take care of it please go ahead [ from a quick
look it seems this would mostly require adding new request type, pointing
rq->special to setting's ->get or ->set method and putting setting's type
(read/write -> 1 bit) + argument (int) somewhere inside request but you
probably know better ].

Patches #1-2 are a preparatory cleanups, the main rework is in patch #3.

diffstat:
 drivers/ide/ide-cd.c     |   20 +--
 drivers/ide/ide-disk.c   |   94 ++++++++-------
 drivers/ide/ide-floppy.c |   39 ++++--
 drivers/ide/ide-probe.c  |    2
 drivers/ide/ide-proc.c   |  285 ++++++++++++++---------------------------------
 drivers/ide/ide-tape.c   |   77 ++++++++----
 drivers/ide/ide.c        |   25 ++--
 drivers/scsi/ide-scsi.c  |   54 ++++++--
 include/linux/ide.h      |  112 ++++++++++++------
 9 files changed, 356 insertions(+), 352 deletions(-)
