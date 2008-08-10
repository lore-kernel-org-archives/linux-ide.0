From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/22] ide: more work on generic ATAPI support
Date: Sun, 10 Aug 2008 17:35:27 +0200
Message-ID: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:2494 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbYHJPhk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Aug 2008 11:37:40 -0400
Received: by mu-out-0910.google.com with SMTP id w8so3058471mue.1
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 08:37:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Just some more work on generic ATAPI layer...

- code unifications here and there

- move IDEFLOPPY_IOCTL_FORMAT_* support to a separate file

- ide_pc_intr() no longer requires zillion of arguments

Applies on top of current pata tree, tested with ide-scsi.

diffstat:
 drivers/ide/Makefile           |    3 
 drivers/ide/ide-atapi.c        |  323 +++++++++++++++--
 drivers/ide/ide-floppy.c       |  739 ++++++-----------------------------------
 drivers/ide/ide-floppy.h       |   72 +++
 drivers/ide/ide-floppy_ioctl.c |  245 +++++++++++++
 drivers/ide/ide-tape.c         |  396 ++++++---------------
 drivers/scsi/ide-scsi.c        |  178 ++-------
 include/linux/ide.h            |  266 +++++++++-----
 8 files changed, 1035 insertions(+), 1187 deletions(-)
