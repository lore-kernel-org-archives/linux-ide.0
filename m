From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Date: Thu, 24 Feb 2005 16:58:03 +0100
Message-ID: <58cb370e05022407587e86f8ad@mail.gmail.com>
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083809.63BF53E6@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050210083809.63BF53E6@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

On Thu, 10 Feb 2005 17:38:14 +0900 (KST), Tejun Heo <htejun@gmail.com> wrote:
> 
> 01_ide_task_end_request_fix.patch
> 
>         task_end_request() modified to always call ide_end_drive_cmd()
>         for taskfile requests.  Previously, ide_end_drive_cmd() was
>         called only when task->tf_out_flags.all was set.  Also,
>         ide_dma_intr() is modified to use task_end_request().
> 
>         * fixes taskfile ioctl oops bug which was caused by referencing
>           NULL rq->rq_disk of taskfile requests.

I fixed it in slightly different way in ide-dev-2.6 - by calling
ide_end_request() instead of ->end_request().

>         * enables TASKFILE ioctls to get valid register outputs on
>           successful completion.

This change makes *all* taskfile registers to be read on completion
of *any* command.  Currently this is done only for flagged taskfiles
and commands using no-data protocol.

With all your changes it will be also done for:
* HDIO_DRIVE_[TASKFILE,CMD] ioctls
* /proc/ide/hd?/{identify,smart_thresholds,smart_values}
but reading back all registers is not always needed.

It is already bad enough (and we can't fix it cause it is exported
to user-space through HDIO_DRIVE_TASKFILE), we shouldn't
make it worse.
