From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: /dev/hda problem with samsung hd
Date: Fri, 23 May 2003 02:47:45 +0200 (MET DST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.SOL.4.30.0305230246490.9066-100000@mion.elka.pw.edu.pl>
References: <20030522121034.GE812@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35302 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262946AbTEWAfC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 May 2003 20:35:02 -0400
In-Reply-To: <20030522121034.GE812@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: pacho baratta <pachox@evolinux.it>, linux-ide@vger.kernel.org


Hi Jens,
already solved, it was exactly this issue.
--
Bartlomiej

On Thu, 22 May 2003, Jens Axboe wrote:

> On Thu, May 22 2003, pacho baratta wrote:
> > i'm working with a disk (samsung sv1022d) that my system cannot see. i
> > have a live cd with kernel 2.4.20 and glibc-2.2.5.
> >
> > now when i boot i find in dmesg:
> >
> > hda samsung sv1022d my100 ata disk drive
> > hda: task_no_data_intr 0x51 {DriveRady SeekComplete Error}
> > hda: task_no_data_intr 0x04 {DriveStatusError}
> > hda: 1 sectors (0 mb) w/480KiB Cache CHS=1240/255/63
>
> I fixed this some time ago, the patch is in 2.4.21-rc kernels. So please
> try 2.4.21-rc2 and see if it works.
>
> --
> Jens Axboe

