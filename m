From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [V6 PATCH 2/3] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Thu, 26 Mar 2015 09:39:48 -0500
Message-ID: <55141A34.6030402@amd.com>
References: <1427316368-20965-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1427316368-20965-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150326102941.GF1878@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150326102941.GF1878@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: rjw@rjwysocki.net, robert.moore@intel.com, lv.zheng@intel.com, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-ide@vger.kernel.org



On 3/26/15 05:29, Mika Westerberg wrote:
> On Wed, Mar 25, 2015 at 03:46:07PM -0500, Suravee Suthikulpanit wrote:
>> [...]
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> index e530533..9563abe 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -189,8 +189,12 @@ struct css_device_id {
>>   struct acpi_device_id {
>>   	__u8 id[ACPI_ID_LEN];
>>   	kernel_ulong_t driver_data;
>> +	__u32 cls;
>> +	__u32 cls_msk;
>>   };
>>
>> +#define ACPI_DEVICE_CLASS(cls, msk)		"", 0, cls, msk
>
> Consider moving this to <linux/acpi.h>, just like PCI_DEVICE_CLASS() is
> defined in <linux/pci.h>.
>
> Also please use designated initializers here, eg:
>
> #define ACPI_DEVICE_CLASS(cls, msk)	.cls = (cls), .cls_mask = (msk)
>
> Once done you can add my,
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Ah right. I should have done that. I'll send out V7 with this change and 
acked-by.

Thanks,
Suravee
>
>> +
>>   #define PNP_ID_LEN	8
>>   #define PNP_MAX_DEVICES	8
