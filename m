From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: Re: [V3 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Wed, 11 Feb 2015 22:35:25 +0000
Message-ID: <D101F3FB.108F7%suravee.suthikulpanit@amd.com>
References: <2016200.TRfI2dfssZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0130.outbound.protection.outlook.com ([157.56.110.130]:58684
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752664AbbBKWvE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2015 17:51:04 -0500
In-Reply-To: <2016200.TRfI2dfssZ@vostro.rjw.lan>
Content-Language: en-US
Content-ID: <BB79D78C7947F347A9A2C3AE49690788@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Duran, Leo" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Lv Zheng <lv.zheng@intel.com>



On 2/10/15, 23:07, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

>On Tuesday, February 10, 2015 11:59:32 AM Mika Westerberg wrote:
>> On Mon, Feb 09, 2015 at 09:02:11PM +0000, Suthikulpanit, Suravee wro=
te:
>> > On 2/9/15, 19:15, "Mika Westerberg" <mika.westerberg@linux.intel.c=
om>
>> > wrote:
>> >=20
>> > >On Mon, Feb 09, 2015 at 12:02:43AM +0100, Rafael J. Wysocki wrote=
:
>> > >> On Monday, February 09, 2015 12:20:03 AM Suravee Suthikulpanit
>>wrote:
>> > >> > Device drivers typically use ACPI _HIDs/_CIDs listed in struc=
t
>> > >>device_driver
>> > >> > acpi_match_table to match devices. However, for generic drive=
rs,
>>we do
>> > >> > not want to list _HID for all supported devices, and some dev=
ice
>> > >>classes
>> > >> > do not have _CID (e.g. SATA, USB). Instead, we can leverage A=
CPI
>>_CLS,
>> > >> > which specifies PCI-defined class code (i.e. base-class,
>>subclass and
>> > >> > programming interface).
>> > >> >=20
>> > >> > This patch adds support for matching ACPI devices using the _=
CLS
>> > >>method.
>> > >> >=20
>> > >> > Signed-off-by: Suravee Suthikulpanit
>><Suravee.Suthikulpanit@amd.com>
>> > >>=20
>> > >> Greg, Mika, any problems with this?
>> > >
>> > >Is there some specific reason why this cannot be done in similar =
way
>> > >than PCI already does?
>> > >
>> > >In other words, stuff _CLS fields to struct acpi_device_id and ma=
ke
>> > >match functions match against those if they are !=3D 0.
>> >=20
>> > That was my original thought. Then I realized that the acpi_device=
_id
>>is
>> > used
>> > to create the device matching table, in which could contain severa=
l
>> > _HID/_CID.
>> > However, most of the added _CLS field would likely ended up being
>>unused
>> > and
>> > taking up space.
>>=20
>> Well, PCI is doing that already :)
>>=20
>> > In contrast to _HID/_CID, a driver is likely to match just a singl=
e
>>_CLS.
>> > So, I think it is cleaner to have just a dedicate struct
>>acpi_device_cls,
>> > and=20
>> > a matching function for it.
>>=20
>> IMHO cleaner version is the one following PCI.
>
>I agree.

Ok, let me reimplement this part to put "u32 cls" in the struct
acpi_device_id, and use that for matching then.

>
>> Besides, how do you support modules with this? Or did I miss somethi=
ng?
>
>Good question.

Ah. I didn=B9t think about this part earlier.

IIUC, the current ACPI driver would create modules.alias entry with for=
mat:
	acpi:<HID>:<CID>

What do you think if we append the _CLS of the device using the followi=
ng
format:
	acpi:<HID>:<CID>:<CLS>

In case of PCI_CLASS_STORAGE_SATA_AHCI, this would become:
	acpi:::0x10601

Thanks,

Suravee

