From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata vs ATAPI
Date: Tue, 12 Oct 2004 16:50:20 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <416C438C.4010902@pobox.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47537 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267807AbUJLUuo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Oct 2004 16:50:44 -0400
In-Reply-To: <58cb370e04101213215ce9a23c@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote:
> Hi Jeff,
> 
> Is libata currently supposed to work with ATAPI
> (I know about lack of REQUEST_SENSE support)?
> 
> With ATA_ENABLE_ATAPI defined INQUIRY seems to succeed for my
> TOSHIBA ODD-DVD SD-R6372 but empty info is printed by SCSI layer.

I get this too


> Then REPORT_LUNS errors out (dev_stat = 0x51)...

This doesn't surprise me, I bet that many ATAPI devices might not like 
REPORT LUNS


> I've noticed that DMA is used by default for all packet commands
> which doesn't seem to be wise thing to do so I disabled it.

DMA is _never_ used for packet commands, only for packet data.

libata enables DMA at the maximum level supported by both the device and 
host controller.  I definitely want to do this by default.


> Unfortunately it doesn't help because atapi_pio_sector() assumes
> transfer length to be % SECTOR_SIZE and transfer length for INQUIRY
> is mere 36 bytes so this fails.

Yes, you are welcome to fix this assumption.  :)

> Also ATAPI-SCSI emulation is still missing in libata-scsi.c.

I wish to minimize the emulation.  That means no read/write emulation, 
just modify INQUIRY to report MMC, and do auto-sense (as it is presented 
to the SCSI layer).


> I'm sure you know more about what needs to be done.
> Could you make some nice, detailed TODO? :-)

Pat LaVarre had IOmega ATAPI devices working, once he hand-hacked 
REQUEST SENSE.  As for to-do list, I think this email covers it.  Here's 
a summary...

* possibly avoid REPORT LUNS for ATAPI devices
* when check condition occurs, automatically request sense inside 
driver, and put that data into the sense buffer
* make INQUIRY report SCSI version MMC-3 (or later...)
* support strange sector sizes

	Jeff


