From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Date: Tue, 25 Nov 2008 08:46:06 -0800
Message-ID: <492C2BCE.60409@caviumnetworks.com>
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com> <492BDB28.8020103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:65434 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbYKYQqo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 11:46:44 -0500
In-Reply-To: <492BDB28.8020103@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Sergei Shtylyov wrote:
> Hello.
> 
> David Daney wrote:
> 
>> The forthcoming OCTEON SOC Compact Flash driver needs a few more
>> timing values than were available in the ata_timing table.  I add new
>> columns for write_hold, read_hold, and read_holdz times.  The values
>> were obtained from the Compact Flash specification Rev 4.1.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>   
> 
>   Not quite correct...
> 
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 4214bfb..b29b7df 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -2946,33 +2946,33 @@ int sata_set_spd(struct ata_link *link)
>>   */
>>  
>>  static const struct ata_timing ata_timing[] = {
>>   
> [...]
>> +/*    { XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 30, 5, 30, 
>> 960,   0 }, */
>> +    { XFER_PIO_0,     70, 290, 240, 600, 165, 150, 30, 5, 30, 600,   
>> 0 },
>> +    { XFER_PIO_1,     50, 290,  93, 383, 125, 100, 20, 5, 30, 383,   
>> 0 },
>> +    { XFER_PIO_2,     30, 290,  40, 330, 100,  90, 15, 5, 30, 240,   
>> 0 },
>> +    { XFER_PIO_3,     30,  80,  70, 180,  80,  70, 10, 5, 30, 180,   
>> 0 },
>> +    { XFER_PIO_4,     25,  70,  25, 120,  70,  25, 10, 5, 30, 120,   
>> 0 },
>> +    { XFER_PIO_5,     15,  65,  25, 100,  65,  25,  5, 5, 20, 100,   
>> 0 },
>> +    { XFER_PIO_6,     10,  55,  20,  80,  55,  20,  5, 5, 20,  80,   
>> 0 },
>> +
>> +    { XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 30, 5, 0,  960,   
>> 0 },
>> +    { XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 5, 0,  480,   
>> 0 },
>> +    { XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 15, 5, 0,  240,   
>> 0 },
>> +
>> +    { XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 20, 20, 0, 480,   
>> 0 },
>>   
> 
>   Wrong, -DIOR hold time is 5 ns for MWDMA0 as well as for all other modes.

Point taken.

> 
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 59b0f1c..7c44e45 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>>   
> [...]
>> @@ -863,6 +868,9 @@ struct ata_timing {
>>      unsigned short cyc8b;        /* t0 for 8-bit I/O */
>>      unsigned short active;        /* t2 or tD */
>>      unsigned short recover;        /* t2i or tK */
>> +    unsigned short write_hold;    /* t4 */
>> +    unsigned short read_hold;    /* t6 */
>>   
> 
>   -DIOR hold time is 5 ns for all PIO and MWDMA modes -- there's no 
> sense in storing it here.
> 

By storing it here, ata_timing_compute() will compute the bus clock 
counts for me.  Makes perfect sense to me.


>> +    unsigned short read_holdz;    /* t6z  or tj */
>>   
> 
>   T6z and Tj are not the same timing. Well, you specify it as 0 for  DMA 
> modes anyway...
> 

I had intended to overload this column for DMA, but somehow screwed it 
up.  For my next patch I plan to populate this column for DMA modes.

David Daney

