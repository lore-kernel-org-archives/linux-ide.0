From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [V8 PATCH 1/3] ACPICA: Add ACPI _CLS processing
Date: Mon, 27 Apr 2015 17:18:28 -0500
Message-ID: <553EB5B4.4030901@amd.com>
References: <D162D21D.19BCD%suravee.suthikulpanit@amd.com>
 <3419939.l8boJE7mrB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:14707
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965422AbbD0WSj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Apr 2015 18:18:39 -0400
In-Reply-To: <3419939.l8boJE7mrB@vostro.rjw.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Moore, Robert" <robert.moore@intel.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "Duran, Leo" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>



On 04/27/2015 03:38 PM, Rafael J. Wysocki wrote:
> On Sunday, April 26, 2015 10:45:29 PM Suthikulpanit, Suravee wrote:
>> On 4/24/15, 21:28, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>>
>>> On Friday, April 24, 2015 04:08:31 PM Suravee Suthikulpanit wrote:
>>>> On 4/16/15 20:45, Zheng, Lv wrote:
>>>>> Before back porting this to ACPICA, let me ask one simple questio=
n.
>>>>> According to the spec, the _CLS is optional and PCI specific.
>>>>> So why should we implement it in ACPICA core not OSPM specific
>>>> modules?
>>>>> If this need to be implemented in ACPICA, then what about the
>>>> following device identification objects?
>>>>> _DDN, _HRV, _MLS, _PLD, _STR, _SUN
>>>>>
>>>>> Thanks and best regards
>>>>> -Lv
>>>>
>>>> Hi,
>>>>
>>>> Sorry for late reply. As for the justification for introducing the=
 _CLS
>>>> support in the ACPICA, this is mainly because ACPI does not curren=
tly
>>>> define _CID for certain device classes, which used to mostly be PC=
I
>>>> devices. Instead, ACPI spec mentioned that _CLS can be used for lo=
ading
>>>> generic drivers on hardware that is compatible with PCI-defined de=
vice
>>>> classes, but that is not implemented on the PCI bus (and is theref=
ore
>>>> enumerated by ACPI.)
>>>
>>> I think it would be good to point to the particular part of the spe=
c
>>> making that provision.  In what section is that mentioned, exactly?
>>
>> Here is the copied from section 6.1.3 _CLS (Class Code) from ACPI 5.=
1 spec:
>> "This object is used to supply OSPM with the PCI-defined class, subc=
lass
>> and programming interface for a device. This object is optional but =
may be
>> useful for generic drivers written for PCI devices that move off of =
PCI
>> and are enumerated by ACPI."
>
> OK, so the "move off of PCI" part should be understood as "something =
that
> used to be on the PCI bus, but now may be included into an SoC direct=
ly
> in which case it won't be a PCI device any more", right?

That's right. For example, the SATA controller is a good example for=20
this case. On most x86 platforms, they are often enumerated as PCI=20
devices. However, in the ARM64 SOC (e.g. on AMD Seattle), it could be=20
enumerated as non-PCI device.

Thanks,

Suravee

>
>> Otherwise, if the community think it=C2=B9s better to not putting th=
e _CLS the
>> _CLS parsing code in ACPICA since, I can try looking into pulling th=
e code
>> out of ACPICA. I also noticed a little issue in the patch series whe=
re the
>> ACPI_VALID_CLS is used in the patch 1 but defined in patch 2. I can =
send
>> out v9 with the fix once we agree on the _CLS parsing.
>
> To me that pretty much depends on the answer to the above question.
>
>
