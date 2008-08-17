From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/5] ide debugging macros
Date: Sun, 17 Aug 2008 19:23:41 +0200
Message-ID: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:37405 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYHQRXr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:23:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1456290fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:23:45 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here's something i've been wanting to do for a long time: debugging macros. The
reason for it is that i got tired of adding debug printk's everytime i'm testing
something so here we go.

The debugging macro is similar to the old ones but is one for all drivers
(currently only ide-floppy), is nice on branch prediction and is controlled by a
drive->debug_mask switch which is a module parameter and as such can be set at
module load time, of course. I've been thinking of adding also a sysfs attribute
too but can't seem to find quite the justification for it so no sysfs for now :)

In addition, one can still optimize away all the debug calls in the old manner
and i'm sure those will be removed completely too when ide generic conversion is
done.

Please tell me what you think, what can be changed/improved and after we've
figured out the details I'll do the other drivers too.

Thanks.

 drivers/ide/ide-cd.c     |   17 ++---
 drivers/ide/ide-floppy.c |  168 +++++++++++++++++++++++++---------------------
 drivers/ide/ide-tape.c   |   23 ++----
 include/linux/ide.h      |   31 ++++++++-
 4 files changed, 135 insertions(+), 104 deletions(-)
