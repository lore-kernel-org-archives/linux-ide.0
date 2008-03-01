From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 00/24] ide-tape: remove pipelined mode operation
Date: Sat,  1 Mar 2008 09:58:24 +0100
Message-ID: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:55344 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbYCAI7O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:14 -0500
Received: by mu-out-0910.google.com with SMTP id i10so7533564mue.5
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:13 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, Jens Axboe <jens.axboe@oracle.com>

Hi Bart,

here's the 1st draft of the pipeline removal series. As the diffstat below openly
states it, a lot of code got removed - even more than the cleanup series we did
earlier. There are several issues that we need to address concerning these
patches:

1. only compile-tested since i don't have the hardware, i.e. longer -mm brewing is
advisable the least.

2. I have left the tape->merge_stage buffer structure along with its
alloc/free functions intact for now, for simplicity. The next step would be
to go and carefully audit the code and then remove that last piece
too and use allocations on the stack instead. I guess we still expect
Jens's response on whether blk_{get,put}_request is the way to go here.

Jens?

3. After applying those we're moving into the direction of a lightweight
ide-tape driver so the stanza for its removal in
Documentation/feature-removal-schedule.txt becomes incorrect.

4. ... (i'm sure you're gonna have some more :))

 Documentation/ide/ide-tape.txt |  211 +++------
 drivers/ide/ide-tape.c         | 1032 +++-------------------------------------
 2 files changed, 134 insertions(+), 1109 deletions(-)
