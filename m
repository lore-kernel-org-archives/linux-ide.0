From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 00/06] ide-atapi: more leftovers
Date: Thu,  4 Dec 2008 07:43:23 +0100
Message-ID: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:58686 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842AbYLDGni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 01:43:38 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3301601fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 03 Dec 2008 22:43:37 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Bart,

here are the reworked patches of the first batch of ide-cd to generic
conversion. They've been lightly tested with ide-floppy only since the
ide-cd is still needs rewiring after all is moved to ide-atapi.

 drivers/ide/ide-atapi.c  |   94 +++++++++++++++++++++++++++++++++++++--------
 drivers/ide/ide-cd.c     |   42 ++------------------
 drivers/ide/ide-cd.h     |    1 -
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-tape.c   |    2 +-
 drivers/scsi/ide-scsi.c  |    2 +-
 include/linux/ide.h      |    7 ++-
 7 files changed, 90 insertions(+), 60 deletions(-)

-- 
Regards/Gruss,
    Boris.
