From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [GIT PATCH linux-2.6-block#for-linus] block: fix hd and mg_disk
Date: Tue, 28 Apr 2009 07:36:41 +0200
Message-ID: <20090428053641.GE4593@kernel.dk>
References: <1240890740-3462-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:35785 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbZD1Fgm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Apr 2009 01:36:42 -0400
Content-Disposition: inline
In-Reply-To: <1240890740-3462-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, donari75@gmail.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Tue, Apr 28 2009, Tejun Heo wrote:
> Hello,
> 
> Upon ack, please pull from the following git tree.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git tj-block-for-linus
> 
> to receive the following patches.
> 
>  0001-mg_disk-fix-locking.patch
>  0002-mg_disk-fix-CONFIG_LBD-y-warning.patch
>  0003-hd-fix-locking.patch
> 
> 0001 and 0003 fix locking problem in mg_disk and hd.  mg_disk is only
> compile tested but hd received almost identical changes and is
> verified to work so I'm relatively confident regarding the mg_disk.
> 
> 0002 removes a build warning.
> 
> This patchset is on top of the current linux-2.6-block#for-linus[1]
> and contains the following changes.
> 
>  drivers/block/hd.c      |   17 +++++++----------
>  drivers/block/mg_disk.c |   19 ++++++++++++++-----
>  2 files changed, 21 insertions(+), 15 deletions(-)

Thanks Tejun, pulled!

-- 
Jens Axboe

