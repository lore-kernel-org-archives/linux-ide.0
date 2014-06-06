From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/1] ata: Check and set 64-bit DMA mask for platform AHCI
 driver
Date: Fri, 6 Jun 2014 11:10:58 -0500
Message-ID: <5391E812.1060009@amd.com>
References: <1400866510-3130-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140603175827.GH26210@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2lp0212.outbound.protection.outlook.com ([207.46.163.212]:44308
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751693AbaFFQLc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Jun 2014 12:11:32 -0400
In-Reply-To: <20140603175827.GH26210@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hans/Bartlomiej,

Do you guys have any questions about this patch?

Thank you,

Suravee

On 6/3/2014 12:58 PM, Tejun Heo wrote:
> Hans, Bartlomiej, can you guys please review this patch?
>
> Thanks.
>
> On Fri, May 23, 2014 at 12:35:10PM -0500, suravee.suthikulpanit@amd.com wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> The current platform AHCI drier does not set the dma_mask correctly
>> for 64-bit DMA capable AHCI controller.  This patch checks the AHCI
>> capability bit and set the dma_mask and coherent_dma_mask accordingly.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> ---
>>   drivers/ata/libahci_platform.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>> index 7cb3a85..85049ef 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -368,6 +368,15 @@ int ahci_platform_init_host(struct platform_device *pdev,
>>   	ahci_init_controller(host);
>>   	ahci_print_info(host, "platform");
>>
>> +	if (hpriv->cap & HOST_CAP_64) {
>> +		if (!dev->dma_mask)
>> +			dev->dma_mask = &dev->coherent_dma_mask;
>> +
>> +		rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +		if (rc)
>> +			return rc;
>> +	}
>> +
>>   	return ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
>>   				 &ahci_platform_sht);
>>   }
>> --
>> 1.9.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


