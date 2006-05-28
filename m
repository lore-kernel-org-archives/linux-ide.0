From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 20:56:19 -0400
Message-ID: <4478F533.9050101@rtr.ca>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca> <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca> <20060527225316.GA1075@suse.de> <4478DC67.6050800@rtr.ca> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org> <4478F484.4080908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:64180 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965017AbWE1A4V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 20:56:21 -0400
In-Reply-To: <4478F484.4080908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Linus Torvalds wrote:
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index fa476e7..6ccfbc9 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -4296,6 +4296,13 @@ static int ata_start_drive(struct ata_po
>>   */
>>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>>  {
>> +    /*
>> +     * Wait for BUSY to go away for up to 2 seconds,
>> +     * and then try to wait for idle (up to 1 msec)
>> +     */
>> +    ata_busy_wait(ap, ATA_BUSY, 200000);
>> +    ata_wait_idle(ap);
> 
> I don't object, but ata_wait_idle() is completely pointless.
> 
> ata_wait_idle() has nothing to do with DRDY.  It waits until both BSY 
> and DRQ are clear.  See:
>> u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);

Good point.  But I think Linus just mucked up his explanation,
as Jens has never used a patch to wait for DRDY, but rather only
to wait for DRQ to clear, same as the latest Linus patch does
(but in a different sequence from Linus's).

Good thing too, as waiting for DRDY would be silly for ATAPI drives.

Cheers
