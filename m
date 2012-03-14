From: Matt <jackdachef@gmail.com>
Subject: Re: [PATCH v2] libata: disable runtime pm for hotpluggable port
Date: Wed, 14 Mar 2012 23:49:39 +0100
Message-ID: <CAG-aW06hebVsVrFZvTMMuS6v6VNGf65H8h1X3eMaNXZo_QmbBQ@mail.gmail.com>
References: <1331603857.3436.24.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40074 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab2CNWyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2012 18:54:53 -0400
In-Reply-To: <1331603857.3436.24.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, jslaby@suse.cz, cwillu@cwillu.com, Sergei Shtylyov <sshtylyov@mvista.com>

On Tue, Mar 13, 2012 at 2:57 AM, Lin Ming <ming.m.lin@intel.com> wrote:
> Currently, hotplug doesn't work if port is already runtime suspended.
> For now, we simply disable runtime pm for hotpluggable port.
> Later, we should add runtime pm support for hotpluggable port too.
>
> Bug report:
> https://lkml.org/lkml/2012/2/19/70
>
> v2:
> - Use bit 2 and 3 for flags ATA_FLAG_EXTERNAL and ATA_FLAG_PLUGGABLE.
>
> TODO: add similar hotpluggable port check for controllers other than
> AHCI.
>
> Reported-and-tested-by: Jiri Slaby <jslaby@suse.cz>
> Reported-and-tested-by: cwillu@cwillu.com
> Reported-and-tested-by: jackdachef@gmail.com
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
> =A0drivers/ata/ahci.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A0drivers/ata/ahci.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A0drivers/ata/libahci.c =A0 =A0 =A0 =A0 =A0| =A0 20 ++++++++++++++++=
++++
> =A0drivers/ata/libata-transport.c | =A0 =A06 ++++--
> =A0include/linux/libata.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A05 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index d07bf03..02e93ff 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1145,6 +1145,9 @@ static int ahci_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
> =A0 =A0 =A0 =A0if (hpriv->cap & HOST_CAP_PMP)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pi.flags |=3D ATA_FLAG_PMP;
>
> + =A0 =A0 =A0 if (hpriv->cap & HOST_CAP_SXS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi.flags |=3D ATA_FLAG_EXTERNAL;
> +
> =A0 =A0 =A0 =A0ahci_set_em_messages(hpriv, &pi);
>
> =A0 =A0 =A0 =A0if (ahci_broken_system_poweroff(pdev)) {
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index b175000..92f7172 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -172,6 +172,9 @@ enum {
> =A0 =A0 =A0 =A0PORT_CMD_ALPE =A0 =A0 =A0 =A0 =A0 =3D (1 << 26), /* Ag=
gressive Link PM enable */
> =A0 =A0 =A0 =A0PORT_CMD_ATAPI =A0 =A0 =A0 =A0 =A0=3D (1 << 24), /* De=
vice is ATAPI */
> =A0 =A0 =A0 =A0PORT_CMD_FBSCP =A0 =A0 =A0 =A0 =A0=3D (1 << 22), /* FB=
S Capable Port */
> + =A0 =A0 =A0 PORT_CMD_ESP =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 21), /* E=
xternal SATA Port */
> + =A0 =A0 =A0 PORT_CMD_MPSP =A0 =A0 =A0 =A0 =A0 =3D (1 << 19), /* Mec=
hanical Presence Switch Attached to Port */
> + =A0 =A0 =A0 PORT_CMD_HPCP =A0 =A0 =A0 =A0 =A0 =3D (1 << 18), /* Hot=
 Plug Capable Port */
> =A0 =A0 =A0 =A0PORT_CMD_PMP =A0 =A0 =A0 =A0 =A0 =A0=3D (1 << 17), /* =
PMP attached */
> =A0 =A0 =A0 =A0PORT_CMD_LIST_ON =A0 =A0 =A0 =A0=3D (1 << 15), /* cmd =
list DMA engine running */
> =A0 =A0 =A0 =A0PORT_CMD_FIS_ON =A0 =A0 =A0 =A0 =3D (1 << 14), /* FIS =
DMA engine running */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index a72bfd0..7d72d3c 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1097,6 +1097,23 @@ static void ahci_port_init(struct device *dev,=
 struct ata_port *ap,
> =A0 =A0 =A0 =A0writel(1 << port_no, mmio + HOST_IRQ_STAT);
> =A0}
>
> +static bool ahci_port_pluggable(struct ata_port *ap)
> +{
> + =A0 =A0 =A0 void __iomem *port_mmio =3D ahci_port_base(ap);
> + =A0 =A0 =A0 u32 cmd;
> +
> + =A0 =A0 =A0 cmd =3D readl(port_mmio + PORT_CMD);
> +
> + =A0 =A0 =A0 if ((ap->flags & ATA_FLAG_EXTERNAL) &&
> + =A0 =A0 =A0 =A0 =A0 (cmd & PORT_CMD_ESP))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 if (cmd & (PORT_CMD_MPSP | PORT_CMD_HPCP))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 return false;
> +}
> +
> =A0void ahci_init_controller(struct ata_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct ahci_host_priv *hpriv =3D host->private_data;
> @@ -1112,6 +1129,9 @@ void ahci_init_controller(struct ata_host *host=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ata_port_is_dummy(ap))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ahci_port_pluggable(ap))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ap->flags |=3D ATA_FLAG=
_PLUGGABLE;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ahci_port_init(host->dev, ap, i, mmio,=
 port_mmio);
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-tran=
sport.c
> index 74aaee3..a7166b9 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -292,8 +292,10 @@ int ata_tport_add(struct device *parent,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0device_enable_async_suspend(dev);
> - =A0 =A0 =A0 pm_runtime_set_active(dev);
> - =A0 =A0 =A0 pm_runtime_enable(dev);
> + =A0 =A0 =A0 if (!(ap->flags & ATA_FLAG_PLUGGABLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_set_active(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(dev);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0transport_add_device(dev);
> =A0 =A0 =A0 =A0transport_configure_device(dev);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index cafc09a..f46961d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -187,6 +187,8 @@ enum {
> =A0 =A0 =A0 =A0ATA_FLAG_SLAVE_POSS =A0 =A0 =3D (1 << 0), /* host supp=
orts slave dev */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0/* (doesn't imply presence) */
> =A0 =A0 =A0 =A0ATA_FLAG_SATA =A0 =A0 =A0 =A0 =A0 =3D (1 << 1),
> + =A0 =A0 =A0 ATA_FLAG_EXTERNAL =A0 =A0 =A0 =3D (1 << 2), /* Controll=
er supports external SATA */
> + =A0 =A0 =A0 ATA_FLAG_PLUGGABLE =A0 =A0 =A0=3D (1 << 3), /* Port is =
hotpluggable */
> =A0 =A0 =A0 =A0ATA_FLAG_NO_ATAPI =A0 =A0 =A0 =3D (1 << 6), /* No ATAP=
I support */
> =A0 =A0 =A0 =A0ATA_FLAG_PIO_DMA =A0 =A0 =A0 =A0=3D (1 << 7), /* PIO c=
mds via DMA */
> =A0 =A0 =A0 =A0ATA_FLAG_PIO_LBA48 =A0 =A0 =A0=3D (1 << 8), /* Host DM=
A engine is LBA28 only */
> --
> 1.7.2.5
>
>
>

Hi Lin Ming,

thanks for CCing on the updated patch

I just finished testing it with 3.3-rc7 and it works as advertised


Kind Regards

Matt
