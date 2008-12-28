From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v3] Resurrect IT8172 IDE controller driver
Date: Mon, 29 Dec 2008 01:44:01 +0300
Message-ID: <49580131.6090006@ru.mvista.com>
References: <E1LEfcO-0007lL-Mq@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:39882 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756952AbYL1WoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Dec 2008 17:44:08 -0500
In-Reply-To: <E1LEfcO-0007lL-Mq@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane McDonald <mcdonald.shane@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Shane McDonald wrote:

> Support for the IT8172 IDE controller was removed from the kernel
> sometime after 2.6.18.  Support for the only boards that used the IT8=
172
> was removed from the kernel after 2.6.18, as they had never compiled
> since 2.6.0.  However, there are a couple of platforms that use this
> chip: the PMC-Sierra Xiao Hu thin-client computer, which is no longer
> in production, and the Linksys NSS4000 Network Attached Storage box,
> which is based on the Xiao Hu board.  I am attempting to add support
> for the Xiao Hu to the kernel, and this IT8172 IDE controller is the
> first bit of code in this effort.
>
> This patch resurrects the IT8172 IDE controller code.  I began with
> the 2.6.18 version of the it8172.c file, and have moved it forward so
> that it works with the latest version of the kernel.  I have run this
> driver on a PMC-Sierra Xiao Hu board with the 2.6.28-rc9 kernel, and
> I have had no problems with it in my configuration.  The attached pat=
ch
> applies cleanly against 2.6.28-rc9.
>
> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
>  =20

   Well, you're close. :-)

> diff -uprN a/drivers/ide/it8172.c b/drivers/ide/it8172.c
> --- a/drivers/ide/it8172.c	1969-12-31 18:00:00.000000000 -0600
> +++ b/drivers/ide/it8172.c	2008-12-22 01:23:15.000000000 -0600
> @@ -0,0 +1,188 @@
>  =20
[...]
> +static void it8172_set_pio_mode(ide_drive_t *drive, const u8 pio)
> +{
> +	ide_hwif_t *hwif	=3D HWIF(drive);
> +	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
> +	u16 drive_enables;
> +	u32 drive_timing;
> +
> +				     /* RTx  PWx */
> +	static const u8 timings[][2] =3D {
> +					{ 7, 7 },
> +					{ 3, 4 },
>  =20

   This is not enough for PIO mode 1, as this only gives 150 ns active =
+=20
120 ns recovery =3D 270 ns where minimum is 383 ns

> +					{ 1, 2 }, };
> +	/*
> +	 * The highest value of DIOR/DIOW pulse width and recovery time
> +	 * that can be set in the IT8172 is 8 PCI clock cycles.  As a resul=
t,
> +	 * it cannot be configured for PIO mode 0.  This table sets these
> +	 * parameters to the maximum supported by the IT8172.
> +	 */
> +
> +	pci_read_config_word(dev, 0x40, &drive_enables);
> +	pci_read_config_dword(dev, 0x44, &drive_timing);
> +
> +	/*
> +	 * Enable port 0x44. The IT8172 spec is confused; it calls
> +	 * this register the "Slave IDE Timing Register", but in fact,
> +	 * it controls timing for both master and slave drives.
> +	 */
> +	drive_enables |=3D 0x4000;
> +
> +	if (drive->dn) {
>  =20

   Would have been good to collapse both branches...

> +		drive_enables &=3D 0xc006;
> +		if (drive->media =3D=3D ide_disk)
> +			/* enable prefetch */
> +			drive_enables |=3D 0x0040;
> +		if (pio > 2 || ata_id_has_iordy(drive->id))
>  =20

   You can actually skip "pio > 2" test.

> +static void it8172_set_dma_mode(ide_drive_t *drive, const u8 speed)
> +{
> +	ide_hwif_t *hwif	=3D HWIF(drive);
> +	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
> +	int a_speed		=3D 3 << (drive->dn * 4);
> +	int u_flag		=3D 1 << drive->dn;
> +	int u_speed		=3D 0;
> +	u8 reg48, reg4a;
> +
> +	pci_read_config_byte(dev, 0x48, &reg48);
> +	pci_read_config_byte(dev, 0x4a, &reg4a);
> +
> +	if (speed >=3D XFER_UDMA_0) {
> +		u8 udma =3D speed - XFER_UDMA_0;
> +		u_speed =3D min_t(u8, 2 - (udma & 1), udma) << (drive->dn * 4);
>  =20

   There's no need to use such complex math when the chip only supports=
=20
UltraDMA modes 0 thru 2. Be simple:

		u_speed =3D udma << (drive->dn * 4);


> +		pci_write_config_byte(dev, 0x48, reg48 | u_flag);
> +		reg4a &=3D ~a_speed;
> +		pci_write_config_byte(dev, 0x4a, reg4a | u_speed);
> +	} else {
> +		const u8 mwdma_to_pio[] =3D { 0, 3, 4 };
> +		u8 pio;
> +
> +		pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
> +		pci_write_config_byte(dev, 0x4a, reg4a & ~a_speed);
> +
> +		if (speed >=3D XFER_MW_DMA_0)
>  =20

   We dropped support for SWDMA, so the check  should not be needed...

> +			pio =3D mwdma_to_pio[speed - XFER_MW_DMA_0];
> +		else
> +			pio =3D 2;
>  =20

   ... and *else* branch is pointless.

> +		it8172_set_pio_mode(drive, pio);
>  =20

   Well, not the best place in the PIIX driver -- DMA modes shouldn't=20
affect prefetch and IORDY settings (regardless of what the Intel's=20
programming manuals say :-).
=C0lthough, it's probably OK to continue abusing the set_pio_mode() met=
hod.

> +static const struct ide_port_info it8172_port_info __devinitdata =3D=
 {
> +	.name		=3D DRV_NAME,
> +	.port_ops	=3D &it8172_port_ops,
> +	.enablebits	=3D {{0x41, 0x80, 0x80}, {0x00, 0x00, 0x00} },
>  =20

   Inconsistent spacing, add space after first {...

MBR, Sergei


