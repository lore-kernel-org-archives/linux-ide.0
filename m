From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 13/22] libata: implement qc->result_tf
Date: Thu, 18 May 2006 15:53:33 +0800
Message-ID: <446C27FD.1000400@tw.ibm.com>
References: <11473487911193-git-send-email-htejun@gmail.com> <446C20A4.7020204@tw.ibm.com> <446C21CF.3020900@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:62886 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750737AbWERHxg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 03:53:36 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4I7rZph009630
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 03:53:35 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4I7rZBl183724
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 01:53:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4I7rXeb031400
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 01:53:34 -0600
In-Reply-To: <446C21CF.3020900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Albert Lee wrote:
> 
>> This patch makes qc->tf well preserved, except we still have
>> qc->tf got overwritten by ata_pio_bytes().
>>
>> Maybe we also need the attached follow-up patch?
>>
>> -- 
>> albert
>>
>> --- 02_atapi_pio_bytes/drivers/scsi/libata-core.c    2006-05-18
>> 14:20:32.000000000 +0800
>> +++ 03_atapi_pio_bytes/drivers/scsi/libata-core.c    2006-05-18
>> 14:25:41.000000000 +0800
>> @@ -3861,10 +3861,10 @@ static void atapi_pio_bytes(struct ata_q
>>      unsigned int ireason, bc_lo, bc_hi, bytes;
>>      int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
>>  
>> -    ap->ops->tf_read(ap, &qc->tf);
>> -    ireason = qc->tf.nsect;
>> -    bc_lo = qc->tf.lbam;
>> -    bc_hi = qc->tf.lbah;
>> +    ap->ops->tf_read(ap, &qc->result_tf);
>> +    ireason = qc->result_tf.nsect;
>> +    bc_lo = qc->result_tf.lbam;
>> +    bc_hi = qc->result_tf.lbah;
>>      bytes = (bc_hi << 8) | bc_lo;
>>  
>>      /* shall be cleared to zero, indicating xfer of data */
>>
> 
> I actually think above should be done with local variable.  It's not
> comannd TF nor result TF.
> 

You're right. But local variable adds 18+ extra bytes to the kernel stack.
And
- For normal completion, qc->result_tf is not relevant.
- For error, qc->result_tf is later overwritten by ata_qc_complete().
Maybe we can use qc->result_tf for temp storage of intermediate TF here
and save some stack usage?

--
albert



