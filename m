From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/6] ide-tape: refit tape data buffer bits/kill pipelining-v2
Date: Mon,  7 Apr 2008 06:44:58 +0200
Message-ID: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:44746 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbYDGEor (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 00:44:47 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1749561fkr.5
        for <linux-ide@vger.kernel.org>; Sun, 06 Apr 2008 21:44:46 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here's another patchset that contains some other fixes along with the changes
you suggested. We have now a tape->merge_bh buffer which is a singly linked list
of bh's and tape->bh is a pointer within that list. The remaining pipelining
functions have been readjusted to handle the merge buffer. I guess, that was it,
pipelining is gone.

 drivers/ide/ide-tape.c |  215 ++++++++++++++++++++++--------------------------
 1 files changed, 99 insertions(+), 116 deletions(-)
