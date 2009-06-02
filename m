From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] drivers/ide/ide-core: Unsplit constant strings for pr_<level> and dev_<level>
Date: Tue, 2 Jun 2009 16:19:40 +0200
Message-ID: <200906021619.40387.bzolnier@gmail.com>
References: <cover.1243062772.git.joe@perches.com> <57f9dd5c33bcdd863793a3ee95ab050e8456bab4.1243062772.git.joe@perches.com> <4A19399B.8060207@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:54352 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623AbZFBOO5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jun 2009 10:14:57 -0400
In-Reply-To: <4A19399B.8060207@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Joe Perches <joe@perches.com>, Borislav Petkov <petkovbb@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 24 May 2009 14:12:11 Sergei Shtylyov wrote:
> Hello.
> 
> Joe Perches wrote:
> 
> > Signed-off-by: Joe Perches <joe@perches.com>
> >   
> [...]
> > diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
> > index f323a60..560b9c4 100644
> > --- a/drivers/ide/ide-acpi.c
> > +++ b/drivers/ide/ide-acpi.c
> > @@ -435,8 +435,8 @@ void ide_acpi_get_timing(ide_hwif_t *hwif)
> >  	if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
> >  	    out_obj->buffer.length != sizeof(struct GTM_buffer)) {
> >  		kfree(output.pointer);
> > -		pr_err("%s: unexpected _GTM length (0x%x)[should be 0x%zx] or "
> > -		       "addr (0x%p)\n",
> > +		pr_err(
> > +	"%s: unexpected _GTM length (0x%x)[should be 0x%zx] or addr (0x%p)\n",
> >   
> 
>    Oh no... do you really think somebody will search for this message 
> using strings like "should be"?

Well, I don't know but the error message should be improved regardless
by splitting it on separate messages for separate error conditions
(wrong length vs wrong addr).

> >  		       __func__, out_obj->buffer.length,
> >  		       sizeof(struct GTM_buffer), out_obj->buffer.pointer);
> >  		return;
> > diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> > index 46cf46e..1e9e2d6 100644
> > --- a/drivers/ide/ide-atapi.c
> > +++ b/drivers/ide/ide-atapi.c
> > @@ -60,11 +60,13 @@ int ide_check_atapi_device(ide_drive_t *drive, const char *s)
> >  		dev_err(&drive->gendev, "%s: the removable flag is not set\n",
> >  			s);
> >  	else if (drive->media == ide_floppy && drq_type == 3)
> > -		dev_err(&drive->gendev, "%s: sorry, DRQ type (0x%02x) not "
> > -			"supported\n", s, drq_type);
> > +		dev_err(&drive->gendev,
> > +			"%s: sorry, DRQ type (0x%02x) not supported\n",
> >   
> 
>    Same question. I think the user will search for "sorry, DRQ type".

Lets just make it something like:

"%s: unsupported DRQ type (0x%02x)\n"

> > +			s, drq_type);
> >  	else if (packet_size != 0)
> > -		dev_err(&drive->gendev, "%s: packet size (0x%02x) is not 12 "
> > -			"bytes\n", s, packet_size);
> > +		dev_err(&drive->gendev,
> > +			"%s: packet size (0x%02x) is not 12 bytes\n",
> >   
> 
>    When the message is broken by the format specifier, turning it into 
> one liner can hardly help seraching...

"%s: wrong packet size (0x%02x)\n"

> > @@ -439,8 +440,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
> >  	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
> >  		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
> >  		dev_err(&drive->gendev,
> > -			"The device wants to issue more interrupts "
> > -			"in DMA mode\n");
> > +	"The device wants to issue more interrupts in DMA mode\n");
> >   
> 
>    Oh noes, the indentation...

We even know the device name so:

"wants to issue more IRQs in DMA mode\n"

should suffice.

> > @@ -509,14 +509,12 @@ static u8 ide_wait_ireason(ide_drive_t *drive, u8 ireason)
> >  	while (retries-- && ((ireason & ATAPI_COD) == 0 ||
> >  			     (ireason & ATAPI_IO))) {
> >  		dev_err(&drive->gendev,
> > -			"(IO,CoD != (0,1) while issuing "
> > -			"a packet command, retrying\n");
> > +	"(IO,CoD != (0,1) while issuing a packet command, retrying\n");
> >   
> 
>    Sigh...
> 
> >  		udelay(100);
> >  		ireason = ide_read_ireason(drive);
> >  		if (retries == 0) {
> >  			dev_err(&drive->gendev,
> > -				"(IO,CoD != (0,1) while issuing "
> > -				"a packet command, ignoring\n");
> > +	"(IO,CoD != (0,1) while issuing a packet command, ignoring\n");
> >   
> 
>    Sigh...

I guess that by "Sigh" you meant:

"while issuing a packet command" should go away

;)

> > @@ -547,8 +545,7 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
> >  
> >  	if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY, WAIT_READY)) {
> >  		dev_err(&drive->gendev,
> > -			"Strange, packet command initiated yet "
> > -			"DRQ isn't asserted\n");
> > +	"Strange, packet command initiated yet DRQ isn't asserted\n");
> >   
> 
>    Sigh...

"DRQ isn't asserted\n" should be enough here

Seems like most (all?) other error messages can be improved in similar way.
