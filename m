From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [11/12]
Date: Fri, 11 Jun 2004 19:01:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040611170154.GE4309@suse.de>
References: <200406111816.10369.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:31213 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264218AbUFKRBz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jun 2004 13:01:55 -0400
Content-Disposition: inline
In-Reply-To: <200406111816.10369.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 11 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> [PATCH] ide: kill task_[un]map_rq()
> 
> PIO handlers under CONFIG_IDE_TASKFILE_IO=n are never used for bio
> based requests (rq->bio is always NULL) so we can use rq->buffer
> directly instead of calling ide_[un]map_buffer().

Not so sure if it's ever used for something requiring performance, and
even if it isn't then it may still be worth it to keep the mapping and
instead fix the task setup to map in user data with blk_rq_map_user() by
fixing up ide_taskfile_ioctl().

It would make HDIO_DRIVE_TASKFILE a whole lot nicer.

-- 
Jens Axboe

