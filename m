From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 00/21] ide-floppy redux v2
Date: Fri, 11 Jan 2008 12:57:58 +0100
Message-ID: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp109.plus.mail.re1.yahoo.com ([69.147.102.72]:38656 "HELO
	smtp109.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758045AbYAKMD0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 07:03:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi Bart,

   here's the second version of the ide-floppy refactoring trail. All the
patches are based on the version of your quilt tree from the 05.01. Also, you've
already applied patch 5 in this series but i'm submitting it still for the sake
of completeness.


 drivers/ide/ide-cd.c     |    2 -
 drivers/ide/ide-floppy.c | 1403 ++++++++++++++++++----------------------------
 include/linux/cdrom.h    |    1 +
 include/linux/ide.h      |    3 +
 4 files changed, 558 insertions(+), 851 deletions(-)

p.s. Next stop: ide-tape.c :)
