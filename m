From: Greg Dietsche <gregory.dietsche@cuw.edu>
Subject: Re: [PATCH] ata: remove unnecessary code
Date: Tue, 19 Jul 2011 21:14:28 -0500
Message-ID: <4E263A04.3030207@cuw.edu>
References: <1308242361-28859-1-git-send-email-Gregory.Dietsche@cuw.edu> <4E263769.9040500@cuw.edu> <4E2638FB.4080103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta31.charter.net ([216.33.127.82]:55170 "EHLO
	mta31.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab1GTCO2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jul 2011 22:14:28 -0400
In-Reply-To: <4E2638FB.4080103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, tj@kernel.org



On 07/19/2011 09:10 PM, Jeff Garzik wrote:
> On 07/19/2011 10:03 PM, Greg Dietsche wrote:
>>
>>
>> On 06/16/2011 11:39 AM, Greg Dietsche wrote:
>>> Compile tested.
>>> remove unnecessary code that matches this coccinelle pattern
>>> if (...)
>>> return ret;
>>> return ret;
>>>
>>> Signed-off-by: Greg Dietsche<Gregory.Dietsche@cuw.edu>
>>
>> Acked-by: Tejun Heo<tj@kernel.org>
>>
>>
>>> ---
>>> drivers/ata/pata_acpi.c | 8 +-------
>>> 1 files changed, 1 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
>>> index 91949d9..54145ed 100644
>>> --- a/drivers/ata/pata_acpi.c
>>> +++ b/drivers/ata/pata_acpi.c
>>> @@ -195,8 +195,6 @@ static int pacpi_port_start(struct ata_port *ap)
>>> struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>>> struct pata_acpi *acpi;
>>>
>>> - int ret;
>>> -
>>> if (ap->acpi_handle == NULL)
>>> return -ENODEV;
>>>
>>> @@ -205,11 +203,7 @@ static int pacpi_port_start(struct ata_port *ap)
>>> return -ENOMEM;
>>> acpi->mask[0] = pacpi_discover_modes(ap,&ap->link.device[0]);
>>> acpi->mask[1] = pacpi_discover_modes(ap,&ap->link.device[1]);
>>> - ret = ata_bmdma_port_start(ap);
>>> - if (ret< 0)
>>> - return ret;
>>> -
>>> - return ret;
>>> + return ata_bmdma_port_start(ap);
>>> }
>>>
>>> static struct scsi_host_template pacpi_sht = {
>> This was acked by TJ, but seems to be lost in the shuffle thus far. I'm
>> adding trivial@kernel.org to the cc list since this is trivial and no
>> one has picked up this patch to date.
>
> It's in libata-dev, so it's been picked up...
>
> We are in -rc, so it won't show up in a kernel until 3.0 is released, 
> and the merge window opens again.
>
>     Jeff
>
ok, sorry about that! I'd been watching the linux-next tree to see which 
things were picked up so far.

Greg
