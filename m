From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 4/4] irq-pio: add read/write multiple support
Date: Tue, 04 Oct 2005 05:43:34 -0400
Message-ID: <43424EC6.2040100@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58789 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750799AbVJDJnu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 05:43:50 -0400
In-Reply-To: <43413386.6000203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Albert Lee wrote:
> 
>> Patch 4/4: add read/write multiple support
>>
> 
> One "fine point" when programming the R/W MULT commands
> is to remember that each register access is very costly
> in terms of processor time.
> 
> So whenever an access can be done with 28-bit LBA,
> it should not use the EXT versions of the instructions,
> even though the device may be LBA48 capable.
> 
> The various drivers I have written for Linux and other OSs
> that deal with this always logic equivalen to this somewhere:
> 
> if (lba_sector < (1<<28) && sector_count <= 256) {
>     use LBA28
> } else if (device is lba48 capable) {
>     use LBA48
> } else {
>     error
> }

Alan lists this on his PATA should-do list, too.

Since this is legacy hardware, I am a bit skeptical about doing this -- 
and also 32-bit PIO, which is in the same category -- because this 
increases the amount of code we have to deal with, for the same basic 
function.  For rarely-hit situations, I don't mind paying some 
performance penalty if it reduces long term maintenance.  I am willing 
to push some ancient platforms in the "slow but working" category, to 
keep the code small and easier to review/debug/maintain.

That said, it should be simple enough to push the logic into 
libata-scsi.c, where it translates a SCSI READ/WRITE command into an ATA 
read/write command.  Patches welcome...


> For SATA drives, this is unlikely to make any difference,
> but for PATA it can reduce the CPU overhead of issuing
> a command by 40% or so --> saves three PCI bus transactions,
> which amounts to about 1-4us real-time, depending on the
> exact hardware in question.

When running devices in PIO-only mode, the PCI bus transactions are very 
noticeable even with SATA.

Also, though this may be stating the obvious, all this discussion is 
irrelevant for FIS-based chips, since the control flow is entirely 
different there.


> I'm really looking forward to having PIO in libata,
> so that we can support compactflash cards and the like.
> My Delkin 32-bit Cardbus Adapter driver (currently in 2.4.x IDE)
> will be one of the first new pure PIO drivers in libata..

Cool :)

	Jeff



