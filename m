From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata atapi work #2.1
Date: Mon, 17 May 2004 13:57:45 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A8FD19.8050906@pobox.com>
References: <1084721991.3085.6.camel@patibmrh9> <40A7F757.9020200@pobox.com> <1084805767.3083.10.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1937 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262003AbUEQR6B
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 13:58:01 -0400
In-Reply-To: <1084805767.3083.10.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>>Please let me know what patches (if any
>>besides #define) are needed for setup, after
>>you include patch #2.2 and #2.3 in the pile.
> 
> 
> I will revert to -bk3 vanilla, then apply 2.* from linux-ide, then
> report back.

Last night's -bk4 should include everything except the obvious patch to 
include/linux/libata.h to define ATAPI_ENABLE_DMADIR.


> I will have to discover how to auto sense only after a plain failure,
> not inappropriately after a timeout.  Last I checked, the code was
> written to see any failure as if it were a timeout.

Good guess, very close:  the code is written to see any timeout as if it 
were a failure.  Calling ata_eng_timeout() function is unfortunately a 
bit misnamed.


>>* in INQUIRY output, simulate compliance with
>>MMC-3.  Linux SCSI stack is not aware that all
>>ATAPI devices report zeroes in the SCSI version
>>field (as do some USB storage devices).  So,
>>we fake it.
> 
> 
> I will try to munge the otherwise transparent pass thru of op x12
> "INQUIRY" after the pattern of:
> 
> http://lxr.linux.no/source/drivers/usb/storage/protocol.c?v=2.6.5#L62
> 
> 62 static void fix_inquiry_data(Scsi_Cmnd *srb)
> ...
> 82         /* Change the SCSI revision number */
> 83         databuf[2] = (databuf[2] & ~7) | 2;

Yes, something like this is needed.

We need to indicated MMC-3...

	Jeff



