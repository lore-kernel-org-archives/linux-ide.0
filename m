From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/5] ide-tape: refit tape data buffer bits/kill pipelining
Date: Sat, 29 Mar 2008 18:46:04 +0100
Message-ID: <1206812769-10065-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:23055 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbYC2Rp7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 13:45:59 -0400
Received: by py-out-1112.google.com with SMTP id u52so1147943pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 10:45:59 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

This patchset refits the tape->merge_stage pipeline stage into tape->bh, a
singly linked list of idetape_bh's, each of which is a tag attached to one or
more pages serving as a buffer for data requests. The original functionality
is kept wrt collecting data in the buffer and flushing it to the hardware
when full.

Currently, the data rq's are serialized on the block interface and it
would probably be better to return immediately after issuing it over
ide_do_drive_cmd() in order to increase throughput, proper locking and testing
implied of course.

 drivers/ide/ide-tape.c |  393 +++++++++++++++++-------------------------------
 1 files changed, 135 insertions(+), 258 deletions(-)
