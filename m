From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/32] ide-tape redux v1
Date: Sun, 27 Jan 2008 20:45:40 +0100
Message-ID: <200801272045.40712.bzolnier@gmail.com>
References: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:32581 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576AbYA0Tc3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:29 -0500
Received: by fk-out-0910.google.com with SMTP id z23so893143fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:28 -0800 (PST)
In-Reply-To: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Sunday 27 January 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> after a lot of hammering ide-tape got pimped pretty considerably (ca. 600 lines
> shorter and slicker :)). I'm sure there's more to be done like, e.g. replacing

Good work. :)

> the BKL in idetape_write_release() with finer-grained locking etc, probably also
> some pipeline improvements, removal of OnStream support, etc. but that'll come
> later.

On-Stream support has been long gone but it seems that deprecation
warning etc. managed to survive.

w.r.t. to the pipeline-mode: it should be pipelined into /dev/null

rationale:
- it is _very_ complex
- causes errors to be deferred till the next user-space access
- direct I/O using blk_rq_map_user() will offer superior performance

the only question is whether to remove it...

>  Documentation/ide/ChangeLog.ide-tape.1995-2002 |  405 +++
>  drivers/ide/Kconfig                            |    3 +-
>  drivers/ide/ide-tape.c                         | 4146 +++++++++---------------
>  3 files changed, 1991 insertions(+), 2563 deletions(-)

applied #1-6, #8-9, #11-20, #29, #31

#10, #24 and #25 are also fine but since they depend on other patches
I couldn't merge them immediately

#7 and #21 need some recasting

#22 should be deferred for now

#26-28, #30 and #32 are still to be reviewed

BTW what happend to patch #23?

Thanks,
Bart
