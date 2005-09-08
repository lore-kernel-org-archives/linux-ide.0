From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 0/2] libata: ata_pio_task() accessing 'ap->pio_task_state'
 fix
Date: Thu, 08 Sep 2005 14:25:47 +0800
Message-ID: <431FD96B.3050801@tw.ibm.com>
References: <43187433.9080204@tw.ibm.com> <431E7D76.60003@pobox.com> <431EBAD7.40801@tw.ibm.com> <431F891C.6050000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.130]:5814 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932658AbVIHG0G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Sep 2005 02:26:06 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j886PtKL355296
	for <linux-ide@vger.kernel.org>; Thu, 8 Sep 2005 02:25:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j886PtTr325982
	for <linux-ide@vger.kernel.org>; Thu, 8 Sep 2005 00:25:55 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j886PsaJ024364
	for <linux-ide@vger.kernel.org>; Thu, 8 Sep 2005 00:25:54 -0600
In-Reply-To: <431F891C.6050000@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:

> Albert Lee wrote:
>
>> Only one minor addition for your review:
>>
>> * ata_pio_block() changed to go to PIO_ST_LAST state, instead of
>>   going to PIO_ST_IDLE state directly and calling 
>> ata_poll_qc_complete().
>>
>> i.e.
>> @@ -2845,9 +2852,7 @@
>>     if (is_atapi_taskfile(&qc->tf)) {
>>         /* no more data to transfer or unsupported ATAPI command */
>>         if ((status & ATA_DRQ) == 0) {
>> -            ap->pio_task_state = PIO_ST_IDLE;
>> -
>> -            ata_poll_qc_complete(qc, status);
>> +            ap->pio_task_state = PIO_ST_LAST;
>>             return;
>>         }
>
>
> hmmmm.  I think that should be PIO_ST_ERR not PIO_ST_LAST.  Comments?
>

Just tested it. Changing to PIO_ST_ERR will break REQUEST_SENSE and 
MODE_SENSE. :(
For REQUEST_SENSE and MODE_SENSE, the data returned from the device might be
less than the buffer provided and those two commands relies on DRQ == 0 
to mark the end of
the data transfer.

e.g. a sample REQUST SENSE transaction:
 1. ata_pio_task() entered with PIO_ST.
 2. ata_pio_block() called, 24 bytes received from the device.
 3. The buffer size is 96 bytes, so the state is kept as PIO_ST.
 4. ata_pio_task() entered with PIO_ST.
 5. ata_pio_block() called, DRQ == 0 to mark the end of data transfer.
 6. state changed to PIO_ST_LAST and command completed as successful.

DRQ == 0 in step 5 seems to be normal and should be treated as OK.

Albert

