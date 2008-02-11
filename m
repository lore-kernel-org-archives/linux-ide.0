From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/4] ide: generic packet command representation
Date: Mon, 11 Feb 2008 09:34:36 +0100
Message-ID: <1202718880-1793-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:53255 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYBKIfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 03:35:03 -0500
Received: by an-out-0708.google.com with SMTP id d31so1125516and.103
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 00:35:02 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here's the ide_atapi_pc unification series. It all went pretty smoothly along
the search & replace line. Using driver-specific members in ide_atapi_pc like
idefloppy_callback and idetape_callback is kinda dumb but this approach seemed
the fastest versus unnecessary callback function signature change that will
touch stuff all over the place. Besides, ide-tape might be gone soon so that
would alleviate the problem.

On a different note, i noticed ide-scsi might also need a cleanup similar to the
other drivers. It is next on my TODO list in case you don't have anything with a
higher prio.


 drivers/ide/ide-floppy.c |  205 +++++++++++++++++--------------------
 drivers/ide/ide-tape.c   |  251 +++++++++++++++++++++-------------------------
 drivers/scsi/ide-scsi.c  |  133 +++++++++++-------------
 include/linux/ide.h      |   47 +++++++++
 4 files changed, 316 insertions(+), 320 deletions(-)

-- 
Thanks,
Boris.
