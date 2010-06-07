From: Marc Dionne <marc.c.dionne@gmail.com>
Subject: Re: Hang during boot, bisected to commit 96d60303fd
Date: Mon, 7 Jun 2010 08:21:42 -0400
Message-ID: <AANLkTilwtazg_T4cX2EMb2xterwV1lhXdqUe3Q1UcsDN@mail.gmail.com>
References: <AANLkTiktNufXK_pn6mP2-zyowAIbHlUy5TGu3AtpALv-@mail.gmail.com>
	<20100603020006.GB19123@srcf.ucam.org>
	<AANLkTikpv86r5BBPCEOHujpm8uCgY0DxghSKjBufBWiM@mail.gmail.com>
	<4C08760B.8050002@gmail.com>
	<AANLkTimFY5YQv8DC-zTQ1RF84rno6svvcyLzHGWL6HOk@mail.gmail.com>
	<AANLkTimXcF1pafrSt8dMbUs59AjnqaRwpzDnPIPjdjsn@mail.gmail.com>
	<AANLkTinZ7d3WWyO3m9A7GVnaTuSbn1G33ADFW6ixywcT@mail.gmail.com>
	<AANLkTinIM8swHZTide7MAQsaYbWcFD90FrKUXE9NFG-5@mail.gmail.com>
	<4C0CBA5D.5000900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C0CBA5D.5000900@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, garzik@redhat.com
List-Id: linux-ide@vger.kernel.org

On Mon, Jun 7, 2010 at 5:22 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 06/07/2010 06:34 AM, Robert Hancock wrote:
>> I'm thinking that the hardreset and device classification makes more
>> sense as a place to do this anyways, since that's the point where we
>> really know if there's a device connected or not.. Tejun, any
>> thoughts?
>
> Heh, of course it doesn't work. =A0Device presence can't be reliably
> determined by sampling status once like that. =A0We don't have all th=
e
> crap in libata-eh for nothing. =A0:-)
>
> Marc, can you please try the following patch?
>
> Thanks.
>
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1984a6e..261f86d 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -541,29 +541,11 @@ static int ahci_scr_write(struct ata_link *link=
, unsigned int sc_reg, u32 val)
> =A0 =A0 =A0 =A0return -EINVAL;
> =A0}
>
> -static int ahci_is_device_present(void __iomem *port_mmio)
> -{
> - =A0 =A0 =A0 u8 status =3D readl(port_mmio + PORT_TFDATA) & 0xff;
> -
> - =A0 =A0 =A0 /* Make sure PxTFD.STS.BSY and PxTFD.STS.DRQ are 0 */
> - =A0 =A0 =A0 if (status & (ATA_BUSY | ATA_DRQ))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 /* Make sure PxSSTS.DET is 3h */
> - =A0 =A0 =A0 status =3D readl(port_mmio + PORT_SCR_STAT) & 0xf;
> - =A0 =A0 =A0 if (status !=3D 3)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 return 1;
> -}
> -
> =A0void ahci_start_engine(struct ata_port *ap)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *port_mmio =3D ahci_port_base(ap);
> =A0 =A0 =A0 =A0u32 tmp;
>
> - =A0 =A0 =A0 if (!ahci_is_device_present(port_mmio))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> =A0 =A0 =A0 =A0/* start DMA */
> =A0 =A0 =A0 =A0tmp =3D readl(port_mmio + PORT_CMD);
> =A0 =A0 =A0 =A0tmp |=3D PORT_CMD_START;
> @@ -1892,6 +1874,9 @@ static void ahci_error_handler(struct ata_port =
*ap)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0sata_pmp_error_handler(ap);
> +
> + =A0 =A0 =A0 if (!ata_dev_enabled(ap->link.device))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ahci_stop_engine(ap);
> =A0}
>
> =A0static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
>
> --
> tejun

Hi Tejun,

With that patch the system boots normally.  Out of curiosity I also
instrumented ahci_error_handler a bit, and the stop_engine case
triggers once for the 6 unused ports, but doesn't trigger for the 2
ports with devices (SSD and DVD), as expected.

=46eel free to add a Tested-by if you submit it.

Thanks,
Marc
