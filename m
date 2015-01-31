From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ata: libahci: Use of_platform_device_create only if supported
Date: Sat, 31 Jan 2015 08:53:36 -0800
Message-ID: <54CD0890.7050800@roeck-us.net>
References: <1422721938-1542-1-git-send-email-linux@roeck-us.net> <20150131164517.GB3088@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55684 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbAaQxl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jan 2015 11:53:41 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YHbIk-000AOO-4I
	for linux-ide@vger.kernel.org; Sat, 31 Jan 2015 16:53:42 +0000
In-Reply-To: <20150131164517.GB3088@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>

On 01/31/2015 08:45 AM, Tejun Heo wrote:
> On Sat, Jan 31, 2015 at 08:32:18AM -0800, Guenter Roeck wrote:
>> of_platform_device_create does not exist if OF_ADDRESS is not configured,
>> so limit its use accordingly.
>>
>> Without this fix, the sparc64:allmodconfig build fails with
>>
>> ERROR: "of_platform_device_create" [drivers/ata/libahci_platform.ko] undefined!
>>
>> Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Applies to -next.
>>
>>   drivers/ata/libahci_platform.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>> index 077c7a2..de9a5dc 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -434,7 +434,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
>>   			}
>>   			mask_port_map |= BIT(port);
>>
>> -			of_platform_device_create(child, NULL, NULL);
>> +			if (IS_ENABLED(CONFIG_OF_ADDRESS))
>> +				of_platform_device_create(child, NULL, NULL);
>
> This is weird.  Please either define a proper dummy version of the
> function in the appropriate header file or take out the whole
> invocation section w/ #ifndef.  The above is a weird hybrid where both
> the declaration and the user here are doing things half-way.  Please
> don't do this in other places either.
>

I agree, it is weird, as is the whole "all API functions associated
with OF_ADDRESS are handled differently on sparc" thing. But that
is neither new nor something I can fix.

No problem, I'll resubmit with #ifndef.

Guenter

