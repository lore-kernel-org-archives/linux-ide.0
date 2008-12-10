From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] libata: Add two more columns to the ata_timing table.
Date: Wed, 10 Dec 2008 15:12:41 +0300
Message-ID: <493FB239.3030506@ru.mvista.com>
References: <493DCBEA.9090007@caviumnetworks.com> <1228786798-20369-1-git-send-email-ddaney@caviumnetworks.com> <493FAB21.2030905@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25168 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750928AbYLJMMq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Dec 2008 07:12:46 -0500
In-Reply-To: <493FAB21.2030905@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Hello, I wrote:

>> timing values than were available in the ata_timing table.  I add new
>> columns for write_hold and dmack_hold times.  The values were obtained
>> from the Compact Flash specification Rev 4.1.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>   
> The forthcoming OCTEON SOC Compact Flash driver needs a few more
>
>   Well, you got it right except fot the SWDMA modes. :-)
>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 5e2eb74..b156d83 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -2953,33 +2953,33 @@ int sata_set_spd(struct ata_link *link)   
> [...]
>> +    { XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 30, 20, 960,   0 },
>> +    { XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 20, 480,   0 },
>> +    { XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 15, 20, 240,   0 },
>>   
>
>   Well, I don't know what CF 4.1 has but ATA/ATA-2 have minimum -DIOx 
> to -DMACK hold time (tJ) for SW DMA modes always 0 ns, and -DIOW data 
> hold time (tH) of 50, 30, and 20 for modes 0, 1, and 2 respectfully.

   Well, the correctness of these values shouldn't matter much because 
IIRC libata have dropped support for SWDMA completely...

MBR, Sergei


