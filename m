From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/1] ata: Check and set 64-bit DMA mask for platform AHCI
 driver
Date: Thu, 12 Jun 2014 01:36:30 -0500
Message-ID: <53994A6E.9070403@amd.com>
References: <1400866510-3130-1-git-send-email-suravee.suthikulpanit@amd.com>
 <53977E79.2090000@redhat.com> <3571472.yt2eJCmG5L@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:53338
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750920AbaFLGgg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jun 2014 02:36:36 -0400
In-Reply-To: <3571472.yt2eJCmG5L@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Milburn <dmilburn@redhat.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On 06/11/2014 04:30 AM, Bartlomiej Zolnierkiewicz wrote:
>
> Hi,
>
> On Tuesday, June 10, 2014 04:54:01 PM David Milburn wrote:
>> On 05/23/2014 12:35 PM, suravee.suthikulpanit@amd.com wrote:
>>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>
>>> The current platform AHCI drier does not set the dma_mask correctly
>>> for 64-bit DMA capable AHCI controller.  This patch checks the AHCI
>>> capability bit and set the dma_mask and coherent_dma_mask accordingly.
>>>
>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>> ---
>>>    drivers/ata/libahci_platform.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index 7cb3a85..85049ef 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -368,6 +368,15 @@ int ahci_platform_init_host(struct platform_device *pdev,
>>
>> Hi Suravee,
>>
>> Would it be better to do the following before ahci_reset_controller()?
>>
>>           /* initialize adapter */
>>           rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
>>           if (rc)
>>                  	return rc;
>
> ahci_configure_dma_masks() is currently for PCI controllers only
> so it can't be used for libahci_platform.c.
>
> When it comes to setting DMA masks before ahci_reset_controller()
> I don't think that it matters but it will make platform code more
> similar to PCI one which is a good thing.

I can move this logic before ahci_reset_controller() in V2.

Suravee


