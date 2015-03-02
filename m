From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: Re: [V4 PATCH 2/2] ata: ahci_platform: Add ACPI _CLS matching
Date: Mon, 2 Mar 2015 16:52:17 +0000
Message-ID: <D119F11E.132ED%suravee.suthikulpanit@amd.com>
References: <20150302164103.GH17694@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302164103.GH17694@htj.duckdns.org>
Content-Language: en-US
Content-ID: <9AAF8362201F49438A5446EE0FB8D53E@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "hpa@linux.intel.com" <hpa@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Duran, Leo" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-ide@vger.kernel.org



On 3/2/15, 10:41, "Tejun Heo" <tj@kernel.org> wrote:

>On Mon, Mar 02, 2015 at 02:27:20AM -0600, Suravee Suthikulpanit wrote:
>> This patch adds ACPI supports for AHCI platform driver, which uses _CLS
>> method to match the device.
>> 
>> The following is an example of ASL structure in DSDT for a SATA
>>controller,
>> which contains _CLS package to be matched by the ahci_platform driver:
>> 
>>   Device (AHC0) // AHCI Controller
>>   {
>>     Name(_HID, "AMDI0600")
>>     Name (_CCA, 1)
>>     Name (_CLS, Package (3)
>>     {
>>       0x01, // Base Class: Mass Storage
>>       0x06, // Sub-Class: serial ATA
>>       0x01, // Interface: AHCI
>>     })
>>     Name (_CRS, ResourceTemplate ()
>>     {
>>       Memory32Fixed (ReadWrite, 0xE0300000, 0x00010000)
>>       Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive,,,) {
>>387 }
>>     })
>>   }
>> 
>> Also, since ATA driver should not require PCI support for ATA_ACPI,
>> this patch removes dependency in the driver/ata/Kconfig.
>> 
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>
>Looks good to me from the libata side.
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
>Please let me now if this needs to go through libata.
>
>Thanks.
>
>-- 
>tejun

Thank you. I will let you know one the whole series is ready.

Suravee
