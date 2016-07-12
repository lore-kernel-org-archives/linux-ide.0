From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] ata: hpt366: fix incorrect mask when checking at
 cmd_high_time
Date: Tue, 12 Jul 2016 12:33:12 +0100
Message-ID: <5784D578.9000702@canonical.com>
References: <1468322179-9398-1-git-send-email-colin.king@canonical.com>
 <2928643.x6ZsLjxZ9e@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2928643.x6ZsLjxZ9e@amdc1976>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

On 12/07/16 12:27, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, July 12, 2016 12:16:19 PM Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> According to the HPT366 data sheet, PCI config space dword 0x40-0x43
>> bits 11:8 specify the primary drive cmd_high_time, however,
>> currently just 3 bits of the 4 are being used because the mask
>> is 0x700 and not 0x0f00.  Fix the mask, allowing for the 40MHz clock
>> to be detected.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Thanks for the patch, could you also fix also the old driver
> (drivers/ide/hpt366.c)?

Yep, patch already sent.

https://lkml.org/lkml/2016/7/12/199

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> ---
>>  drivers/ata/pata_hpt366.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
>> index e5fb752..a219a50 100644
>> --- a/drivers/ata/pata_hpt366.c
>> +++ b/drivers/ata/pata_hpt366.c
>> @@ -368,7 +368,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>>  
>>  	/* PCI clocking determines the ATA timing values to use */
>>  	/* info_hpt366 is safe against re-entry so we can scribble on it */
>> -	switch ((reg1 & 0x700) >> 8) {
>> +	switch ((reg1 & 0xf00) >> 8) {
>>  	case 9:
>>  		hpriv = &hpt366_40;
>>  		break;
> 
