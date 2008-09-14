From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 00/10] ide-cd: use generic ide_issue_pc
Date: Sun, 14 Sep 2008 13:35:48 +0200
Message-ID: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:18333 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbYINLgD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Sep 2008 07:36:03 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1486847fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 14 Sep 2008 04:36:02 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here are some patches converting ide-cd to using ide_issue_pc. Next is
replacing cdrom_transfer_packet_command with ide_transfer_pc.

 drivers/ide/ide-atapi.c  |   71 ++++++++++++++++++++++---------
 drivers/ide/ide-cd.c     |  104 ++++++---------------------------------------
 drivers/ide/ide-cd.h     |   30 +++++++++++++-
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-tape.c   |    2 +-
 drivers/scsi/ide-scsi.c  |    3 +-
 include/linux/ide.h      |    5 ++-
 7 files changed, 102 insertions(+), 115 deletions(-)
