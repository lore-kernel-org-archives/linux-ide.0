From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/2] ahci: Check and set 64-bit DMA mask for platform
 AHCI driver
Date: Fri, 13 Jun 2014 07:45:12 -0500
Message-ID: <539AF258.1080202@amd.com>
References: <1402594824-4151-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1402594824-4151-2-git-send-email-suravee.suthikulpanit@amd.com>
 <5399E7AD.8030901@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1lp0144.outbound.protection.outlook.com ([207.46.163.144]:45335
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750784AbaFMMpc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2014 08:45:32 -0400
In-Reply-To: <5399E7AD.8030901@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, tj@kernel.org, b.zolnierkie@samsung.com
Cc: hdegoede@redhat.com, lho@apm.com, tphan@apm.com, stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/12/2014 12:47 PM, Sergei Shtylyov wrote:
>> diff --git a/drivers/ata/libahci_platform.c
>> b/drivers/ata/libahci_platform.c
>> index 3a5b4ed..a958a2b 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -364,6 +364,19 @@ int ahci_platform_init_host(struct
>> platform_device *pdev,
>>               ap->ops = &ata_dummy_port_ops;
>>       }
>>
>> +    if (hpriv->cap & HOST_CAP_64) {
>> +        rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +        if (rc) {
>> +            rc = dma_coerce_mask_and_coherent(dev,
>> +                              DMA_BIT_MASK(32));
>> +            if (rc) {
>> +                dev_err(dev, "Failed to enable 64-bit DMA.\n");
>
>     Not 32-bit?
Actually, I intended to say 64 since this is supposed to be setting up 
64-bit DMA mask. Or we could just say failed to set up DMA mask.

Suravee

