From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata vs ATAPI
Date: Tue, 12 Oct 2004 17:45:55 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <416C5093.7050304@pobox.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com>	 <416C438C.4010902@pobox.com>	 <58cb370e0410121417591ecff0@mail.gmail.com>	 <20041012212225.GA2625@havoc.gtf.org> <58cb370e0410121436749e2bfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10165 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267921AbUJLVqL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Oct 2004 17:46:11 -0400
In-Reply-To: <58cb370e0410121436749e2bfb@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>

Bartlomiej Zolnierkiewicz wrote:
> INQUIRY is done in PIO in ide-scsi and it works for this device

I wouldn't mind doing non-read/write commands with PIO.  As long as the 
"fast path" commands are done via DMA...


>>>>>Unfortunately it doesn't help because atapi_pio_sector() assumes
>>>>>transfer length to be % SECTOR_SIZE and transfer length for INQUIRY
>>>>>is mere 36 bytes so this fails.
>>>>
>>>>Yes, you are welcome to fix this assumption.  :)
>>>
>>>Another bug in this area: bcount is set to 64 * 1024 (0xFFFF) but
>>>ATA/ATAPI spec defines max bcount as 0xFFFE and there must
>>>be some reason why ide-scsi limits it to 63 * 1024 and ide-cd to
>>>32 * 1024.
>>
>>bcount should be set to 8K (one SATA FIS) for PIO,
>>and 0xFFFF for DMA.  It's not used for DMA.
> 
> 
> According to ATA/ATAPI-5 spec bcount is ignored for
> non-PIO transfers.

Right.  In practice for some host controllers it should be set to 
0xffff.  It looks like I should change atapi_xlat() to do that.


> It sets bcount also for no-data which seems wrong.

well some "non-data" commands could still return sense, so I preferred 
to err on the side of caution.


>>Where is this code in libata?
> 
> atapi_xlat() in libata-scsi.c

I do not see code in atapi_xlat() that sets bcount to 0xffff?

	Jeff


