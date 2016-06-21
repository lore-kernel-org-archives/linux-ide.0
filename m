From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH] ata: ahci_platform: Add ACPI support for APM X-Gene AHCI
 controller v3 hardware.
Date: Tue, 21 Jun 2016 11:08:28 -0700
Message-ID: <CAOHikRCB4c79okd0q3=Lqwk7LKwZ6EDnWfHRH_oXokrB4PHcyw@mail.gmail.com>
References: <stripathi@apm.com>
 <1466034240-22694-1-git-send-email-stripathi@apm.com>
 <6691907.FIx2xYmxSs@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6691907.FIx2xYmxSs@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jon Masters <jcm@redhat.com>, patches <patches@apm.com>, Tejun Heo <tj@kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Jun 15, 2016 at 11:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wednesday, June 15, 2016 5:44:00 PM CEST suman-tripathi wrote:
> > This patch adds ACPI support for APM X-Gene AHCI controller in
> > ahci_platform driver for v3 hardware. APM X-Gene AHCI controller
> > v3 hardware is fully compliant with ahci_platform driver and requires
> > no workaround quirk.
> >
> > Signed-off-by: Suman Tripathi <stripathi@apm.com>
> > ---
> >  drivers/ata/ahci_platform.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > index 62a04c8..3395baf 100644
> > --- a/drivers/ata/ahci_platform.c
> > +++ b/drivers/ata/ahci_platform.c
> > @@ -86,6 +86,7 @@ MODULE_DEVICE_TABLE(of, ahci_of_match);
> >
> >  static const struct acpi_device_id ahci_acpi_match[] = {
> >         { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
> > +       { "APMC0D33", 0},
> >         {},
> >  };
> >  MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
> >
>
> Doesn't the ACPI_DEVICE_CLASS entry take care of this? I thought it had been


yeah it also works. Just thought that we need something different as
our's is a non-PCI SATA.
>
> added specifically for this purpose. It doesn't seem right to add vendor
> specific entries for generic hardware in each generic driver.
>
>         Arnd




-- 
Thanks,
with regards,
Suman Tripathi
