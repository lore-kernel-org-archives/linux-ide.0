From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: Re: [V3 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Mon, 9 Feb 2015 21:02:11 +0000
Message-ID: <D0FF3AEC.1020B%suravee.suthikulpanit@amd.com>
References: <20150209111538.GB1480@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150209111538.GB1480@lahna.fi.intel.com>
Content-Language: en-US
Content-ID: <633C5637961F3042AB258E2B2FAEFCAF@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Duran, Leo" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-ide@vger.kernel.org

On 2/9/15, 19:15, "Mika Westerberg" <mika.westerberg@linux.intel.com>
wrote:

>On Mon, Feb 09, 2015 at 12:02:43AM +0100, Rafael J. Wysocki wrote:
>> On Monday, February 09, 2015 12:20:03 AM Suravee Suthikulpanit wrote:
>> > Device drivers typically use ACPI _HIDs/_CIDs listed in struct
>>device_driver
>> > acpi_match_table to match devices. However, for generic drivers, we do
>> > not want to list _HID for all supported devices, and some device
>>classes
>> > do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _CLS,
>> > which specifies PCI-defined class code (i.e. base-class, subclass and
>> > programming interface).
>> > 
>> > This patch adds support for matching ACPI devices using the _CLS
>>method.
>> > 
>> > Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> 
>> Greg, Mika, any problems with this?
>
>Is there some specific reason why this cannot be done in similar way
>than PCI already does?
>
>In other words, stuff _CLS fields to struct acpi_device_id and make
>match functions match against those if they are != 0.

That was my original thought. Then I realized that the acpi_device_id is
used
to create the device matching table, in which could contain several
_HID/_CID.
However, most of the added _CLS field would likely ended up being unused
and
taking up space.

In contrast to _HID/_CID, a driver is likely to match just a single _CLS.
So, I think it is cleaner to have just a dedicate struct acpi_device_cls,
and 
a matching function for it.

Thanks,

Suravee

