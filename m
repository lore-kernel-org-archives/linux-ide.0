From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 12 May 2009 20:49:37 +0400
Message-ID: <4A09A8A1.5070002@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <20090508212457.fxyzi9gk3cw4ksw0@webmail.inov.pt> <4A049D99.3050203@ru.mvista.com> <200905090007.10827.bzolnier@gmail.com> <4A08079A.9080803@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:11383 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753781AbZELQtG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 May 2009 12:49:06 -0400
In-Reply-To: <4A08079A.9080803@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Jo=E3o Ramos wrote:

>> I'm not sure what you're getting at with "such advices"... :)

>> We need to cast somewhere anyway so we may as well cast from 'void *=
' to
>> 'unsigned int' where needed and not the other way around (or rather =
from
>> 'unsigned int' to 'struct ide_timing *') -- which would be an ugly h=
ack
>> and could cause maintainability/portability problems later.

>> BTW it seems like a good occasion to add ide_{get,set}_drivedata()=20
>> helpers
>> (ala existing ide_{get,set}_hwifdata() ones) to <linux/ide.h> and th=
us=20
>> make
>> internal IDE API more coherent.

>> [ Yes, I know that we may get away with s/unsigned int/unsigned long=
/
>>   and casting it to 'struct ide_timing *' for now but it always bett=
er
>>   to at least consider more elegant solution first... ]

    Changing a lot of drivers is more elegant than not? Doubt it.

>> Thanks,
>> Bart

> Here is a proposed patch to fix 'drive_data' field to a 'void *' type=
=2E
> I've also added the 'ide_{get,set}_drivedata' helpers you hinted, and=
=20

> I've fixed all the host drivers which used the 'drive_data' field,=20
> making them use the new 'ide_{get,set}_drivedata' helpers and casting=
=20
> them accordingly to both the new 'drive_data' type and the type of va=
lue=20
> being stored.

> I've attached the patch to avoid line-wrapping and deformed output.

> If you can, please test the patch with the fixed drivers, I can't tes=
t=20
> those since I don't have hardware for it.
> However, I will test for compilation.

> Please comment, and if there's any fix to be made, just let me know.

> Regards,
> Jo=E3o Ramos

> ---------------------------------------------------------------------=
---
>=20
> Change ide_drive_t 'drive_data' field from 'unsigned int' type to 'vo=
id *' type,
> allowing a wider range of values/types to be stored in this field.
> Added 'ide_get_drivedata' and 'ide_set_drivedata' helpers to get and =
set
> the 'drive_data' field.
> Fixed all host drivers to maintain coherency with the change in the '=
drive_data'
> field type.
>=20
> Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>=20
> ---
>=20
> diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
> index 80b777e..c8df34c 100644
> --- a/drivers/ide/cmd64x.c
> +++ b/drivers/ide/cmd64x.c
> @@ -140,10 +140,11 @@ static void cmd64x_tune_pio(ide_drive_t *drive,=
 const u8 pio)
>  	if (hwif->channel) {
>  		ide_drive_t *pair =3D ide_get_pair_dev(drive);
> =20
> -		drive->drive_data =3D setup_count;
> +		ide_set_drivedata(drive, (void *) setup_count);
> =20
>  		if (pair)
> -			setup_count =3D max_t(u8, setup_count, pair->drive_data);
> +			setup_count =3D max_t(u8, setup_count,
> +							(u8) ide_get_drivedata(pair));

    You've over-indented it and the (u8) cast is not needed with max_t(=
)=20
which performs the cast internally.
    Personally, I prefer this style for the multi-line statement:

			setup_count =3D max_t(u8, setup_count,
					    ide_get_drivedata(pair));

> diff --git a/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
> index 0332a95..f9e349e 100644
> --- a/drivers/ide/cs5536.c
> +++ b/drivers/ide/cs5536.c
> @@ -143,6 +143,8 @@ static void cs5536_set_pio_mode(ide_drive_t *driv=
e, const u8 pio)
>  		0x99, 0x92, 0x90, 0x22, 0x20,
>  	};
> =20
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    Call it 'timings' please.

> +
>  	struct pci_dev *pdev =3D to_pci_dev(drive->hwif->dev);
>  	ide_drive_t *pair =3D ide_get_pair_dev(drive);
>  	int cshift =3D (drive->dn & 1) ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SH=
IFT;
[...]
> @@ -184,6 +187,8 @@ static void cs5536_set_dma_mode(ide_drive_t *driv=
e, const u8 mode)
>  		0x67, 0x21, 0x20,
>  	};
> =20
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    And 'timings' again...

> +
>  	struct pci_dev *pdev =3D to_pci_dev(drive->hwif->dev);
>  	int dshift =3D (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
>  	u32 etc;
[...]
> @@ -204,9 +210,11 @@ static void cs5536_set_dma_mode(ide_drive_t *dri=
ve, const u8 mode)
> =20
>  static void cs5536_dma_start(ide_drive_t *drive)
>  {
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    And again...

> +
>  	if (drive->current_speed < XFER_UDMA_0 &&
> -	    (drive->drive_data >> 8) !=3D (drive->drive_data & IDE_DRV_MASK=
))
> -		cs5536_program_dtc(drive, drive->drive_data >> 8);
> +	    (drivedata >> 8) !=3D (drivedata & IDE_DRV_MASK))
> +		cs5536_program_dtc(drive, drivedata >> 8);
> =20
>  	ide_dma_start(drive);
>  }
> @@ -214,10 +222,11 @@ static void cs5536_dma_start(ide_drive_t *drive=
)
>  static int cs5536_dma_end(ide_drive_t *drive)
>  {
>  	int ret =3D ide_dma_end(drive);
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    Here too...

> =20
>  	if (drive->current_speed < XFER_UDMA_0 &&
> -	    (drive->drive_data >> 8) !=3D (drive->drive_data & IDE_DRV_MASK=
))
> -		cs5536_program_dtc(drive, drive->drive_data & IDE_DRV_MASK);
> +	    (drivedata >> 8) !=3D (drivedata & IDE_DRV_MASK))
> +		cs5536_program_dtc(drive, drivedata & IDE_DRV_MASK);
> =20
>  	return ret;
>  }
> diff --git a/drivers/ide/ht6560b.c b/drivers/ide/ht6560b.c
> index 2fb0f29..158aeae 100644
> --- a/drivers/ide/ht6560b.c
> +++ b/drivers/ide/ht6560b.c
> @@ -44,7 +44,12 @@
>   *    bit3 (0x08): "1" 3 cycle time, "0" 2 cycle time	      (?)
>   */
>  #define HT_CONFIG_PORT	  0x3e6
> -#define HT_CONFIG(drivea) (u8)(((drivea)->drive_data & 0xff00) >> 8)
> +
> +static inline u8 HT_CONFIG(ide_drive_t *drive)
> +{
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    Call it 'config' (or maybe just 'data' or 'info') and insert an emp=
ty=20
line after declaration please.

> +	return (drivedata & 0xff00) >> 8;
> +}
>  /*
>   * FIFO + PREFETCH (both a/b-model)
>   */
> @@ -90,7 +95,12 @@
>   * Active Time for each drive. Smaller value gives higher speed.
>   * In case of failures you should probably fall back to a higher val=
ue.
>   */
> -#define HT_TIMING(drivea) (u8)((drivea)->drive_data & 0x00ff)
> +static inline u8 HT_TIMING(ide_drive_t *drive)
> +{
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    Same here.

> +	return drivedata & 0x00ff;
> +}
> +
>  #define HT_TIMING_DEFAULT 0xff
> =20
>  /*
> @@ -244,6 +254,7 @@ static void ht_set_prefetch(ide_drive_t *drive, u=
8 state)
>  {
>  	unsigned long flags;
>  	int t =3D HT_PREFETCH_MODE << 8;
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    Call 'config' (or maybe just 'data' or 'info') please.

> @@ -270,6 +283,7 @@ static void ht6560b_set_pio_mode(ide_drive_t *dri=
ve, const u8 pio)
>  {
>  	unsigned long flags;
>  	u8 timing;
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    Same here...

[...]

> @@ -299,7 +314,7 @@ static void __init ht6560b_init_dev(ide_drive_t *=
drive)
>  	if (hwif->channel)
>  		t |=3D (HT_SECONDARY_IF << 8);
> =20
> -	drive->drive_data =3D t;
> +	ide_set_drivedata(drive, (void *)t);

    Oh, they call it just 't'! Nice name too. :-D

> diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
> index 4e16ce6..c96f87a 100644
> --- a/drivers/ide/icside.c
> +++ b/drivers/ide/icside.c
> @@ -267,10 +267,11 @@ static void icside_set_dma_mode(ide_drive_t *dr=
ive, const u8 xfer_mode)
>  	if (use_dma_info && drive->id[ATA_ID_EIDE_DMA_TIME] > cycle_time)
>  		cycle_time =3D drive->id[ATA_ID_EIDE_DMA_TIME];
> =20
> -	drive->drive_data =3D cycle_time;
> +	ide_set_drivedata(drive, (void *)cycle_time);
> =20
>  	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
> -		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);
> +		ide_xfer_verbose(xfer_mode),
> +		2000 / (int) ide_get_drivedata(drive));
>  }

    I see that you're not consistent about that space after the typeacs=
t...=20
either put it there or not, not both. :-)

> diff --git a/drivers/ide/opti621.c b/drivers/ide/opti621.c
> index 6048eda..d545f01 100644
> --- a/drivers/ide/opti621.c
> +++ b/drivers/ide/opti621.c
> @@ -139,6 +139,8 @@ static void opti621_set_pio_mode(ide_drive_t *dri=
ve, const u8 pio)
>  	ide_drive_t *pair =3D ide_get_pair_dev(drive);
>  	unsigned long flags;
>  	u8 tim, misc, addr_pio =3D pio, clk;
> +	int drivedata =3D XFER_PIO_0 + pio;

    Please name it 'mode'...

> +	int pair_drivedata;

    ... and 'pair_mode'.

> @@ -150,11 +152,12 @@ static void opti621_set_pio_mode(ide_drive_t *d=
rive, const u8 pio)
>  		{ 0x48, 0x34, 0x21, 0x10, 0x10 }	/* 25 MHz */
>  	};
> =20
> -	drive->drive_data =3D XFER_PIO_0 + pio;
> +	ide_set_drivedata(drive, (void *) drivedata);
> =20
>  	if (pair) {
> -		if (pair->drive_data && pair->drive_data < drive->drive_data)
> -			addr_pio =3D pair->drive_data - XFER_PIO_0;
> +		pair_drivedata =3D (int) ide_get_drivedata(pair);
> +		if (pair_drivedata && pair_drivedata < drivedata)
> +			addr_pio =3D pair_drivedata - XFER_PIO_0;
>  	}
> =20
>  	spin_lock_irqsave(&opti621_lock, flags);
> diff --git a/drivers/ide/qd65xx.c b/drivers/ide/qd65xx.c
> index c9a1349..2cd350c 100644
> --- a/drivers/ide/qd65xx.c
> +++ b/drivers/ide/qd65xx.c
> @@ -180,8 +180,11 @@ static int qd_find_disk_type (ide_drive_t *drive=
,
> =20
>  static void qd_set_timing (ide_drive_t *drive, u8 timing)
>  {
> -	drive->drive_data &=3D 0xff00;
> -	drive->drive_data |=3D timing;
> +	int drivedata =3D (int) ide_get_drivedata(drive);

    Well, please call it just 'data' (or even 't') in this case.

> +
> +	drivedata &=3D 0xff00;
> +	drivedata |=3D timing;
> +	ide_set_drivedata(drive, (void *)drivedata);

    Oh, inconsistent spacing again! :-)

> diff --git a/drivers/ide/sl82c105.c b/drivers/ide/sl82c105.c
> index b0a4606..5e42eaa 100644
> --- a/drivers/ide/sl82c105.c
> +++ b/drivers/ide/sl82c105.c
> @@ -76,6 +76,7 @@ static void sl82c105_set_pio_mode(ide_drive_t *driv=
e, const u8 pio)
>  	struct pci_dev *dev	=3D to_pci_dev(drive->hwif->dev);
>  	int reg			=3D 0x44 + drive->dn * 4;
>  	u16 drv_ctrl;
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    Please call it 'timings'.

> @@ -101,6 +103,7 @@ static void sl82c105_set_dma_mode(ide_drive_t *dr=
ive, const u8 speed)
>  {
>  	static u16 mwdma_timings[] =3D {0x0707, 0x0201, 0x0200};
>  	u16 drv_ctrl;
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    Here too...

> @@ -181,10 +185,11 @@ static void sl82c105_dma_start(ide_drive_t *dri=
ve)
>  	ide_hwif_t *hwif	=3D drive->hwif;
>  	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
>  	int reg 		=3D 0x44 + drive->dn * 4;
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    And here...

> @@ -204,12 +209,13 @@ static int sl82c105_dma_end(ide_drive_t *drive)
>  	struct pci_dev *dev	=3D to_pci_dev(drive->hwif->dev);
>  	int reg 		=3D 0x44 + drive->dn * 4;
>  	int ret;
> +	unsigned int drivedata =3D (unsigned int) ide_get_drivedata(drive);

    And here...

> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index ff65fff..4ab9859 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -565,7 +565,7 @@ struct ide_drive_s {
> =20
>  	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
>  	unsigned int	cyl;		/* "real" number of cyls */
> -	unsigned int	drive_data;	/* used by set_pio_mode/dev_select() */
> +	void	*drive_data;		/* used by set_pio_mode/dev_select() */

    Please don't break the alignment of the 2nd column.

>  	unsigned int	failures;	/* current failure count */
>  	unsigned int	max_failures;	/* maximum allowed failure count */
>  	u64		probed_capacity;/* initial reported media capacity (ide-cd onl=
y currently) */
> @@ -1570,6 +1570,16 @@ static inline ide_drive_t *ide_get_pair_dev(id=
e_drive_t *drive)
>  	return (peer->dev_flags & IDE_DFLAG_PRESENT) ? peer : NULL;
>  }
> =20
> +static inline void *ide_get_drivedata(ide_drive_t *drive)
> +{
> +	return drive->drive_data;
> +}
> +
> +static inline void ide_set_drivedata(ide_drive_t *drive, void *data)
> +{
> +	drive->drive_data =3D data;
> +}
> +
>  #define ide_port_for_each_dev(i, dev, port) \
>  	for ((i) =3D 0; ((dev) =3D (port)->devices[i]) || (i) < MAX_DRIVES;=
 (i)++)
> =20

    And don't tell me this patch is "elegant"... :-/

MBR, Sergei
