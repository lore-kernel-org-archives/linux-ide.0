From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] IDE cleanups for 2.6.4-rc1 (2/3)
Date: Wed, 3 Mar 2004 05:38:10 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403030538.10029.bzolnier@elka.pw.edu.pl>
References: <200403022215.07385.bzolnier@elka.pw.edu.pl> <404513E8.9010101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48333 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262346AbUCCEau
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Mar 2004 23:30:50 -0500
In-Reply-To: <404513E8.9010101@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 03 of March 2004 00:08, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > [IDE] remove ide_cmd_type_parser() logic
> >
> > Set ide_task_t fields (command_type, handler and prehandler) directly.
> > Remove unused ide_task_t->posthandler and all ide_cmd_type_parser()
> > logic.
> >
> > ide_cmd_type_parser() was meant to be used for ioctls but
> > ended up checking validity of kernel generated requests (doh!).
> >
> > Rationale for removal:
> > - it can't be used for existing ioctls (changes the way they work)
> > - kernel shouldn't check validity of (root only) user-space requests
> >   (it can and should be done in user-space)
> > - it wastes CPU cycles on going through parsers
> > - it makes code harder to understand/follow
> >   (now info about request is localized)
>
> Without the annoyingly-large 'switch', how do you figure out whether a
> command is non-data, pio-read, pio-write, dma-read, or dma-write?

Using ide_task_t->{command_type, handler}, command_type values:

	IDE_DRIVE_TASK_IN - read
	IDE_DRIVE_TASK_RAW_WRITE - write
	IDE_DRIVE_TASK_NO_DATA - no data

If handler is NULL we know that command is a DMA one.

HDIO_DRIVE_TASKFILE gets information about taskfile from user-space in
ide_task_request_t->{command_type, data_phase}, data_phase can be:

	TASKFILE_OUT_DMA{Q}
	TASKFILE_IN_DMA{Q}
	TASKFILE_MULTI_OUT
	TASKFILE_OUT
	TASKFILE_MULTI_IN
	TASKFILE_IN
	TASKFILE_NO_DATA

and this information is translated into ide_task_t->handler.

This is of course non-optimal and driver should be using something like
ata_taskfile->protocol (as in libata).

Please note that any attempts to verify commands (like this 'switch')
will fail for future or vendor specific ones.

Bartlomiej

