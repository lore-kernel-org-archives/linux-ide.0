From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [RESEND PATCH 0/10] ide-floppy redux p1
Date: Thu,  3 Jan 2008 14:19:59 +0100
Message-ID: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp107.plus.mail.re1.yahoo.com ([69.147.102.70]:20989 "HELO
	smtp107.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750993AbYACNW6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 08:22:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bzolnier@gmail.com


Hi Bart,

here's the unfinished redux of ide-floppy which i'm REsending now so that we could
sinchronize trees. The original send got busted in vger's filters due to syntax
error in the Message-ID tag.

 Documentation/ide/ChangeLog.ide-floppy.1996-2002 |   64 ++
 drivers/ide/ide-floppy.c                         | 1248 +++++++---------------
 drivers/ide/ide-floppy.h                         |  351 ++++++
 include/linux/cdrom.h                            |    1 +
 4 files changed, 819 insertions(+), 845 deletions(-)

