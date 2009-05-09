From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [RFC PATCH 0/12] ide-atapi remove pc->buf
Date: Sat,  9 May 2009 09:45:20 +0200
Message-ID: <1241855134-4984-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:44376 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZEIHpg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 03:45:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bart,

Here's an assortment :) of ide patches touching stuff here and there.
I've been working on those for a while and initial testing shows no
problems. Among the changes is a first attempt to remove the 64 byte
buffer embedded in each packet command sent to an ide drive. Also, some
ireason handling unification is there along with other minor stuff.

This is based ontop of

git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git block-unify-sector-and-data_len

and I'm more than open to suggestions on the logistics of merging those
(how/when/on top of whose branch/who picks them up/do we want to hit the
.31 merge window or do more testing?/etc) after being reviewed.


 drivers/ide/ide-atapi.c        |  145 +++++++++++++++++++++++------------
 drivers/ide/ide-cd.c           |   69 +++--------------
 drivers/ide/ide-floppy.c       |   53 ++++++-------
 drivers/ide/ide-floppy_ioctl.c |   43 ++++++-----
 drivers/ide/ide-tape.c         |  168 +++++++++++++++++++---------------------
 include/linux/ide.h            |   18 +----
 6 files changed, 238 insertions(+), 258 deletions(-)

--
Thanks,
Boris.

