From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/10] ide: flags query macros
Date: Sun, 15 Feb 2009 13:08:02 +0100
Message-ID: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:31182 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbZBOMIS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 07:08:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi,

this series adds the drive->atapi_flags and drive->dev_flags macro wrappers
we discussed. The idea was to make the code more readable and this has
been my main concern when coming up with the macro naming, therefore
some macro names appear a tad more descriptive than the flag itself.

 drivers/ide/cmd640.c           |    2 +-
 drivers/ide/ht6560b.c          |    3 +-
 drivers/ide/ide-atapi.c        |   15 ++++++-------
 drivers/ide/ide-cd.c           |   44 ++++++++++++++++++++-------------------
 drivers/ide/ide-cd_ioctl.c     |   18 +++++++---------
 drivers/ide/ide-devsets.c      |    8 ++----
 drivers/ide/ide-disk.c         |   32 ++++++++++++++--------------
 drivers/ide/ide-disk_proc.c    |    2 +-
 drivers/ide/ide-dma.c          |    3 +-
 drivers/ide/ide-eh.c           |   17 +++++++--------
 drivers/ide/ide-floppy.c       |    6 ++--
 drivers/ide/ide-floppy_ioctl.c |    2 +-
 drivers/ide/ide-gd.c           |   14 ++++++------
 drivers/ide/ide-io.c           |    9 +++----
 drivers/ide/ide-ioctls.c       |    6 ++--
 drivers/ide/ide-iops.c         |    6 ++--
 drivers/ide/ide-lib.c          |    2 +-
 drivers/ide/ide-park.c         |   11 ++++-----
 drivers/ide/ide-pm.c           |    2 +-
 drivers/ide/ide-probe.c        |   36 +++++++++++++++++---------------
 drivers/ide/ide-proc.c         |    2 +-
 drivers/ide/ide-tape.c         |   12 +++++-----
 drivers/ide/ide-taskfile.c     |   16 +++++---------
 drivers/ide/ns87415.c          |    5 +--
 drivers/ide/pdc202xx_old.c     |    4 +-
 drivers/ide/sc1200.c           |    2 +-
 drivers/ide/trm290.c           |    4 +-
 27 files changed, 136 insertions(+), 147 deletions(-)
