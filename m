From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [Linaro-acpi] [RFC PATCH 2/2] ata: ahci_platform: Add ACPI _CLS
 matching
Date: Fri, 19 Dec 2014 12:21:47 -0600
Message-ID: <54946CBB.4050108@amd.com>
References: <1418858195-22857-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1418858195-22857-3-git-send-email-suravee.suthikulpanit@amd.com>
 <3408260.hhf4YMy6F6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3408260.hhf4YMy6F6@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 12/18/2014 3:17 AM, Arnd Bergmann wrote:
> On Wednesday 17 December 2014 17:16:35 Suravee Suthikulpanit wrote:
>> +#ifdef CONFIG_ATA_ACPI
>> +#include <linux/acpi.h>
>> +#endif
>>   #include "ahci.h"
>>
>>   static const struct ata_port_info ahci_port_info = {
>> @@ -71,6 +74,10 @@ static const struct of_device_id ahci_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, ahci_of_match);
>>
>> +#ifdef CONFIG_ATA_ACPI
>> +static const struct acpi_device_cls ahci_cls = {0x01, 0x06, 0x01};
>> +#endif
>> +
>>   static struct platform_driver ahci_driver = {
>>          .probe = ahci_probe,
>>          .remove = ata_platform_remove_one,
>> @@ -78,6 +85,9 @@ static struct platform_driver ahci_driver = {
>>                  .name = "ahci",
>>                  .owner = THIS_MODULE,
>>                  .of_match_table = ahci_of_match,
>> +#ifdef CONFIG_ATA_ACPI
>> +               .acpi_cls = &ahci_cls,
>> +#endif
>>                  .pm = &ahci_pm_ops,
>>
>
> It would be better to leave out the various #ifdef here, in particular the
> one around the header file inclusion.
>
> 	Arnd
>

Right. I'll get rid of them. Also, I noticed that I should have declared 
acpi_match_device_cls() in include/linux/acpi.h as "inline" for when 
building w/o ACPI to avoid warning messages.

Thanks,

Suravee
