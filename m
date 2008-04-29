From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support (revised)
Date: Tue, 29 Apr 2008 08:14:11 +0800
Message-ID: <20080429081411.47fef877@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080428094123.59d055c7@core>
	<20080428170751.097bdbe6@dxy.sh.intel.com>
	<200804282101.33012.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64655 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbYD2AVB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 20:21:01 -0400
In-Reply-To: <200804282101.33012.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Bartlomiej,

On Tue, 29 Apr 2008 03:01:32 +0800
"Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:

> Re: [PATCH] ata: Add Intel SCH PATA support (revised)
> 
> Hi,
> 
> On Monday 28 April 2008, Alek Du wrote:
> > Alan,
> >
> > Fixed and tested, please review it:
> >
> > This patch adds Intel SCH chipsets (US15W, US15L, UL11L) PATA controller
> > support.
> >
> > Signed-off-by: Alek Du <alek.du@intel.com>
> > ---
> >  drivers/ata/ata_piix.c  |   19 +++++++++++++++++++
> >  drivers/ide/pci/piix.c  |    2 ++
> >  include/linux/pci_ids.h |    2 ++
> >  3 files changed, 23 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> > index ea2c764..4ec4178 100644
> > --- a/drivers/ata/ata_piix.c
> > +++ b/drivers/ata/ata_piix.c
> > @@ -136,6 +136,7 @@ enum piix_controller_ids {
> >       ich_pata_33,            /* ICH up to UDMA 33 only */
> >       ich_pata_66,            /* ICH up to 66 Mhz */
> >       ich_pata_100,           /* ICH up to UDMA 100 */
> > +     sch_pata_100,           /* SCH up to UDMA 100 */
> >       ich5_sata,
> >       ich6_sata,
> >       ich6m_sata,
> > @@ -216,6 +217,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
> >       { 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> >       /* ICH8 Mobile PATA Controller */
> >       { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> > +     /* Intel SCH PATA Controller */
> > +     { 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sch_pata_100 },
> > 
> >       /* NOTE: The following PCI ids must be kept in sync with the
> >        * list in drivers/pci/quirks.c.
> > @@ -311,6 +314,13 @@ static struct ata_port_operations ich_pata_ops = {
> >       .set_dmamode            = ich_set_dmamode,
> >  };
> > 
> > +static struct ata_port_operations sch_pata_ops = {
> > +     .inherits               = &piix_pata_ops,
> > +     .cable_detect           = ata_cable_unknown,
> > +     .prereset               = ata_sff_prereset,
> > +     .set_dmamode            = ich_set_dmamode,
> > +};
> > +
> >  static struct ata_port_operations piix_sata_ops = {
> >       .inherits               = &ata_bmdma_port_ops,
> >  };
> > @@ -470,6 +480,15 @@ static struct ata_port_info piix_port_info[] = {
> >               .port_ops       = &ich_pata_ops,
> >       },
> > 
> > +     [sch_pata_100] =
> > +     {
> > +             .flags          = PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
> > +             .pio_mask       = 0x1f, /* pio0-4 */
> > +             .mwdma_mask     = 0x06, /* mwdma1-2 */
> > +             .udma_mask      = ATA_UDMA5, /* udma0-5 */
> > +             .port_ops       = &sch_pata_ops,
> > +     },
> > +
> >       [ich5_sata] =
> >       {
> >               .flags          = PIIX_SATA_FLAGS,
> > diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
> > index 21c5dd2..31607fe 100644
> > --- a/drivers/ide/pci/piix.c
> > +++ b/drivers/ide/pci/piix.c
> > @@ -380,6 +380,7 @@ static const struct ide_port_info piix_pci_info[] __devinitdata = {
> >       /* 22 */ DECLARE_ICH_DEV("ICH4",        ATA_UDMA5),
> >       /* 23 */ DECLARE_ICH_DEV("ESB2",        ATA_UDMA5),
> >       /* 24 */ DECLARE_ICH_DEV("ICH8M",       ATA_UDMA5),
> > +     /* 25 */ DECLARE_ICH_DEV("SCH",         ATA_UDMA5),
> 
> DECLARE_ICH_DEV() cannot be used here - seems like DEFINE_SCH_DEV()
> needs to be defined (which will lack .enablebits field but otherwise
> be identical to DECLARE_ICH_DEV)
> 
I do not understand here, where DECLARE_ICH_DEV() used here? I just defined a new sub_type
sch_pata_100, and inherit most ops from piix instead of cable_detect and prereset. 

> also seems that piix_cable_detect() should be updated to check for
> dev->device == PCI_DEVICE_ID_INTEL_SCH_IDE and return ATA_CBL_PATA80
> (it is OK to use it instead of ATA_CBL_UNK in drivers/ide/ - generic
> cable detection code won't override drive side cable detection).
>
My first version of patch is to modify piix_cable_detect like your way. But Alan suggested
use this way -- it is much cleaner. And according to my test, return ATA_CBL_UNK do no harm.
The driver is set to UDMA5 when 80 cable is used.
 
> otherwise everything looks good
> 
> Thanks,
> Bart

Thanks,
Alek
