From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND 0/1] AHCI: Optimize interrupt processing
Date: Wed, 22 May 2013 08:50:03 +0900
Message-ID: <20130521235003.GE6985@mtj.dyndns.org>
References: <cover.1369155164.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:46542 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3EUXuI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 May 2013 19:50:08 -0400
Content-Disposition: inline
In-Reply-To: <cover.1369155164.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@kernel.dk>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>

Hello, Alexander.

(cc'ing Jens and Nicholas, hey guys)

On Tue, May 21, 2013 at 09:00:27PM +0200, Alexander Gordeev wrote:
> Before this update host lock average holdtime was 3.266532061 and
> average waittime was 0.009832679 [1]. After the update average
> holdtime (slightly) rose up to 0.335267418 while average waittime
> decreased to 0.000320469 [2]. Which means host lock with local
> interrupt disabled is held roughly the same while the average
> waittime dropped 30 times.
> 
> After this update port events are handled with local interrupts
> enabled and compete on individual per-port locks with average
> holdtime 1.540987475 and average waittime 0.000714864 [3].
> Comparing to [1], ata_scsi_queuecmd() holds port locks 2 times
> less and waits for locks 13 times less.

Hmmmmmm..... I'd normally apply this patch but block layer is just
growing multi-queue support and libata is likely to be converted to mq
in foreseeable future, so I'm a bit hesitant to make irq handling more
sophiscated right now.  Would you be interested in looking into
converting libata to blk mq support?  I'm pretty sure it'd yield far
better outcome if done properly.

Thanks.

-- 
tejun
