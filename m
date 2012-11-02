From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 04/14] libata: implement ata_platform_remove_one()
Date: Fri, 2 Nov 2012 12:05:13 -0700
Message-ID: <CAN8TOE-CaMxXgu+rZAkQPxtTgCOBuHqOkeVxq+AsTuXrLCB4Cw@mail.gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
	<1351842388-27210-5-git-send-email-computersforpeace@gmail.com>
	<5093A95D.6090403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:46522 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab2KBTFO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 15:05:14 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2872195iag.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 12:05:13 -0700 (PDT)
In-Reply-To: <5093A95D.6090403@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On Fri, Nov 2, 2012 at 4:07 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> On 02-11-2012 11:46, Brian Norris wrote:
>
>> This relatively simple boiler-plate code is repeated in several platform
>> drivers. We should implement a common version in libata.
>
>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>> ---
>>   drivers/ata/libata-core.c | 23 +++++++++++++++++++++++
>>   include/linux/libata.h    |  4 ++++
>>   2 files changed, 27 insertions(+)
>
>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 611050d..820e47f 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>
> [...]
>
>> @@ -6350,6 +6351,26 @@ int ata_pci_device_resume(struct pci_dev *pdev)
>>
>>   #endif /* CONFIG_PCI */
>>
>> +/**
>> + *      ata_platform_remove_one- Platform layer callback for device
>> removal
>> + *      @pdev: Platform device that was removed
>> + *
>> + *      Platform layer indicates to libata via this hook that hot-unplug
>> or
>> + *      module unload event has occurred.  Detach all ports.  Resource
>> + *      release is handled via devres.
>> + *
>> + *      LOCKING:
>> + *      Inherited from platform layer (may sleep).
>> + */
>> +int ata_platform_remove_one(struct platform_device *pdev)
>> +{
>> +        struct ata_host *host = platform_get_drvdata(pdev);
>> +
>> +        ata_host_detach(host);
>
>
>    Indent with tabs, not spaces, as below.

I need to remind myself to run checkpatch.pl more often. Thanks for
pointing this out. Will send v2. (Also, patch 12 had a pre-existing
indentation problem; I'll fix it for the line I change.)

Brian
