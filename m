From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCHSET pata-2.6] ide: rq->buffer, data, special and misc cleanups, take#2
Date: Sat, 18 Apr 2009 18:32:29 +0200
Message-ID: <200904181832.29222.bzolnier@gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52412 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbZDRQ3e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Apr 2009 12:29:34 -0400
Received: by fxm2 with SMTP id 2so1309838fxm.37
        for <linux-ide@vger.kernel.org>; Sat, 18 Apr 2009 09:29:31 -0700 (PDT)
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: petkovbb@googlemail.com, axboe@kernel.dk, linux-ide@vger.kernel.org


Hi,

On Friday 17 April 2009 11:33:07 Tejun Heo wrote:

[...]

> Tested against cdrom, floppy and tape, so, hopefully, all the bases
> are covered.

Everything looks fine to me and we can always deal with ide-tape issues
left later (no big deal as it is broken upstream anyway), Borislav?

> This patchset is on top of linux-next pata-2.6 tree as of 2009-04-16.
> Git tree is available at the following vector but please DO NOT pull
> from the following git tree as pata-2.6 tree is quilt-based and the
> base tree I used isn't the one which is gonna go upstream.  The
> following tree is for review only.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git ide-phase1
> 
> Bartlomiej, please feel free to include this in the pata-2.6 patchset.
> Also, is the git tree coming?

Care to re-base it on top of 'for-next' branch of:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git for-next

?

Thanks,
Bart
