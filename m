From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/8] ide-cd: first conversion batch
Date: Thu, 18 Dec 2008 08:40:44 +0100
Message-ID: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:53293 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYLRHlB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 02:41:01 -0500
Received: by bwz14 with SMTP id 14so1054028bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 23:40:59 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here's the first batch of conversion patches. Now ide_issue_pc/ide_transfer_pc
are almost completely aligned to their ide-cd counterparts
cdrom_start_packet_command/cdrom_transfer_packet_command. The only thing
missing is the setting of the irq handler through ide_set_handler but this
is not that trivial since if i'd moved ide-cd's irq handler to ide-atapi
that would suck in a bunch of other ide-cd functions which is not what we
want, (yes/no)? and I'm going to have to ponder a little bit more on that.

Those have been lightly tested with ide-cd and ide-floppy.


 drivers/ide/ide-atapi.c  |  115 ++++++++++++++++----------------------------
 drivers/ide/ide-cd.c     |  121 ++++++++++++++++++++++++++++------------------
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-tape.c   |    2 +-
 include/linux/ide.h      |    2 +-
 5 files changed, 117 insertions(+), 125 deletions(-)
