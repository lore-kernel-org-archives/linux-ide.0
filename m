From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [RFC PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Fri, 19 Dec 2014 13:33:28 -0600
Message-ID: <54947D88.90306@amd.com>
References: <1418858195-22857-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1418858195-22857-2-git-send-email-suravee.suthikulpanit@amd.com>
 <54943CB5.2030206@linaro.org> <549472C6.9090908@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <549472C6.9090908@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org
Cc: leo.duran@amd.com, graeme.gregory@linaro.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-ide@vger.kernel.org

On 12/19/2014 12:47 PM, Suravee Suthikulanit wrote:
> On 12/19/2014 8:56 AM, Hanjun Guo wrote:
>> Hi Suravee,
>>
>> On 2014=E5=B9=B412=E6=9C=8818=E6=97=A5 07:16, Suravee Suthikulpanit =
wrote:
>>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>
>>> Device drivers typically use ACPI _HIDs/_CIDs listed in struct
>>> device_driver
>>> acpi_match_table to match devices. However, for generic drivers, we=
 do
>>> not want to list _HID for all supported devices, and some device cl=
asses
>>> do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _C=
LS,
>>> which specifies PCI-defined class code (i.e. base-class, subclass a=
nd
>>> programming interface).
>>>
>>> This patch adds support for matching ACPI devices using the _CLS me=
thod.
>>>
>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com=
>
>>> ---
>>>   drivers/acpi/scan.c             | 73
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   include/acpi/acnames.h          |  1 +
>>>   include/linux/acpi.h            | 12 ++++++-
>>>   include/linux/device.h          |  1 +
>>>   include/linux/mod_devicetable.h |  6 ++++
>>>   5 files changed, 92 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>> index d670158..6406648 100644
>>> --- a/drivers/acpi/scan.c
>>> +++ b/drivers/acpi/scan.c
>>> @@ -864,6 +864,79 @@ int acpi_match_device_ids(struct acpi_device
>>> *device,
>>>   }
>>>   EXPORT_SYMBOL(acpi_match_device_ids);
>>>
>>> +/**
>>> + * acpi_match_device_cls - Match a struct device against a ACPI _C=
LS
>>> method
>>> + * @dev_cls: A pointer to struct acpi_device_cls object to match
>>> against.
>>> + * @dev: The ACPI device structure to match.
>>> + *
>>> + * Check if @dev has a valid ACPI and _CLS handle. If there is a
>>> + * struct acpi_device_cls object for that handle, use that object =
to
>>> match
>>> + * against the given struct acpi_device_cls object.
>>> + *
>>> + * Return 0 on success or error code on failure.
>>> + */
>>> +int acpi_match_device_cls(const struct acpi_device_cls *dev_cls,
>>> +              const struct device *dev)
>>> +{
>>> +    int ret =3D -EINVAL;
>>> +    acpi_status status;
>>> +    struct acpi_device *adev;
>>> +    union acpi_object *pkg;
>>> +    struct acpi_device_cls cls;
>>> +    struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>> +    struct acpi_buffer format =3D { sizeof("NNN"), "NNN" };
>>> +    struct acpi_buffer state =3D { 0, NULL };
>>> +    acpi_handle handle =3D ACPI_HANDLE(dev);
>>
>> ...
>>
>>> +    acpi_handle cls_handle;
>>> +
>>> +    if (!handle || acpi_bus_get_device(handle, &adev))
>>
>> if handle is not NULL, adev will not NULL too :)
>> because you get the handle from adev, ACPI_HANDLE() is defined as:
>> acpi_device_handle(ACPI_COMPANION(dev)), and adev =3D ACPI_COMPANION=
(dev);
>>
>> you may use adev =3D ACPI_COMPANION(dev) to simplify the code.
>>

Thanks for the pointer.

>>> +        return ret;
>>> +
>>> +    if (!adev->status.present || !dev_cls)
>>> +        return ret;
>>> +
>>> +    status =3D acpi_get_handle(adev->handle, METHOD_NAME__CLS,
>>> &cls_handle);
>>
>> do we need this function called here? _CLS is the method under ACPI
>> device object in DSDT/SSDT, and you will get adev->handle =3D=3D cls=
_handle
>> if I'm not wrong :)

You are right. It is not needed, and we can just evaluate right from th=
e=20
handle.

>>> +    if (ACPI_FAILURE(status))
>>> +        return ret;
>>> +
>>> +    status =3D acpi_evaluate_object(cls_handle, "_CLS", NULL, &buf=
fer);
>>> +    if (ACPI_FAILURE(status)) {
>>> +        ACPI_EXCEPTION((AE_INFO, status, "Failed to Evaluat _CLS")=
);
>>> +        return ret;
>>> +    }
>>
>> I think you can evaluate _CLS directly with handle here.
>>
>> Thanks
>> Hanjun
>

Yep. I will send out the new patch in a bit.

Thanks,

Suravee




--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
