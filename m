From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH] ata: ahci_platform: Add ACPI support for APM X-Gene AHCI
 controller v3 hardware.
Date: Tue, 21 Jun 2016 16:31:38 -0700
Message-ID: <CAOHikRDUH-PK4JfS8pUR+or=XTwDHBejFTGy33V20HKMMTUaPg@mail.gmail.com>
References: <stripathi@apm.com>
	<1466034240-22694-1-git-send-email-stripathi@apm.com>
	<6691907.FIx2xYmxSs@wuerfel>
	<CAOHikRCB4c79okd0q3=Lqwk7LKwZ6EDnWfHRH_oXokrB4PHcyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOHikRCB4c79okd0q3=Lqwk7LKwZ6EDnWfHRH_oXokrB4PHcyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi Arnd,

On Tue, Jun 21, 2016 at 11:08 AM, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org> wrote:
> On Wed, Jun 15, 2016 at 11:54 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>>
>> On Wednesday, June 15, 2016 5:44:00 PM CEST suman-tripathi wrote:
>> > This patch adds ACPI support for APM X-Gene AHCI controller in
>> > ahci_platform driver for v3 hardware. APM X-Gene AHCI controller
>> > v3 hardware is fully compliant with ahci_platform driver and requires
>> > no workaround quirk.
>> >
>> > Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>> > ---
>> >  drivers/ata/ahci_platform.c |    1 +
>> >  1 files changed, 1 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> > index 62a04c8..3395baf 100644
>> > --- a/drivers/ata/ahci_platform.c
>> > +++ b/drivers/ata/ahci_platform.c
>> > @@ -86,6 +86,7 @@ MODULE_DEVICE_TABLE(of, ahci_of_match);
>> >
>> >  static const struct acpi_device_id ahci_acpi_match[] = {
>> >         { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
>> > +       { "APMC0D33", 0},
>> >         {},
>> >  };
>> >  MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
>> >
>>
>> Doesn't the ACPI_DEVICE_CLASS entry take care of this? I thought it had been
>
>
> yeah it also works. Just thought that we need something different as
> our's is a non-PCI SATA.

Are you suggesting to introduce a new class ACPI_DEVICE_CLASS for
non-pci ahci ? or to reuse the existing PCI_CLASS_STORAGE_SATA_AHCI ?
>>
>> added specifically for this purpose. It doesn't seem right to add vendor
>> specific entries for generic hardware in each generic driver.
>>
>>         Arnd
>
>
>
>
> --
> Thanks,
> with regards,
> Suman Tripathi



-- 
Thanks,
with regards,
Suman Tripathi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
