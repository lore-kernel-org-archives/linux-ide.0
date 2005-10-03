From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH/RFC 4/4] irq-pio: add read/write multiple support
Date: Mon, 03 Oct 2005 09:35:02 -0400
Message-ID: <43413386.6000203@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:25288 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932230AbVJCNfB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 09:35:01 -0400
In-Reply-To: <43412FF6.5030006@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>

Albert Lee wrote:
> Patch 4/4: add read/write multiple support
> 

One "fine point" when programming the R/W MULT commands
is to remember that each register access is very costly
in terms of processor time.

So whenever an access can be done with 28-bit LBA,
it should not use the EXT versions of the instructions,
even though the device may be LBA48 capable.

The various drivers I have written for Linux and other OSs
that deal with this always logic equivalen to this somewhere:

if (lba_sector < (1<<28) && sector_count <= 256) {
     use LBA28
} else if (device is lba48 capable) {
     use LBA48
} else {
     error
}

For SATA drives, this is unlikely to make any difference,
but for PATA it can reduce the CPU overhead of issuing
a command by 40% or so --> saves three PCI bus transactions,
which amounts to about 1-4us real-time, depending on the
exact hardware in question.

I'm really looking forward to having PIO in libata,
so that we can support compactflash cards and the like.
My Delkin 32-bit Cardbus Adapter driver (currently in 2.4.x IDE)
will be one of the first new pure PIO drivers in libata..

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

