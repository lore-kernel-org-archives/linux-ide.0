From: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH] sata: xgene: add ACPI support for APM X-Gene SATA ports
Date: Thu, 8 Jan 2015 09:56:25 -0800
Message-ID: <CAL85gmDbZgM48C5UFgOgLiQhDU6sCmF59O_oaN8thYoYP+DFRA@mail.gmail.com>
References: <1418337070-17644-1-git-send-email-fkan@apm.com>
	<CAL85gmAHLk9XCbr-1+USmOKxd5O7iCxWX0vqSRf74Brn2pzESg@mail.gmail.com>
	<54AE36AF.3070603@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:56055 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757040AbbAHR41 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jan 2015 12:56:27 -0500
Received: by mail-ob0-f182.google.com with SMTP id wo20so9264692obc.13
        for <linux-ide@vger.kernel.org>; Thu, 08 Jan 2015 09:56:25 -0800 (PST)
In-Reply-To: <54AE36AF.3070603@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: patches <patches@apm.com>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Salter <msalter@redhat.com>, tj@kernel.org, hdegoede@redhat.com

On Wed, Jan 7, 2015 at 11:50 PM, Hanjun Guo <hanjun.guo@linaro.org> wro=
te:
> Hi Feng Kan,
>
> I have some comments below.
>
>
> On 2015=E5=B9=B401=E6=9C=8808=E6=97=A5 01:32, Feng Kan wrote:
>>
>> Just want to ping this again.
>>
>> Happy new year
>>
>> On Thu, Dec 11, 2014 at 2:31 PM, Feng Kan <fkan@apm.com> wrote:
>>>
>>> This adds ACPI support for the APM X-Gene SATA ports. When the syst=
em
>>> boots using ACPI table, the SATA ports are able to configure using =
the
>>> values supplied by the ACPI table rather than the DTS.
>>>
>>> Signed-off-by: Feng Kan <fkan@apm.com>
>>> ---
>>>   drivers/ata/ahci_xgene.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
>>> index d0c851a..4951392 100644
>>> --- a/drivers/ata/ahci_xgene.c
>>> +++ b/drivers/ata/ahci_xgene.c
>>> @@ -22,6 +22,7 @@
>>>    * NOTE: PM support is not currently available.
>>>    *
>>>    */
>>> +#include <linux/acpi.h>
>>>   #include <linux/module.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/ahci_platform.h>
>>> @@ -521,6 +522,14 @@ disable_resources:
>>>          return rc;
>>>   }
>>>
>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id xgene_ahci_acpi_match[] =3D {
>>> +       { "APMC0D0D", },
>
>
> When I was going through the PNP and ACPI ID list in
> http://www.uefi.org/PNP_ACPI_Registry, I found that
> there is no "APMC" for ACPI ID, I only found that there is
> a PNP ID "APM" for Applied Memory Tech company, are
> you using PNP ID for this one?
>
> if not, I think you can send a request to UEFI and
> request a new ACPI ID of "APMC" for Applied Micro, and then
> submit the patch again.
>
> How to send a request to register the ACPI ID, you can
> refer to:
> http://www.uefi.org/PNP_ACPI_Registry

Hanjun, the documents are bit out of sync. We have received approval an=
d
it is present in the document link below. I can also forward the approv=
al letter
if it needed.

http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE=
7CE0D98DC2/ISA%20PNPID%20List.xlsx


>
> Thanks
> Hanjun
