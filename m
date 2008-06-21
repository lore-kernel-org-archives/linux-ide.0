From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/18] ide: use ->tf_load in actual_try_to_identify()
Date: Sat, 21 Jun 2008 21:10:30 +0200
Message-ID: <200806212110.31086.bzolnier@gmail.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <20080620213445.13202.61145.sendpatchset@localhost.localdomain> <485C39D6.6020801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:56041 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbYFUTWQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Jun 2008 15:22:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so410881and.103
        for <linux-ide@vger.kernel.org>; Sat, 21 Jun 2008 12:22:15 -0700 (PDT)
In-Reply-To: <485C39D6.6020801@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 21 June 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > Convert actual_try_to_identify() to use ->tf_load instead of ->OUTB.
> >
> > There should be no functional changes caused by this patch.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >   
> [...]
> > Index: b/drivers/ide/ide-probe.c
> > ===================================================================
> > --- a/drivers/ide/ide-probe.c
> > +++ b/drivers/ide/ide-probe.c
> > @@ -290,9 +290,15 @@ static int actual_try_to_identify (ide_d
> >  	/* set features register for atapi
> >  	 * identify command to be sure of reply
> >  	 */
> > -	if ((cmd == WIN_PIDENTIFY))
> > -		/* disable dma & overlap */
> > -		hwif->OUTB(0, io_ports->feature_addr);
> > +	if (cmd == WIN_PIDENTIFY) {
> > +		ide_task_t task;
> > +
> > +		memset(&task, 0, sizeof(task));
> > +		/* disable DMA & overlap */
> > +		task.tf_flags = IDE_TFLAG_OUT_FEATURE;
> > +
> > +		drive->hwif->tf_load(drive, &task);
> > +	}
> >   
> 
>    Eww, this is bulky but should be a part of your plan to switch to 
> tf_load() method...

Yes on both matters:

- It is a part of The Grand Plan. ;)

- I also don't like the small increase of complexity but these changes
  make the core code completely independent of the hardware I/O registers
  (allowing any taskfile transport method).

PS Thanks for reviewing these patches.

Bart
