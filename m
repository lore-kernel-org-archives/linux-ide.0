From: =?ISO-8859-15?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 19 May 2009 14:20:00 +0100
Message-ID: <4A12B200.6010706@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <200905171816.44069.bzolnier@gmail.com> <4A11675B.9050704@inov.pt> <200905191506.00245.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:57613 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbZESNUk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 May 2009 09:20:40 -0400
In-Reply-To: <200905191506.00245.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Ok, I will apply the changes, test them and then resubmit the final pat=
ch.
By the way, I will submit the final patch through 'arm-linux' mailing=20
list, if that is OK to you, since the full patch has platform-specific=20
dependencies.
I mean, as long as we iterate with the IDE part of it untill it is good=
=20
for submission from you, I can submit it in 'arm-linux' with your=20
acknowledge, right?

Thank you for your revisions.

Best regards,
Jo=E3o Ramos

Bartlomiej Zolnierkiewicz escreveu:
> On Monday 18 May 2009 15:49:15 Jo=E3o Ramos wrote:
>  =20
>> Hi,
>>
>> Here is the revised patch according to Bart's suggestions in previou=
s=20
>> emails.
>> The patch is against linux-2.6.30-rc6.
>>    =20
>
> Thanks.  I see that we can still cleanup the code a bit by folding cu=
rrent
> ep93xx_ide_{read,write}() into __ep93xx_ide_{read,write}() and then a=
dding
> wrappers on top of it.
>
> I think that the patch would the best to show the idea in this case (=
it is
> completely untested, it may not build).
>
> [ While at it I also changed data transfer functions to use drive's t=
imings
>   and fixed ->remove method to unregister IDE host before doing host =
specific
>   cleanup.  These fixes should be applied regardless of the cleanup c=
hange. ]
>
> Please review/integrate/test and then resubmit the final patch.
>
> ---
>  drivers/ide/ep93xx-ide.c |  111 ++++++++++++++++++++++--------------=
-----------
>  1 file changed, 54 insertions(+), 57 deletions(-)
>
> Index: b/drivers/ide/ep93xx-ide.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/ep93xx-ide.c
> +++ b/drivers/ide/ep93xx-ide.c
> @@ -126,50 +126,67 @@ static void ep93xx_ide_clean_regs(void _
>  	writel(0, base + IDEUDMADEBUG);
>  }
> =20
> -static u16 ep93xx_ide_read(void __iomem *base, unsigned long addr,
> -		struct ide_timing *timing)
> +static u16 __ep93xx_ide_read(void __iomem *base, unsigned long addr,
> +			     struct ide_timing *t)
>  {
>  	u32 reg;
> =20
>  	reg =3D addr | IDECTRL_DIORN | IDECTRL_DIOWN;
>  	writel(reg, base + IDECTRL);
> -	ndelay(timing->setup);
> +	ndelay(t->setup);
> =20
>  	reg &=3D ~IDECTRL_DIORN;
>  	writel(reg, base + IDECTRL);
> -	ndelay(timing->active);
> +	ndelay(t->active);
> =20
>  	while (!ep93xx_ide_check_iordy(base))
>  		cpu_relax();
> =20
>  	reg |=3D IDECTRL_DIORN;
>  	writel(reg, base + IDECTRL);
> -	ndelay(timing->recover);
> +	ndelay(t->recover);
> =20
>  	return readl(base + IDEDATAIN);
>  }
> =20
> -static void ep93xx_ide_write(void __iomem *base, u16 value,
> -		unsigned long addr, struct ide_timing *timing)
> +static inline u16 ep93xx_ide_read(ide_hwif_t *hwif, unsigned long ad=
dr)
> +{
> +	void __iomem *base =3D hwif->host->host_priv;
> +	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> +
> +	return __ep93xx_ide_read(base, addr, t);
> +}
> +
> +static void __ep93xx_ide_write(void __iomem *base, u16 value,
> +			       unsigned long addr, struct ide_timing *t)
>  {
>  	u32 reg;
> =20
>  	reg =3D addr | IDECTRL_DIORN | IDECTRL_DIOWN;
>  	writel(reg, base + IDECTRL);
> -	ndelay(timing->setup);
> +	ndelay(t->setup);
> =20
>  	writel(value, base + IDEDATAOUT);
> =20
>  	reg &=3D ~IDECTRL_DIOWN;
>  	writel(reg, base + IDECTRL);
> -	ndelay(timing->active);
> +	ndelay(t->active);
> =20
>  	while (!ep93xx_ide_check_iordy(base))
>  		cpu_relax();
> =20
>  	reg |=3D IDECTRL_DIOWN;
>  	writel(reg, base + IDECTRL);
> -	ndelay(timing->recover);
> +	ndelay(t->recover);
> +}
> +
> +static inline void ep93xx_ide_write(ide_hwif_t *hwif, u16 value,
> +				    unsigned long addr)
> +{
> +	void __iomem *base =3D hwif->host->host_priv;
> +	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> +
> +	__ep93xx_ide_write(base, value, addr, t);
>  }
> =20
>  /*
> @@ -178,88 +195,70 @@ static void ep93xx_ide_write(void __iome
> =20
>  static void ep93xx_ide_exec_command(struct hwif_s *hwif, u8 cmd)
>  {
> -	void __iomem *base =3D hwif->host->host_priv;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> -
> -	ep93xx_ide_write(base, cmd, hwif->io_ports.command_addr, t);
> +	ep93xx_ide_write(hwif, cmd, hwif->io_ports.command_addr);
>  }
> =20
>  static u8 ep93xx_ide_read_status(ide_hwif_t *hwif)
>  {
> -	void __iomem *base =3D hwif->host->host_priv;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> -
> -	return ep93xx_ide_read(base, hwif->io_ports.status_addr, t);
> +	return ep93xx_ide_read(whif, hwif->io_ports.status_addr);
>  }
> =20
>  static u8 ep93xx_ide_read_altstatus(ide_hwif_t *hwif)
>  {
> -	void __iomem *base =3D hwif->host->host_priv;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> -
> -	return ep93xx_ide_read(base, hwif->io_ports.ctl_addr, t);
> +	return ep93xx_ide_read(hwif, hwif->io_ports.ctl_addr);
>  }
> =20
>  static void ep93xx_ide_write_devctl(ide_hwif_t *hwif, u8 ctl)
>  {
> -	void __iomem *base =3D hwif->host->host_priv;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> -
> -	ep93xx_ide_write(base, ctl, hwif->io_ports.ctl_addr, t);
> +	ep93xx_ide_write(hwif, ctl, hwif->io_ports.ctl_addr);
>  }
> =20
>  static void ep93xx_ide_dev_select(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif =3D drive->hwif;
> -	void __iomem *base =3D hwif->host->host_priv;
>  	u8 select =3D drive->select | ATA_DEVICE_OBS;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> =20
> -	ep93xx_ide_write(base, select, hwif->io_ports.device_addr, t);
> +	ep93xx_ide_write(hwif, select, hwif->io_ports.device_addr);
>  }
> =20
>  static void ep93xx_ide_tf_load(ide_drive_t *drive, struct ide_taskfi=
le *tf,
>  		u8 valid)
>  {
>  	ide_hwif_t *hwif =3D drive->hwif;
> -	void __iomem *base =3D hwif->host->host_priv;
>  	struct ide_io_ports *io_ports =3D &hwif->io_ports;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> =20
>  	if (valid & IDE_VALID_FEATURE)
> -		ep93xx_ide_write(base, tf->feature, io_ports->feature_addr, t);
> +		ep93xx_ide_write(hwif, tf->feature, io_ports->feature_addr);
>  	if (valid & IDE_VALID_NSECT)
> -		ep93xx_ide_write(base, tf->nsect, io_ports->nsect_addr, t);
> +		ep93xx_ide_write(hwif, tf->nsect, io_ports->nsect_addr);
>  	if (valid & IDE_VALID_LBAL)
> -		ep93xx_ide_write(base, tf->lbal, io_ports->lbal_addr, t);
> +		ep93xx_ide_write(hwif, tf->lbal, io_ports->lbal_addr);
>  	if (valid & IDE_VALID_LBAM)
> -		ep93xx_ide_write(base, tf->lbam, io_ports->lbam_addr, t);
> +		ep93xx_ide_write(hwif, tf->lbam, io_ports->lbam_addr);
>  	if (valid & IDE_VALID_LBAH)
> -		ep93xx_ide_write(base, tf->lbah, io_ports->lbah_addr, t);
> +		ep93xx_ide_write(hwif, tf->lbah, io_ports->lbah_addr);
>  	if (valid & IDE_VALID_DEVICE)
> -		ep93xx_ide_write(base, tf->device, io_ports->device_addr, t);
> +		ep93xx_ide_write(hwif, tf->device, io_ports->device_addr);
>  }
> =20
>  static void ep93xx_ide_tf_read(ide_drive_t *drive, struct ide_taskfi=
le *tf,
>  		u8 valid)
>  {
>  	ide_hwif_t *hwif =3D drive->hwif;
> -	void __iomem *base =3D hwif->host->host_priv;
>  	struct ide_io_ports *io_ports =3D &hwif->io_ports;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> =20
>  	if (valid & IDE_VALID_ERROR)
> -		tf->error =3D ep93xx_ide_read(base, io_ports->feature_addr, t);
> +		tf->error =3D ep93xx_ide_read(hwif, io_ports->feature_addr);
>  	if (valid & IDE_VALID_NSECT)
> -		tf->nsect =3D ep93xx_ide_read(base, io_ports->nsect_addr, t);
> +		tf->nsect =3D ep93xx_ide_read(hwif, io_ports->nsect_addr);
>  	if (valid & IDE_VALID_LBAL)
> -		tf->lbal =3D ep93xx_ide_read(base, io_ports->lbal_addr, t);
> +		tf->lbal =3D ep93xx_ide_read(hwif, io_ports->lbal_addr);
>  	if (valid & IDE_VALID_LBAM)
> -		tf->lbam =3D ep93xx_ide_read(base, io_ports->lbam_addr, t);
> +		tf->lbam =3D ep93xx_ide_read(hwif, io_ports->lbam_addr);
>  	if (valid & IDE_VALID_LBAH)
> -		tf->lbah =3D ep93xx_ide_read(base, io_ports->lbah_addr, t);
> +		tf->lbah =3D ep93xx_ide_read(hwif, io_ports->lbah_addr);
>  	if (valid & IDE_VALID_DEVICE)
> -		tf->device =3D ep93xx_ide_read(base, io_ports->device_addr, t);
> +		tf->device =3D ep93xx_ide_read(hwif, io_ports->device_addr);
>  }
> =20
>  static void ep93xx_ide_input_data(ide_drive_t *drive, struct ide_cmd=
 *cmd,
> @@ -268,13 +267,12 @@ static void ep93xx_ide_input_data(ide_dr
>  	u16 *data =3D (u16 *)buf;
>  	ide_hwif_t *hwif =3D drive->hwif;
>  	void __iomem *base =3D hwif->host->host_priv;
> -	struct ide_io_ports *io_ports =3D &hwif->io_ports;
> +	unsigned long data_addr =3D hwif->io_ports.data_addr;
> +	struct ide_timing *t =3D (struct ide_timing *)ide_get_drivedata(dri=
ve);
>  	unsigned int words =3D (len + 1) >> 1;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> =20
>  	while (words--)
> -		*data++ =3D cpu_to_le16(ep93xx_ide_read(base,
> -					io_ports->data_addr, t));
> +		*data++ =3D cpu_to_le16(__ep93xx_ide_read(base, data_addr, t);
>  }
> =20
>  static void ep93xx_ide_output_data(ide_drive_t *drive, struct ide_cm=
d *cmd,
> @@ -283,13 +281,12 @@ static void ep93xx_ide_output_data(ide_d
>  	u16 *data =3D (u16 *)buf;
>  	ide_hwif_t *hwif =3D drive->hwif;
>  	void __iomem *base =3D hwif->host->host_priv;
> -	struct ide_io_ports *io_ports =3D &hwif->io_ports;
> +	unsigned long data_addr =3D hwif->io_ports.data_addr;
> +	struct ide_timing *t =3D (struct ide_timing *)ide_get_drivedata(dri=
ve);
>  	unsigned int words =3D (len + 1) >> 1;
> -	struct ide_timing *t =3D (struct ide_timing *)ide_get_hwifdata(hwif=
);
> =20
>  	while (words--)
> -		ep93xx_ide_write(base, le16_to_cpu(*data++),
> -			io_ports->data_addr, t);
> +		__ep93xx_ide_write(base, le16_to_cpu(*data++), data_addr, t);
>  }
> =20
>  static struct ide_tp_ops ep93xx_ide_tp_ops =3D {
> @@ -477,18 +474,18 @@ fail_release_mem:
> =20
>  static int __devexit ep93xx_ide_remove(struct platform_device *pdev)
>  {
> -	struct resource *mem_res;
>  	struct ide_host *host =3D pdev->dev.driver_data;
>  	void __iomem *base =3D host->host_priv;
> +	struct resource *mem_res;
> +
> +	ide_host_remove(host);
> =20
>  	/* reset state */
> -	ep93xx_ide_clean_regs(host->host_priv);
> +	ep93xx_ide_clean_regs(base);
> =20
>  	/* restore back GPIO port E, G and H for GPIO use */
>  	ep93xx_ide_release_gpios();
> =20
> -	ide_host_remove(host);
> -
>  	iounmap(base);
> =20
>  	mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
>
>  =20


--=20
***********************************************************************=
*

    Jo=E3o Ramos        <joao.ramos@inov.pt>

    INOV INESC Inova=E7=E3o - ESTG Leiria
    Escola Superior de Tecnologia e Gest=E3o de Leiria
    Ed=EDficio C1, Campus 2
    Morro do Lena, Alto do Vieiro
    Leiria
    2411-901 Leiria
    Portugal

    Tel: +351244843424
    Fax: +351244843424

***********************************************************************=
*

