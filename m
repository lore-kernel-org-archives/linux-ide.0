From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata vs ATAPI
Date: Fri, 15 Oct 2004 13:17:09 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41700615.5060308@pobox.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com> <416C438C.4010902@pobox.com> <58cb370e0410121417591ecff0@mail.gmail.com> <20041012212225.GA2625@havoc.gtf.org> <58cb370e0410121436749e2bfb@mail.gmail.com> <416C5093.7050304@pobox.com> <20041015131339.GA1517@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30851 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268200AbUJORRW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Oct 2004 13:17:22 -0400
In-Reply-To: <20041015131339.GA1517@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

Jens Axboe wrote:
> On Tue, Oct 12 2004, Jeff Garzik wrote:
> 
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>>INQUIRY is done in PIO in ide-scsi and it works for this device
>>
>>I wouldn't mind doing non-read/write commands with PIO.  As long as the 
>>"fast path" commands are done via DMA...
> 
> 
> If by non-read/write you mean non-READ_X/WRITE_X, then I disagree very
> much. You just made cd ripping unbearable. SG_IO will use dma on ide-cd
> whenever possible right now.


Bart fixed that, awaiting patch resend...

	Jeff


