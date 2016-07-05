From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH] ata: ahci_platform: Add ACPI support for APM X-Gene AHCI
 controller v3 hardware.
Date: Tue, 5 Jul 2016 11:01:21 -0700
Message-ID: <CAOHikRCZ=YCH6fy9KObf_Cb5fiNBNcHtW3yW5+6=4pCCVaKA_A@mail.gmail.com>
References: <stripathi@apm.com> <1466034240-22694-1-git-send-email-stripathi@apm.com>
 <6691907.FIx2xYmxSs@wuerfel> <CAOHikRCB4c79okd0q3=Lqwk7LKwZ6EDnWfHRH_oXokrB4PHcyw@mail.gmail.com>
 <CAOHikRDUH-PK4JfS8pUR+or=XTwDHBejFTGy33V20HKMMTUaPg@mail.gmail.com> <20160705090747.GC18338@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34413 "EHLO
	mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882AbcGESBW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jul 2016 14:01:22 -0400
Received: by mail-qt0-f170.google.com with SMTP id m2so104981720qtd.1
        for <linux-ide@vger.kernel.org>; Tue, 05 Jul 2016 11:01:22 -0700 (PDT)
In-Reply-To: <20160705090747.GC18338@xora-haswell.xora.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jon Masters <jcm@redhat.com>, patches <patches@apm.com>, Tejun Heo <tj@kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 5, 2016 at 2:07 AM, Graeme Gregory <gg@slimlogic.co.uk> wrote:
>
> On Tue, Jun 21, 2016 at 04:31:38PM -0700, Suman Tripathi wrote:
> > Hi Arnd,
> >
> > On Tue, Jun 21, 2016 at 11:08 AM, Suman Tripathi <stripathi@apm.com> wrote:
> > > On Wed, Jun 15, 2016 at 11:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > >>
> > >> On Wednesday, June 15, 2016 5:44:00 PM CEST suman-tripathi wrote:
> > >> > This patch adds ACPI support for APM X-Gene AHCI controller in
> > >> > ahci_platform driver for v3 hardware. APM X-Gene AHCI controller
> > >> > v3 hardware is fully compliant with ahci_platform driver and requires
> > >> > no workaround quirk.
> > >> >
> > >> > Signed-off-by: Suman Tripathi <stripathi@apm.com>
> > >> > ---
> > >> >  drivers/ata/ahci_platform.c |    1 +
> > >> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > >> >
> > >> > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > >> > index 62a04c8..3395baf 100644
> > >> > --- a/drivers/ata/ahci_platform.c
> > >> > +++ b/drivers/ata/ahci_platform.c
> > >> > @@ -86,6 +86,7 @@ MODULE_DEVICE_TABLE(of, ahci_of_match);
> > >> >
> > >> >  static const struct acpi_device_id ahci_acpi_match[] = {
> > >> >         { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
> > >> > +       { "APMC0D33", 0},
> > >> >         {},
> > >> >  };
> > >> >  MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
> > >> >
> > >>
> > >> Doesn't the ACPI_DEVICE_CLASS entry take care of this? I thought it had been
> > >
> > >
> > > yeah it also works. Just thought that we need something different as
> > > our's is a non-PCI SATA.
> >
> > Are you suggesting to introduce a new class ACPI_DEVICE_CLASS for
> > non-pci ahci ? or to reuse the existing PCI_CLASS_STORAGE_SATA_AHCI ?
>
> This was discussed when AMD Seattle SoC had the same issue and it was
> decided in standards body and on LKML that using PCI device classes for
> non PCI devices was fine.
>
> Example from Overdrive DSDT
>
> Device (AHC0)
> {
>   Name (_HID, "AMDI0600")  // _HID: Hardware ID
>   Name (_UID, 0x00)  // _UID: Unique ID
>   Name (_CCA, 0x01) // _CCA: Cache Coherency Attribute
>   Name (_CLS,
>     Package (0x03) // _CLS: Class Code
>     {
>       0x01,
>       0x06,
>       0x01
>     })


Got it. Will do the same. Thanks !!
>
>   ...
>
> Graeme
>



-- 
Thanks,
with regards,
Suman Tripathi
