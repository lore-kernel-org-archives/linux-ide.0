From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata: use polling pio for identify device
Date: Tue, 23 May 2006 10:27:24 +0800
Message-ID: <4472730C.3090800@tw.ibm.com>
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <446C5957.9040404@tw.ibm.com> <446C5B83.9000305@gmail.com> <446D9FCD.5050907@tw.ibm.com> <446DA604.8040207@gmail.com> <4471354C.5090201@tw.ibm.com> <44715907.7060602@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:42385 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751259AbWEWC1Z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 May 2006 22:27:25 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4N2RONS022245
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 22:27:24 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4N2ROXb267412
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 20:27:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4N2RNKK008064
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 20:27:24 -0600
In-Reply-To: <44715907.7060602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:
> Albert Lee wrote:
> 
>> Use polling pio for identify device.
>> This can save some time to detect the phantom device 1 during boot.
>>
>> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>> ---
>> For the phantom slave device (found with some IBM DVD-RAM drive and
>> Intel ICHx chip), irq-pio has to wait 30 seconds timeout to detect them.
>>
>> Use polling pio can detect the phantom slave quicker. (Verified ok by
>> Tejun.)
>>
>> Patch again the current upstream branch
>> (b74ba22f030eb7ab88f7d8954ad18ecc0ac5ce3c).
>> For your review, thanks.
>>
>> --- upstream/drivers/scsi/libata-core.c    2006-05-22
>> 10:04:12.000000000 +0800
>> +++ polling_identify/drivers/scsi/libata-core.c    2006-05-22
>> 11:07:02.000000000 +0800
>> @@ -1196,6 +1196,8 @@ static int ata_dev_read_id(struct ata_de
>>      }
>>  
>>      tf.protocol = ATA_PROT_PIO;
>> +    /* Use polling for early detection of phantom dev 1 */
>> +    tf.flags |= ATA_TFLAG_POLLING;
> 
> 
> Sorry I didn't jump into the thread earlier.  I'm trying out this new
> no-work-on-weekends thing, which is a change from my usual
> working-7-days-a-week thing.  :)
> 
> NAK.  The above change is going backwards from the direction we took by
> merging irq-pio, and it reintroduces problems that irq-pio solved.
> Additionally, for irq problems unrelated to libata (we will continue to
> see such problems FOREVER), this simply shifts the I-notice-a-problem
> moment from IDENTIFY DEVICE to SET FEATURES, or perhaps the first READ
> or WRITE.

Currently if the device fails to IDENTIFY DEVICE, new EH will retry
for 3 times and offline it. So, the faulty/phantom device won't
cause trouble to SET FEATURES and normal operation of libata.

(The impact is, 90 seconds boot time for irq-pio and 15 seconds
boot time for polling-pio to IDENTIFY DEVICE and EH recovery.)

> 
> SATA is inherently event driven (read: irq-driven), and PATA has
> traditionally been irq-driven in the Linux drivers/ide code.  Using
> polling for solving this specific problem just isn't enough
> justification.  We should be able to fix this elsewhere.  Take a look at
> the drivers/ide "bang at the door w/ IDENTIFY" probing method.  We took
> a different approach (device signature, etc.) but its still a useful
> working case to examine.

Agree. We need better way to identify the phantom slave.
Will check if any clue we can use, before banging the door by IDENTIFY.

--
albert

> 
> As an aside, phantom devices make me think that somewhere we might be
> getting device-select wrong, or accidentally skipping it entirely.
> 
>     Jeff
> 


