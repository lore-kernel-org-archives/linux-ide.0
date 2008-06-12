From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 00/18] misc generic ide stuff
Date: Thu, 12 Jun 2008 08:40:52 +0200
Message-ID: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:9461 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbYFLGlD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:41:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2381786fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:41:02 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here are some generic ide conversion patches. The first 12 are what i thought
you suggested :) concerning prepping the ide-cd code for the generic layer. The
remaining 6 are what i've done so far wrt removing ide_atapi_pc from the ide
drivers. It is obvious that this is not trivial and I basically tiptoe around the
landmines in the IRQ handler and request issue paths :). This raises also
several questions:

1. ide-cd uses the cdrom_info struct for e.g. dma status notification, the other
ide drivers use it per packet command in pc->flags. Well the last are kinda too
much to carry for _each_ command and i'm thinking maybe put all that in the
ide_drive_t and make it generic enough to fit all drivers. This way
pc->callback() can also be harboured there. One concern might be when a flag is
strictly per packet command which could be put somewhere else (maybe in the
struct request since it already has members when it is used as a packet
command).

2. Can all that pc->xferred, pc->b_count, pc->errors and pc->cur_pos accounting
be safely mapped to a rq? I see some discrepancies like is pc->buf_size ==
rq->data_len, what about pc->req_xfer? I'll have a more detailed look at those
when i have more spare time later.

3. (I'm sure there are more :))
