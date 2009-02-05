From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Thu, 5 Feb 2009 22:23:08 +0100
Message-ID: <200902052223.08637.bzolnier@gmail.com>
References: <200902031147.22827.stf_xl@wp.pl> <498987E6.7040909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:40376 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbZBEVet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2009 16:34:49 -0500
Received: by mu-out-0910.google.com with SMTP id i10so323214mue.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Feb 2009 13:34:47 -0800 (PST)
In-Reply-To: <498987E6.7040909@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk, Atsushi Nemoto <anemo@mba.ocn.ne.jp>

On Wednesday 04 February 2009, Sergei Shtylyov wrote:

[...]

> > +void at91_ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> > +{
> > +	ide_hwif_t *hwif = drive->hwif;
> > +	struct ide_io_ports *io_ports = &hwif->io_ports;
> > +	struct ide_taskfile *tf = &task->tf;
> > +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
> > +
> > +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
> > +		HIHI = 0xFF;
> > +
> > +	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
> >   
> 
>    Sigh. Bart, couldn't we drop that stupid flag? I bet nobody ever used it.

It is there for HDIO_DRIVE_TASKFILE ioctl and I prefer not to break it.

Just add ->{read,write}_data methods for IDE_TFLAG_{IN,OUT}_DATA to struct
ide_tp_ops -- it should also help some other host drivers like tx493*.

Thanks,
Bart
