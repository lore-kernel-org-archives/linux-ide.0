From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 02/11] ata: pata_acpi: Make PCI dependency explicit
Date: Mon, 7 Jan 2019 18:52:05 +0100
Message-ID: <CAJZ5v0i60n1Fp0dJ5kbHgpKuB+Www3ZCOX2GuLnzzhpGCZ1jMA@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-3-okaya@kernel.org>
 <CAJZ5v0gkGaxgr+-CzsabqrfVFQFo_R+G3VEg3qF_sGWa6bT-Dg@mail.gmail.com>
 <CGME20190107141740eucas1p15f2975c3d87e7a8fce9daeaea41525d4@eucas1p1.samsung.com>
 <7d6b9323-7760-944d-daa4-6fc663a32481@samsung.com> <aa5ecfd1-fbb5-1f7a-500b-9eaee1cd8e0a@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aa5ecfd1-fbb5-1f7a-500b-9eaee1cd8e0a@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Sinan Kaya <okaya@kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 7, 2019 at 4:42 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/7/19 7:17 AM, Bartlomiej Zolnierkiewicz wrote:
> >
> > On 01/07/2019 12:12 PM, Rafael J. Wysocki wrote:
> >> On Wed, Jan 2, 2019 at 7:11 PM Sinan Kaya <okaya@kernel.org> wrote:
> >>>
> >>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> >>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> >>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> >>> specified directly. PATA_ACPI is a PCI device driver but the PCI
> >>> dependency has not been explicitly called out.
> >>>
> >>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> >>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> >>> ---
> >>>  drivers/ata/Kconfig | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> >>> index 4ca7a6b4eaae..8218db17ebdb 100644
> >>> --- a/drivers/ata/Kconfig
> >>> +++ b/drivers/ata/Kconfig
> >>> @@ -1091,7 +1091,7 @@ comment "Generic fallback / legacy drivers"
> >>>
> >>>  config PATA_ACPI
> >>>         tristate "ACPI firmware driver for PATA"
> >>> -       depends on ATA_ACPI && ATA_BMDMA
> >>> +       depends on ATA_ACPI && ATA_BMDMA && PCI
> >>>         help
> >>>           This option enables an ACPI method driver which drives
> >>>           motherboard PATA controller interfaces through the ACPI
> >>> --
> >>
> >> Any objections against this one from anyone?
> >
> > Patch looks correct to me (pata_acpi is indeed a PCI driver):
> >
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >
> > but it is best to wait for Jens' ACK if you want to merge it
> > through ACPI tree..
>
> You can add my:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>
> if you want to merge it through the ACPI tree.

I will do that, thanks!
