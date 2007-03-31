From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/4] libata: Clear tf before doing request sense
Date: Sat, 31 Mar 2007 15:44:46 +0800
Message-ID: <460E116E.9060309@tw.ibm.com>
References: <460E08AF.8070900@tw.ibm.com> <460E0AF9.1090007@tw.ibm.com> <460E0D4F.1070005@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:43740 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbXCaHo6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 03:44:58 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2V7gsPG013586
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 03:42:54 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2V7iw90133728
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 01:44:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2V7iuI6012201
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 01:44:57 -0600
In-Reply-To: <460E0D4F.1070005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, IDE Linux <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Albert Lee wrote:
> 
>> diff -Nrup 01_hsm_st/drivers/ata/libata-eh.c
>> 02_aopen_rs/drivers/ata/libata-eh.c
>> --- 01_hsm_st/drivers/ata/libata-eh.c    2007-03-23 16:56:13.000000000
>> +0800
>> +++ 02_aopen_rs/drivers/ata/libata-eh.c    2007-03-31
>> 01:11:01.000000000 +0800
>> @@ -991,18 +991,19 @@ static unsigned int atapi_eh_request_sen
>>  
>>      DPRINTK("ATAPI request sense\n");
>>  
>> -    ata_tf_init(dev, &tf);
>> -
>>      /* FIXME: is this needed? */
>>      memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
>>  
>> -    /* XXX: why tf_read here? */
>> +    /* read error register to initialize sense_buf */
>>      ap->ops->tf_read(ap, &tf);
>>  
>>      /* fill these in, for the case where they are -not- overwritten */
>>      sense_buf[0] = 0x70;
>>      sense_buf[2] = tf.feature >> 4;
> 
> 
> Oh, now I see why it's there.  Thanks for spotting this.  We don't need
> tf_read here, you can simply use the value in qc->result_tf.feature for
> this purpose.
> 

Thanks for the advice. Will revise this patch.
--
albert

