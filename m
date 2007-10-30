From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: [PATCH 2.6.24-rc1] sata_promise: ASIC PRD table bug workaround
Date: Tue, 30 Oct 2007 09:09:27 +0300
Message-ID: <4726CA97.3030609@lxnt.info>
References: <200710291550.l9TFocYf018050@harpo.it.uu.se> <47262F5A.8070804@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:52732 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbXJ3GJR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 02:09:17 -0400
In-Reply-To: <47262F5A.8070804@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mikael Pettersson wrote:
  >> @@ -530,7 +608,7 @@ static void pdc_qc_prep(struct ata_queue
>>  
>>      switch (qc->tf.protocol) {
>>      case ATA_PROT_DMA:
>> -        ata_qc_prep(qc);
>> +        pdc_fill_sg(qc);
>>          /* fall through */
>>  
>>      case ATA_PROT_NODATA:
>> @@ -546,11 +624,11 @@ static void pdc_qc_prep(struct ata_queue
>>          break;
>>  
>>      case ATA_PROT_ATAPI:
>> -        ata_qc_prep(qc);
>> +        pdc_fill_sg(qc);
>>          break;
>>  
>>      case ATA_PROT_ATAPI_DMA:
>> -        ata_qc_prep(qc);
>> +        pdc_fill_sg(qc);
>>          /*FALLTHROUGH*/
> 
> Note that this is not exactly an equivalent change -- you are removing 
> the test in ata_qc_prep() that occurs prior to ata_fill_sg() call.

Not at all. The test is there at the beginning of pdc_fill_sg().


-- 

./lxnt




