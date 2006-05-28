From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] 2.6.17-rc5: the latest consensus libata resume fix
Date: Sun, 28 May 2006 15:05:43 -0400
Message-ID: <4479F487.5080507@garzik.org>
References: <200605272245.30108.axboe@suse.de> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org> <4478F681.8050607@garzik.org> <200605281128.00532.liml@rtr.ca> <20060528171424.GA12982@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:18091 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750867AbWE1TFx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 May 2006 15:05:53 -0400
In-Reply-To: <20060528171424.GA12982@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Mark Lord <liml@rtr.ca>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Sun, May 28 2006, Mark Lord wrote:
>> Okay, just to sum things up.
>>
>> The patch below is the current "release candidate" for
>> improving the libata/ata_piix resume functionality in 2.6.17-rc*.
>>
>> It forces libata to wait for up to 2 seconds for BUSY|DRQ to clear
>> on resume before continuing.  This is only for 2.6.17 at present.
>>
>> We are waiting on Jens to test and report back for this specific version.
>>
>> Signed-off-by:  Mark Lord <liml@rtr.ca>
>> ---
>> --- linux-2.6.17-rc5/drivers/scsi/libata-core.c
>> +++ linux/drivers/scsi/libata-core.c
>> @@ -4296,6 +4296,7 @@ static int ata_start_drive(struct ata_po
>>   */
>>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>>  {
>>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
>> +		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
>>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
>>  		ata_set_mode(ap);
> 
> Sorry for the unresponsiveness, still away and internet connectivity
> spotty. Just tested the above, and it works for me! I think Marks
> analisys wrt DRQ is completely correct and this validates it.

Does your box work without ATA_DRQ?

	Jeff



