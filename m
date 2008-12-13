From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/6] ide: final bits of struct hwgroup_s -> struct ide_host change
Date: Sun, 14 Dec 2008 00:39:25 +0100
Message-ID: <20081213233925.4653.58008.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:43312 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbYLMXjm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Dec 2008 18:39:42 -0500
Received: by bwz14 with SMTP id 14so329974bwz.13
        for <linux-ide@vger.kernel.org>; Sat, 13 Dec 2008 15:39:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


In the process we fix years old bug, improve the locking for serialized ports
(making it simpler to grasp and more efficient at the same time) and simplify
the core IDE code significantly...

diffstat:
 drivers/ide/alim15x3.c     |    2 
 drivers/ide/au1xxx-ide.c   |    6 
 drivers/ide/icside.c       |    2 
 drivers/ide/ide-atapi.c    |    8 -
 drivers/ide/ide-cd.c       |   16 +-
 drivers/ide/ide-dma-sff.c  |    4 
 drivers/ide/ide-dma.c      |    2 
 drivers/ide/ide-floppy.c   |    2 
 drivers/ide/ide-io.c       |  297 +++++++++++++++++++++------------------------
 drivers/ide/ide-iops.c     |   67 ++++------
 drivers/ide/ide-lib.c      |    9 -
 drivers/ide/ide-park.c     |   16 +-
 drivers/ide/ide-pm.c       |    2 
 drivers/ide/ide-probe.c    |  198 ++++--------------------------
 drivers/ide/ide-tape.c     |    9 -
 drivers/ide/ide-taskfile.c |    4 
 drivers/ide/ide.c          |   24 ---
 drivers/ide/pdc202xx_old.c |    2 
 drivers/ide/pmac.c         |    2 
 drivers/ide/scc_pata.c     |    4 
 drivers/ide/sgiioc4.c      |    2 
 drivers/ide/tc86c001.c     |   10 -
 drivers/ide/trm290.c       |    2 
 drivers/ide/tx4939ide.c    |    2 
 drivers/ide/umc8672.c      |   13 -
 include/linux/ide.h        |  107 +++++-----------
 26 files changed, 299 insertions(+), 513 deletions(-)
