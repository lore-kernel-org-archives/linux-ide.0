From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/7] ide: locking improvements
Date: Wed, 08 Oct 2008 22:29:30 +0200
Message-ID: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:25367 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbYJHUbF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 16:31:05 -0400
Received: by gv-out-0910.google.com with SMTP id e6so694837gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 13:31:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Locking improvements in preparation for replacing the global ide_lock
spinlock by per-hwgroup spinlocks [1].

[1] patch (which is partially based on 2005 patch from Scalex86) for this
is also ready but it needs some more audit and testing

diffstat:
 drivers/ide/ide-cd.c     |   38 ++++++-------
 drivers/ide/ide-io.c     |  129 ++++++++++++++++++++---------------------------
 drivers/ide/ide-ioctls.c |    3 -
 drivers/ide/ide-lib.c    |    7 --
 drivers/ide/ide-proc.c   |   25 +--------
 drivers/ide/ide.c        |    7 --
 6 files changed, 80 insertions(+), 129 deletions(-)
