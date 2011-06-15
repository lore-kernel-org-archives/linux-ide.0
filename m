From: BingJiun Luo <luobingjiun@gmail.com>
Subject: Fwd: [PATCH] ahci: enable pmp but connected to HDD issue fixed
Date: Wed, 15 Jun 2011 10:50:05 +0800
Message-ID: <BANLkTin0CHX82s5t1cbqBUP_P1oBiQPCqA@mail.gmail.com>
References: <1308030504-3026-1-git-send-email-yuanlmm@gmail.com>
	<BANLkTimiJheFauWXjh-8GszGHoqMOa0Kkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44569 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab1FOCuH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2011 22:50:07 -0400
In-Reply-To: <BANLkTimiJheFauWXjh-8GszGHoqMOa0Kkw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Since more than one controllers has software reset failed problem when =
PMP
enabled,=A0I think it would be better to move=A0ahci_sb600_softreset() =
from ahci.c
to libahci.c=A0and rename it, let's say:=A0ahci_pmpenable_softreset()=A0=
=2E
(Just=A0arbitrary
name,=A0please someone may give a better function name)
Controller that has software reset problem when PMP enable may point it=
s
softreset and pmp_softreset call back function of struct ata_port_opera=
tions to
ahci_pmpenable_softreset(). Regardless of PCI or Platform based AHCI co=
ntroller.
(ahci.c or ahci_platform.c)
Regards,
BingJiun
On Tue, Jun 14, 2011 at 1:48 PM, Yuan-Hsin Chen <yuanlmm@gmail.com> wro=
te:
>
> From: Yuan-Hsin Chen <yhchen@faraday-tech.com>
>
> When enabling both port multiplier and platform ahci sata, ahci
> times out while connecting to HDD directly. This is because soft
> reset fails with IPMS set. Do soft reset again to port 0.
>
> The soft reset sequence is copied from ahci.c.
>
> Signed-off-by: Yuan-Hsin Chen <yhchen@faraday-tech.com>
> ---
> =A0drivers/ata/ahci_platform.c | =A0 62 +++++++++++++++++++++++++++++=
+++++++++++++-
> =A01 files changed, 61 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.=
c
> index 6fef1fa..6eab716 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -27,6 +27,66 @@ static struct scsi_host_template ahci_platform_sht=
 =3D {
> =A0 =A0 =A0 =A0AHCI_SHT("ahci_platform"),
> =A0};
>
> +static int ahci_pmp_softreset(struct ata_link *link, unsigned int *c=
lass,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long deadl=
ine);
> +
> +static struct ata_port_operations ahci_pmp_ops =3D {
> + =A0 =A0 =A0 .inherits =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D &ahci_ops,
> + =A0 =A0 =A0 .softreset =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ahci_pmp_soft=
reset,
> + =A0 =A0 =A0 .pmp_softreset =A0 =A0 =A0 =A0 =A0=3D ahci_pmp_softrese=
t,
> +};
> +
> +static int ahci_pmp_check_ready(struct ata_link *link)
> +{
> + =A0 =A0 =A0 void __iomem *port_mmio =3D ahci_port_base(link->ap);
> + =A0 =A0 =A0 u8 status =3D readl(port_mmio + PORT_TFDATA) & 0xFF;
> + =A0 =A0 =A0 u32 irq_status =3D readl(port_mmio + PORT_IRQ_STAT);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* There is no need to check TFDATA if BAD PMP is fou=
nd due to HW bug,
> + =A0 =A0 =A0 =A0* which can save timeout delay.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (irq_status & PORT_IRQ_BAD_PMP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 printk("%s:TFT 0x%x\n", __func__, status);
> + =A0 =A0 =A0 return ata_check_ready(status);
> +}
> +
> +static int ahci_pmp_softreset(struct ata_link *link, unsigned int *c=
lass,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d long deadline)
> +{
> + =A0 =A0 =A0 struct ata_port *ap =3D link->ap;
> + =A0 =A0 =A0 void __iomem *port_mmio =3D ahci_port_base(ap);
> + =A0 =A0 =A0 int pmp =3D sata_srst_pmp(link);
> + =A0 =A0 =A0 int rc;
> + =A0 =A0 =A0 u32 irq_sts;
> +
> + =A0 =A0 =A0 DPRINTK("ENTER\n");
> +
> + =A0 =A0 =A0 rc =3D ahci_do_softreset(link, class, pmp, deadline,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ahci_pmp=
_check_ready);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Soft reset fails with IPMS set when PMP is enabled=
 but
> + =A0 =A0 =A0 =A0* SATA HDD/ODD is connected to SATA port, do soft re=
set
> + =A0 =A0 =A0 =A0* again to port 0.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (rc =3D=3D -EIO) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_sts =3D readl(port_mmio + PORT_IRQ_=
STAT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq_sts & PORT_IRQ_BAD_PMP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_link_printk(link, K=
ERN_WARNING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "applying PMP SRST workaround "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "and retrying\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D ahci_do_softrese=
t(link, class, 0, deadline,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0ahci_check_ready);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return rc;
> +}
> +
> +
> =A0static int __init ahci_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
> @@ -35,7 +95,7 @@ static int __init ahci_probe(struct platform_device=
 *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D AHCI_FLA=
G_COMMON,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pio_mask =A0 =A0 =A0 =3D ATA_PIO4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.udma_mask =A0 =A0 =A0=3D ATA_UDMA6,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .port_ops =A0 =A0 =A0 =3D &ahci_ops,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .port_ops =A0 =A0 =A0 =3D &ahci_pmp_ops=
,
> =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0const struct ata_port_info *ppi[] =3D { &pi, NULL };
> =A0 =A0 =A0 =A0struct ahci_host_priv *hpriv;
> --
> 1.7.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
