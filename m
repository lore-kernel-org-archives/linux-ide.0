From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/3] some ide fixes
Date: Wed,  4 Mar 2009 10:16:53 +0100
Message-ID: <1236158216-23052-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:45308 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZCDJRE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 04:17:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

I've updated the two ide-floppy patches from you to current pata-2.6 and
added the partial completions fix to the second one so that we don't
break bisect builds (although this is hardly unlikely since nobody uses
an ide-floppy anymore). The 3rd patch is the ide-cd fix from linux-next
which has been tested by Tetsuo and me.

 drivers/ide/ide-atapi.c  |  136 +++++++++++++++-------------------------------
 drivers/ide/ide-cd.c     |    4 --
 drivers/ide/ide-floppy.c |   26 ++--------
 drivers/ide/ide-tape.c   |   32 ++++++------
 include/linux/ide.h      |    5 --
 5 files changed, 64 insertions(+), 139 deletions(-)
