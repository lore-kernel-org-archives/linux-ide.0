From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [patch 0/6] ide: various bugfixes
Date: Tue, 23 Jun 2009 23:23:30 +0200
Message-ID: <200906232323.30762.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41020 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZFWVc3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 17:32:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Dave,

As discussed before, here is the rest of my private bugfix queue.

All patches contain an extra info about the testing they have
received to make your decisions w.r.t. handling of them easier.

diffstat:
 drivers/ide/ide-devsets.c  |    2 -
 drivers/ide/ide-eh.c       |    2 -
 drivers/ide/ide-floppy.c   |    2 -
 drivers/ide/ide-io.c       |   70 ++++++++++++++++-----------------------------
 drivers/ide/ide-ioctls.c   |    8 +----
 drivers/ide/ide-iops.c     |   17 ++--------
 drivers/ide/ide-probe.c    |   31 +++++++++++++------
 drivers/ide/ide-proc.c     |   10 +-----
 drivers/ide/ide-taskfile.c |    9 +++++
 include/linux/ide.h        |    7 ++--
 10 files changed, 69 insertions(+), 89 deletions(-)
