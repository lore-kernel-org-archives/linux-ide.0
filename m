From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
Date: Thu, 10 Feb 2005 02:31:00 +0100
Message-ID: <58cb370e05020917312994f531@mail.gmail.com>
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl>
	 <4206F2E5.7020501@gmail.com>
	 <200502070959.54973.bzolnier@elka.pw.edu.pl>
	 <420AA476.1040406@gmail.com>
	 <58cb370e050209162437808733@mail.gmail.com>
	 <420AB049.4040705@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.206]:624 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262003AbVBJBbB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2005 20:31:01 -0500
Received: by wproxy.gmail.com with SMTP id 67so1410890wri
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2005 17:31:00 -0800 (PST)
In-Reply-To: <420AB049.4040705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>

On Thu, 10 Feb 2005 09:52:25 +0900, Tejun Heo <htejun@gmail.com> wrote:
> 
>   Okay, another quick question.
> 
>   To fix the io_32bit race problem in ide_taskfile_ioctl() (and later
> ide_cmd_ioctl() too), it seems simplest to mark the taskfile with
> something like ATA_TFLAG_IO_16BIT flag and use the flag in task_in_intr().
> 
>   However, ATA_TFLAG_* are used by libata, and I think that, although
> sharing hardware constants is good if the hardware is similar, sharing
> driver-specific flags isn't such a good idea.  So, what do you think?
> 
>   1. Add ATA_TFLAG_IO_16BIT to ata.h
>   2. Make ide's own set of task flags, maybe IDE_TFLAG_* (including
>      IDE_TFLAG_LBA48)

Please add it to <ata.h> (unless Jeff complains loudly),
I have a patch converting ide_task_t to use struct ata_taskfile
(except ->protocol for now).

Bartlomiej
