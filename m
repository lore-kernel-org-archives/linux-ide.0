From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2] ide: merge do_rw_taskfile() and flagged_taskfile() into do_taskfile()
Date: Sun, 6 Feb 2005 04:04:52 +0100
Message-ID: <58cb370e050205190469dcb967@mail.gmail.com>
References: <20050206021331.GA25337@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.194]:5554 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264336AbVBFDGd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2005 22:06:33 -0500
Received: by wproxy.gmail.com with SMTP id 67so689657wri
        for <linux-ide@vger.kernel.org>; Sat, 05 Feb 2005 19:06:32 -0800 (PST)
In-Reply-To: <20050206021331.GA25337@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, 6 Feb 2005 11:13:31 +0900, Tejun Heo <tj@home-tj.org> wrote:
>  Hello, Bartlomiej.

Hi,

>  This is a new version of ide_do_taskfile.patch.  Compared to the
> original do_rw_task(), only one more 'if' is used in the hot path, so
> I think the performance issue can be ignored now.  Also, there's no
> userland visible change with this patch.  Everything should work just
> as it did with do_rw_taskfile()/flagged_taskfile().
> 
>  do_taskfile() is different from do_rw_taskfile() in that

Is there any gain in changing name to do_taskfile()?
 
>  - It uses task->data_phase to determine whether it's a DMA command
>    or not.

this is user-space visible change
(it is right thing to do, I just wanted to point the fact)

>  do_taskfile() is different from flagged_taskfile() in that
> 
>  - No (TASKFILE_MULTI_IN && !mult_count) check.  ide_taskfile_ioctl()
>    checks the same thing, so it doesn't change anything.

The check may be needed.  AFAIR drive->mult_count may change
before our taskfile request is started.

>  - No task->tf_out_flags handling.  ide_end_drive_cmd() ignores it
>    anyway, so, again, it doesn't change anything.

I guess you mean ->tf_in_flags?

>  So, what do you think?

This patch looks much better but could you move writing taskfile
registers to separate helpers (one for non-flagged and one for flagged)?

Probably splitting non-flagged taskfile load helper off do_rw_taskfile()
should be done in separate patch.  We can then use this helper in
ide-disk.c for __ide_do_rw_taskfile() (we can't do direct conversion
to do_rw_taskfile() yet for various reasons).

Thanks,
Bartlomiej
