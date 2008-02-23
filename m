From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 00/10] IDE: Coding Style Fixes
Date: Sat, 23 Feb 2008 15:04:36 +0100
Message-ID: <20080223150436.6c09ce54@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758285AbYBWOE5@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Bartlomiej,
The following 10 patches remove a huge number of errors and warnings
reported by checkpatch.pl from the IDE subsystem.

All the patches have been compile tested.


Paolo Ciarrocchi (10):
      IDE: Coding Style fixes to drivers/ide/pci/sis5513.c
      IDE: Coding Style fixes to drivers/ide/legacy/umc8672.c
      IDE: Coding Style fixes to drivers/ide/ide-pnp.c
      IDE: Coding Style fixes to drivers/ide/setup-pci.c
      IDE: Coding Style fixes to drivers/ide/ide-proc.c
      IDE: Coding Style fixes to drivers/ide/legacy/ide-4drives.c
      IDE: Coding Style fixes to drivers/ide/pci/slc90e66.c
      IDE: Coding Style fixes to drivers/ide/pci/generic.c
      IDE: Coding Style fixes to drivers/ide/pci/jmicron.c
      IDE: Coding Style fixes to drivers/ide/pci/tc86c001.c

 drivers/ide/ide-pnp.c            |   10 +-
 drivers/ide/ide-proc.c           |  175 +++++++++++++++++------------------
 drivers/ide/legacy/ide-4drives.c |    2 +-
 drivers/ide/legacy/umc8672.c     |   53 +++++------
 drivers/ide/pci/generic.c        |   50 +++++-----
 drivers/ide/pci/jmicron.c        |    3 +-
 drivers/ide/pci/sis5513.c        |  190 +++++++++++++++++++-------------------
 drivers/ide/pci/slc90e66.c       |    6 +-
 drivers/ide/pci/tc86c001.c       |   28 +++---
 drivers/ide/setup-pci.c          |   45 ++++-----
 10 files changed, 274 insertions(+), 288 deletions(-)

Ciao,
            Paolo
