From: Andrew Cooks <acooks@gmail.com>
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
Date: Mon, 20 Jan 2014 23:45:52 +0800
Message-ID: <CAJtEV7ZsM2YHHETRGNwXnGi7uq0mJen73i-Yp3EXoDrnni=o=g@mail.gmail.com>
References: <20140120131359.26728.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20140120131359.26728.qmail@science.horizon.com>
Sender: linux-pci-owner@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 20, 2014 at 9:13 PM, George Spelvin <linux@horizon.com> wro=
te:
> This is requried for me to get a Marvell 9172 SATA controller working
> with VT-d.
>
> Andrew Cooks wrote the original; see
> https://bugzilla.kernel.org/show_bug.cgi?id=3D42679#c22
>
> Without it, I see the same symptoms as in that bug report:
> the device is recognized, but probing the attached disk fails.
>
> I massaged it a bit to fit my personal idea of "cleaner".
> The biggest logic change is the elimination of the fn_mapped
> variable from quirk_map_multi_requester_ids.

Thanks, that was detritus left over from debugging.

> I also got rid of the "fn_map << fn" logic (which is never false).

What if function 0 is not present? There were cases where the Marvell
9172 only used function 1 (when only one port is in use). I don't
think it's safe to assume that function 0 is present when you're
trying to compensate for broken devices.

> I can vouch for quirk_map_multi_requester_ids working in my case;
> I can't speak for quirk_map_requester_id.

I've tested quirk_map_requester_id on a Thinkpad T410 with Ricoh IEEE
1394 Controller.

> Who do I nudge about actually getting some variant of this merged?

Thanks for your efforts to get this merged. If you look through the
list archives you'll see that I've posted previous iterations of this
before, without much enthusiasm.

>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.=
c
> index 43b9bfea48..4695865051 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1677,6 +1677,111 @@ static int domain_context_mapping_one(struct =
dmar_domain *domain, int segment,
>         return 0;
>  }
>
> +static void iommu_detach_dev(struct intel_iommu *iommu, u8 bus, u8 d=
evfn);
> +
> +static void quirk_unmap_multi_requesters(struct pci_dev *pdev, u8 fn=
_map)
> +{
> +       int fn;
> +       struct intel_iommu *iommu =3D device_to_iommu(pci_domain_nr(p=
dev->bus),
> +                                               pdev->bus->number, pd=
ev->devfn);
> +
> +       /* something must be seriously wrong if we can't lookup the i=
ommu. */
> +       BUG_ON(!iommu);
> +
> +       fn_map &=3D ~(1<<PCI_FUNC(pdev->devfn));  /* Skip the normal =
case */

Do you really find this "cleaner", as in more readable?

> +
> +       for (fn =3D 0; fn_map >> fn; fn++) {
> +               if (fn_map & (1<<fn)) {
> +                       iommu_detach_dev(iommu,
> +                                       pdev->bus->number,
> +                                       PCI_DEVFN(PCI_SLOT(pdev->devf=
n), fn));
> +                       dev_dbg(&pdev->dev,
> +                               "requester id quirk; ghost func %d un=
mapped",
> +                               fn);
> +               }
> +       }
> +}
> +
> +/* For quirky devices that use multiple requester ids. */
> +static int quirk_map_multi_requester_ids(struct dmar_domain *domain,
> +               struct pci_dev *pdev,
> +               int translation)
> +{
> +       int fn, err =3D 0;
> +       u8 fn_map =3D pci_multi_requesters(pdev);
> +
> +       /* this is the common, non-quirky case. */
> +       if (!fn_map)
> +               return 0;
> +
> +       fn_map &=3D ~(1<<PCI_FUNC(pdev->devfn));  /* Skip the normal =
case */
> +
> +       for (fn =3D 0; fn_map >> fn; fn++) {
> +               if (fn_map & (1<<fn)) {
> +                       err =3D domain_context_mapping_one(domain,
> +                                       pci_domain_nr(pdev->bus),
> +                                       pdev->bus->number,
> +                                       PCI_DEVFN(PCI_SLOT(pdev->devf=
n), fn),
> +                                       translation);
> +                       if (err) {
> +                               dev_err(&pdev->dev,
> +                                       "mapping ghost func %d failed=
", fn);
> +                               quirk_unmap_multi_requesters(pdev,
> +                                       fn_map & ((1<<fn)-1));
> +                               return err;
> +                       }
> +                       dev_dbg(&pdev->dev,
> +                               "requester id quirk; ghost func %d ma=
pped", fn);
> +               }
> +       }
> +       return 0;
> +}
> +
> +
> +static void quirk_unmap_requester_id(struct pci_dev *pdev)
> +{
> +       u8 devfn =3D pci_requester(pdev);
> +       struct intel_iommu *iommu =3D device_to_iommu(pci_domain_nr(p=
dev->bus),
> +                                               pdev->bus->number, pd=
ev->devfn);
> +
> +       /* something must be seriously wrong if we can't lookup the i=
ommu. */
> +       BUG_ON(!iommu);
> +
> +
> +       if (pdev->devfn =3D=3D devfn)
> +               return;
> +
> +       iommu_detach_dev(iommu, pdev->bus->number, devfn);
> +       dev_dbg(&pdev->dev, "requester id quirk; bugged device unmapp=
ed");
> +}
> +
> +static int quirk_map_requester_id(struct dmar_domain *domain,
> +               struct pci_dev *pdev,
> +               int translation)
> +{
> +       u8 devfn =3D pci_requester(pdev);
> +       int err;
> +
> +       dev_dbg(&pdev->dev,
> +               "checking for incorrect pci requester id quirk...");
> +
> +       if (pdev->devfn =3D=3D devfn)
> +               return 0;
> +
> +       err =3D domain_context_mapping_one(domain, pci_domain_nr(pdev=
->bus),
> +                       pdev->bus->number, devfn, translation);
> +       if (err) {
> +               dev_err(&pdev->dev,
> +                       "requester id quirk: mapping dev %02x:%02x.%d=
 failed",
> +                       pdev->bus->number, PCI_SLOT(devfn), PCI_FUNC(=
devfn));
> +               return err;
> +       }
> +       dev_dbg(&pdev->dev,
> +               "requester id quirk; dmar context entry added: %02x:%=
02x.%d",
> +               pdev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
> +       return 0;
> +}
> +
>  static int
>  domain_context_mapping(struct dmar_domain *domain, struct pci_dev *p=
dev,
>                         int translation)
> @@ -1690,6 +1795,16 @@ domain_context_mapping(struct dmar_domain *dom=
ain, struct pci_dev *pdev,
>         if (ret)
>                 return ret;
>
> +       /* quirk for devices using multiple pci requester ids */
> +       ret =3D quirk_map_multi_requester_ids(domain, pdev, translati=
on);
> +       if (ret)
> +               return ret;
> +
> +       /* quirk for devices single incorrect pci requester id */
> +       ret =3D quirk_map_requester_id(domain, pdev, translation);
> +       if (ret)
> +               return ret;
> +
>         /* dependent device mapping */
>         tmp =3D pci_find_upstream_pcie_bridge(pdev);
>         if (!tmp)
> @@ -3802,6 +3917,9 @@ static void domain_remove_one_dev_info(struct d=
mar_domain *domain,
>                         iommu_disable_dev_iotlb(info);
>                         iommu_detach_dev(iommu, info->bus, info->devf=
n);
>                         iommu_detach_dependent_devices(iommu, pdev);
> +                       quirk_unmap_multi_requesters(pdev,
> +                                               pci_multi_requesters(=
pdev));
> +                       quirk_unmap_requester_id(pdev);
>                         free_devinfo_mem(info);
>
>                         spin_lock_irqsave(&device_domain_lock, flags)=
;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3a02717473..500edde3d3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3336,6 +3336,10 @@ static struct pci_dev *pci_func_0_dma_source(s=
truct pci_dev *dev)
>         return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn),=
 0));
>  }
>
> +/* Table of source functions for real devices. The DMA requests for =
the
> + * device are tagged with a different real function as source. This =
is
> + * relevant to multifunction devices.
> + */
>  static const struct pci_dev_dma_source {
>         u16 vendor;
>         u16 device;
> @@ -3362,7 +3366,8 @@ static const struct pci_dev_dma_source {
>   * the device doing the DMA, but sometimes hardware is broken and wi=
ll
>   * tag the DMA as being sourced from a different device.  This funct=
ion
>   * allows that translation.  Note that the reference count of the
> - * returned device is incremented on all paths.
> + * returned device is incremented on all paths. Translation is done =
when
> + * the device is added to an IOMMU group.
>   */
>  struct pci_dev *pci_get_dma_source(struct pci_dev *dev)
>  {
> @@ -3423,6 +3428,144 @@ static int pci_quirk_amd_sb_acs(struct pci_de=
v *dev, u16 acs_flags)
>  #endif
>  }
>
> +/* Table of multiple (ghost) source functions. Devices that may need=
 this quirk
> + * show the following behaviour:
> + * 1. the device may use multiple PCI requester IDs during operation=
,
> + *     (eg. one pci transaction uses xx:yy.0, the next uses xx:yy.1)
> + * 2. the requester ID may not match a known device.
> + *     (eg. lspci does not show xx:yy.1 to be present)
> + *
> + * The bitmap contains all of the functions "in use" by the device.
> + * See  https://bugzilla.redhat.com/show_bug.cgi?id=3D757166,
> + * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679
> + * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1089768
> + */
> +static const struct pci_dev_dma_multi_source_map {
> +       u16 vendor;
> +       u16 device;
> +       u8 func_map;    /* bit map. lsb is fn 0. */
> +} pci_dev_dma_multi_source_map[] =3D {
> +        /* Reported by Patrick Bregman
> +         * https://bugzilla.redhat.com/show_bug.cgi?id=3D863653 */
> +       { PCI_VENDOR_ID_MARVELL_EXT, 0x9120, (1<<0)|(1<<1)},
> +
> +       /* Reported by  Pawe=C5=82 =C5=BBak, Korneliusz Jarz=C4=99bsk=
i, Daniel Mayer
> +        * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679 and by
> +        * Justin Piszcz  https://lkml.org/lkml/2012/11/24/94 */
> +       { PCI_VENDOR_ID_MARVELL_EXT, 0x9123, (1<<0)|(1<<1)},
> +
> +       /* Used in a patch by Ying Chu
> +        * https://bugzilla.redhat.com/show_bug.cgi?id=3D757166 */
> +       { PCI_VENDOR_ID_MARVELL_EXT, 0x9125, (1<<0)|(1<<1)},
> +
> +       /* Reported by Robert Cicconetti
> +        * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679 and by
> +        * Fernando https://bugzilla.redhat.com/show_bug.cgi?id=3D757=
166 */
> +       { PCI_VENDOR_ID_MARVELL_EXT, 0x9128, (1<<0)|(1<<1)},
> +
> +       /* Reported by Stijn Tintel
> +        * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679 */
> +       { PCI_VENDOR_ID_MARVELL_EXT, 0x9130, (1<<0)|(1<<1)},
> +
> +       /* Reported by Gaudenz Steinlin
> +        * https://lkml.org/lkml/2013/3/5/288 */
> +       { PCI_VENDOR_ID_MARVELL_EXT, 0x9143, (1<<0)|(1<<1)},
> +
> +       /* Reported by Andrew Cooks
> +        * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679 */
> +       { PCI_VENDOR_ID_MARVELL_EXT, 0x9172, (1<<0)|(1<<1)},
> +
> +       { 0 }
> +};
> +
> +/*
> + * The mapping of quirky requester ids is used when the device drive=
r sets up
> + * dma, if iommu is enabled.
> + */
> +u8 pci_multi_requesters(struct pci_dev *dev)
> +{
> +       const struct pci_dev_dma_multi_source_map *i;
> +
> +       for (i =3D pci_dev_dma_multi_source_map; i->func_map; i++) {
> +               if ((i->vendor =3D=3D dev->vendor ||
> +                    i->vendor =3D=3D (u16)PCI_ANY_ID) &&
> +                   (i->device =3D=3D dev->device ||
> +                    i->device =3D=3D (u16)PCI_ANY_ID)) {
> +                       return i->func_map;
> +               }
> +       }
> +       return 0;
> +}
> +
> +/* These are one-to-one translations for devices that use a single i=
ncorrect
> + * requester ID. The requester id may not be the BDF of a real devic=
e.
> + */
> +static const struct pci_dev_dma_source_map {
> +       u16 vendor;
> +       u16 device;
> +       u8  devfn;
> +       u8  dma_devfn;
> +} pci_dev_dma_source_map[] =3D {
> +
> +       /* Ricoh IEEE 1394 Controller */
> +       {
> +               PCI_VENDOR_ID_RICOH,
> +               0xe832,
> +               PCI_DEVFN(0x00, 3),
> +               PCI_DEVFN(0x00, 0)
> +       },
> +
> +       /* Nils Caspar - Adaptec 3405
> +        * http://www.mail-archive.com/centos@centos.org/msg90986.htm=
l
> +        * Jonathan McCune
> +        * http://old-list-archives.xen.org/archives/html/xen-users/2=
010-04/msg00535.html */
> +       {
> +               PCI_VENDOR_ID_ADAPTEC2,
> +               0x028b,
> +               PCI_DEVFN(0x0e, 0),
> +               PCI_DEVFN(0x01, 0)
> +       },
> +
> +       /* Mateusz Murawski - LSI SAS based MegaRAID
> +        * https://lkml.org/lkml/2011/9/12/104
> +        * M. Nunberg - Dell PERC 5/i Integrated RAID Controller
> +        * http://lists.xen.org/archives/html/xen-devel/2010-05/msg01=
563.html */
> +       {
> +               PCI_VENDOR_ID_LSI_LOGIC,
> +               0x0411,
> +               PCI_DEVFN(0x0e, 0),
> +               PCI_DEVFN(0x08, 0)
> +       },
> +
> +       /* Steven Dake, Markus Stockhausen - Mellanox 26428
> +        * https://bugzilla.redhat.com/show_bug.cgi?id=3D713774
> +        * Note: mellanox uses decimal product numbers, convert to he=
x for PCI
> +        * device ID. ie. 26428 =3D=3D 0x673c */
> +       {
> +               PCI_VENDOR_ID_MELLANOX,
> +               0x673c,
> +               PCI_DEVFN(0x00, 0),
> +               PCI_DEVFN(0x00, 6)
> +       },
> +
> +       { 0 }
> +};
> +
> +u8 pci_requester(struct pci_dev *dev)
> +{
> +       const struct pci_dev_dma_source_map *i;
> +
> +       for (i =3D pci_dev_dma_source_map; i->devfn; i++) {

The bug that Martin =C3=96hrling pointed out in the ticket is still the=
re.

> +               if ((i->vendor =3D=3D dev->vendor) &&
> +                   (i->device =3D=3D dev->device) &&
> +                   (i->devfn =3D=3D dev->devfn)) {
> +                       return i->dma_devfn;
> +               }
> +       }
> +       return dev->devfn;
> +}
> +
> +
>  static const struct pci_dev_acs_enabled {
>         u16 vendor;
>         u16 device;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a13d6825e5..3214fd2514 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1632,6 +1632,8 @@ enum pci_fixup_pass {
>  #ifdef CONFIG_PCI_QUIRKS
>  void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)=
;
>  struct pci_dev *pci_get_dma_source(struct pci_dev *dev);
> +u8 pci_multi_requesters(struct pci_dev *dev);
> +u8 pci_requester(struct pci_dev *dev);
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags)=
;
>  #else
>  static inline void pci_fixup_device(enum pci_fixup_pass pass,
> @@ -1640,6 +1642,14 @@ static inline struct pci_dev *pci_get_dma_sour=
ce(struct pci_dev *dev)
>  {
>         return pci_dev_get(dev);
>  }
> +u8 pci_multi_requesters(struct pci_dev *dev)
> +{
> +       return 0;
> +}
> +u8 pci_requester(struct pci_dev *dev)
> +{
> +       return dev->devfn;
> +}
>  static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
>                                                u16 acs_flags)
>  {

Thanks,

a.
