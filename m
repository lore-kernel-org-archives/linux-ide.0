From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Date: Sun, 27 Feb 2005 15:49:22 +0900
Message-ID: <20050227064922.GA27728@htj.dyndns.org>
References: <20050210083808.48E9DD1A@htj.dyndns.org> <20050210083809.63BF53E6@htj.dyndns.org> <58cb370e05022407587e86f8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from wproxy.gmail.com ([64.233.184.198]:57884 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261356AbVB0Gt2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Feb 2005 01:49:28 -0500
Received: by wproxy.gmail.com with SMTP id 49so513006wri
        for <linux-ide@vger.kernel.org>; Sat, 26 Feb 2005 22:49:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <58cb370e05022407587e86f8ad@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Thu, Feb 24, 2005 at 04:58:03PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Thu, 10 Feb 2005 17:38:14 +0900 (KST), Tejun Heo <htejun@gmail.com> wrote:
> > 
> > 01_ide_task_end_request_fix.patch
> > 
> >         task_end_request() modified to always call ide_end_drive_cmd()
> >         for taskfile requests.  Previously, ide_end_drive_cmd() was
> >         called only when task->tf_out_flags.all was set.  Also,
> >         ide_dma_intr() is modified to use task_end_request().
> > 
> >         * fixes taskfile ioctl oops bug which was caused by referencing
> >           NULL rq->rq_disk of taskfile requests.
> 
> I fixed it in slightly different way in ide-dev-2.6 - by calling
> ide_end_request() instead of ->end_request().

 Taskfile DMA path is still broken.  Also calling ide_end_request()
will work there, but IMHO it's just cleaner to finish special commands
inside ide_end_drive_cmd().  Currently,

 * Successful flagged taskfile			-> ide_end_drive_cmd()
 * All other successful non-DMA special cmds	-> ide_end_request()
 * Successful DMA taskfile			-> segfault
 * All failed special cmds			-> ide_end_drive_cmd()

 It just shouldn't be like this.  :-(

> 
> >         * enables TASKFILE ioctls to get valid register outputs on
> >           successful completion.
> 
> This change makes *all* taskfile registers to be read on completion
> of *any* command.  Currently this is done only for flagged taskfiles
> and commands using no-data protocol.
> 
> With all your changes it will be also done for:
> * HDIO_DRIVE_[TASKFILE,CMD] ioctls
> * /proc/ide/hd?/{identify,smart_thresholds,smart_values}
> but reading back all registers is not always needed.

 None is on a hot path or even near to one, but maybe I don't have
enough experience with old hardware.  Are there some old hardware
which make the additional reads stand out?

> It is already bad enough (and we can't fix it cause it is exported
> to user-space through HDIO_DRIVE_TASKFILE), we shouldn't
> make it worse.

 Yeah, the whole IDE ioctl interface seems disturbingly messy. :-(

 * Register output is available only if
	1. The command fails.
	2. The command is a flagged taskfile.
 * taskfile->device_head is used regardless of outflags setting.
 * In flagged taskfile, taskfile->device_head can turn on the device
   bit, so we can issue commands to hdb with permissions to hda.
 * In TASK and TASKFILE, LBA commands can be issued to drives in CHS
   mode but the reverse isn't true.  However, in TASKFILE, if the
   command isn't flagged, the lower nibble of device register is
   zeroed depending on addressing setting.
 * taskfile->data endianess is reversed on big endian machines.
 * ide_reg_valid_t endianess issue.
 * And, none of above is documented.

 So, I don't know.  Do you think we should keep all of the above
behaviors?  Please let me know; then, I'll update ioctl/hdio.txt so
that people can at least know these gotchas.

 Thanks.

-- 
tejun

