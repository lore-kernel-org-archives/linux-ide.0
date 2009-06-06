From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Sat, 06 Jun 2009 19:26:31 +0400
Message-ID: <4A2A8AA7.6040300@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <200905191506.00245.bzolnier@gmail.com> <4A12B200.6010706@inov.pt> <200905191556.17793.bzolnier@gmail.com> <4A12BCA5.2030302@inov.pt> <4A12D54C.3040507@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63438 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752138AbZFFP0l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Jun 2009 11:26:41 -0400
In-Reply-To: <4A12D54C.3040507@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-15?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Jo=E3o Ramos wrote:

> Ok, I've done the fixes you suggested and tested the patch.
> It is working fine, and I'm sending you (once again) the patch=20
> attached to this e-mail.
>
> In the meanwhile, I will post the entire patch to the 'arm-linux'=20
> mailing list, iterating untill I get a final patch for the platform=20
> dependent part.
> Then, I will send the full patch back at linux-ide for submission.

   I'm not sure why you again joined the driver patch and the platfrorm=
=20
code patch together...

>>>> Ok, I will apply the changes, test them and then resubmit the fina=
l=20
>>>> patch.
>>>> By the way, I will submit the final patch through 'arm-linux'=20
>>>> mailing list, if that is OK to you, since the full patch has=20
>>>> platform-specific dependencies.
>>>> I mean, as long as we iterate with the IDE part of it untill it is=
=20
>>>> good for submission from you, I can submit it in 'arm-linux' with=20
>>>> your acknowledge, right?    =20
>>>
>>> It is good to post it also to linux-arm for additional review &=20
>>> better merge
>>> coordination but the patch itself should go through IDE tree and=20
>>> linux-ide.
>>>
>>> [ It is IDE host driver, has also IDE dependencies=20
>>> (ide_{set,get}_drivedata()
>>>   patch) and there are some other pending IDE changes that will=20
>>> require minor
>>>   updates to the patch. ]
>>>
>>> Just ping me after platform-specific part is in and I'll push the=20
>>> driver
>>> to Linus (of course given that everybody is happy with the final=20
>>> version).

   I'm not happy yet. :-)

[...]

> Add IDE host controller support for Cirrus Logic's EP93xx CPUs.
>
> Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>
>
> ---
>
> diff -urN linux-2.6.30-rc6.orig/arch/arm/mach-ep93xx/core.c linux-2.6=
=2E30-rc6/arch/arm/mach-ep93xx/core.c
> --- linux-2.6.30-rc6.orig/arch/arm/mach-ep93xx/core.c	2009-05-16 05:1=
2:57.000000000 +0100
> +++ linux-2.6.30-rc6/arch/arm/mach-ep93xx/core.c	2009-05-19 16:03:36.=
000000000 +0100
> @@ -537,6 +537,31 @@
>  	platform_device_register(&ep93xx_i2c_device);
>  }
> =20
> +static struct resource ep93xx_ide_resources[] =3D {
> +	{
> +		.start	=3D EP93XX_IDE_PHYS_BASE,
> +		.end	=3D EP93XX_IDE_PHYS_BASE + 0x37,
> +		.flags	=3D IORESOURCE_MEM,
> +	},
> +	{
> +		.start	=3D IRQ_EP93XX_EXT3,
> +		.end	=3D IRQ_EP93XX_EXT3,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device ep93xx_ide_device =3D {
> +	.name		=3D "ep93xx-ide",
> +	.id		=3D -1,
> +	.num_resources	=3D ARRAY_SIZE(ep93xx_ide_resources),
> +	.resource	=3D ep93xx_ide_resources,
> +};
> +
> +void __init ep93xx_register_ide(void)
> +{
> +	platform_device_register(&ep93xx_ide_device);
> +}
> +
>  extern void ep93xx_gpio_init(void);
> =20
>  void __init ep93xx_init_devices(void)
> diff -urN linux-2.6.30-rc6.orig/arch/arm/mach-ep93xx/include/mach/ep9=
3xx-regs.h linux-2.6.30-rc6/arch/arm/mach-ep93xx/include/mach/ep93xx-re=
gs.h
> --- linux-2.6.30-rc6.orig/arch/arm/mach-ep93xx/include/mach/ep93xx-re=
gs.h	2009-05-16 05:12:57.000000000 +0100
> +++ linux-2.6.30-rc6/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h	=
2009-05-19 16:03:36.000000000 +0100
> @@ -78,6 +78,7 @@
>  #define EP93XX_BOOT_ROM_BASE		(EP93XX_AHB_VIRT_BASE + 0x00090000)
> =20
>  #define EP93XX_IDE_BASE			(EP93XX_AHB_VIRT_BASE + 0x000a0000)
> +#define EP93XX_IDE_PHYS_BASE		(EP93XX_AHB_PHYS_BASE + 0x000a0000)
> =20
>  #define EP93XX_VIC1_BASE		(EP93XX_AHB_VIRT_BASE + 0x000b0000)
> =20
> diff -urN linux-2.6.30-rc6.orig/arch/arm/mach-ep93xx/include/mach/pla=
tform.h linux-2.6.30-rc6/arch/arm/mach-ep93xx/include/mach/platform.h
> --- linux-2.6.30-rc6.orig/arch/arm/mach-ep93xx/include/mach/platform.=
h	2009-05-16 05:12:57.000000000 +0100
> +++ linux-2.6.30-rc6/arch/arm/mach-ep93xx/include/mach/platform.h	200=
9-05-19 16:03:36.000000000 +0100
> @@ -15,6 +15,7 @@
>  void ep93xx_map_io(void);
>  void ep93xx_init_irq(void);
>  void ep93xx_init_time(unsigned long);
> +void ep93xx_register_ide(void);
>  void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr=
);
>  void ep93xx_register_i2c(struct i2c_board_info *devices, int num);
>  void ep93xx_init_devices(void);
> diff -urN linux-2.6.30-rc6.orig/drivers/ide/ep93xx-ide.c linux-2.6.30=
-rc6/drivers/ide/ep93xx-ide.c
> --- linux-2.6.30-rc6.orig/drivers/ide/ep93xx-ide.c	1970-01-01 01:00:0=
0.000000000 +0100
> +++ linux-2.6.30-rc6/drivers/ide/ep93xx-ide.c	2009-05-19 16:06:33.000=
000000 +0100
> @@ -0,0 +1,521 @@
>  =20
[...]
> +static u16 __ep93xx_ide_read(void __iomem *base, unsigned long addr,
> +		struct ide_timing *t)
> +{
> +	u32 reg;
> +
> +	reg =3D addr | IDECTRL_DIORN | IDECTRL_DIOWN;
> +	writel(reg, base + IDECTRL);
> +	ndelay(t->setup);
> +
> +	reg &=3D ~IDECTRL_DIORN;
> +	writel(reg, base + IDECTRL);
> +	ndelay(t->active);
> +
> +	while (!ep93xx_ide_check_iordy(base))
> +		cpu_relax();
> +
> +	reg |=3D IDECTRL_DIORN;
> +	writel(reg, base + IDECTRL);
> +	ndelay(t->recover);
>  =20

  No, actually it should be t->cycle - t->active - t->setup. t->recover=
=20
is a only a minimum recovery time, and you need to respect t->cycle min=
imum.

> +static void __ep93xx_ide_write(void __iomem *base, u16 value,
> +		unsigned long addr, struct ide_timing *t)
> +{
> +	u32 reg;
> +
> +	reg =3D addr | IDECTRL_DIORN | IDECTRL_DIOWN;
> +	writel(reg, base + IDECTRL);
> +	ndelay(t->setup);
> +
> +	writel(value, base + IDEDATAOUT);
> +
> +	reg &=3D ~IDECTRL_DIOWN;
> +	writel(reg, base + IDECTRL);
> +	ndelay(t->active);
> +
> +	while (!ep93xx_ide_check_iordy(base))
> +		cpu_relax();
> +
> +	reg |=3D IDECTRL_DIOWN;
> +	writel(reg, base + IDECTRL);
> +	ndelay(t->recover);
>  =20

   Same here...

> +static void ep93xx_ide_set_pio_mode(ide_drive_t *drive, const u8 pio=
)
> +{
> +	ide_drive_t *pair =3D ide_get_pair_dev(drive);
> +	struct ide_timing *t =3D ide_timing_find_mode(XFER_PIO_0 + pio);
> +	struct ide_timing *cmd_t =3D t;
> +	u32 reg =3D IDECFG_IDEEN | IDECFG_PIO;
> +	void __iomem *base =3D drive->hwif->host->host_priv;
> +
> +	if (pair) {
> +		struct ide_timing *pair_t =3D ide_get_drivedata(pair);
> +
> +		if (pair_t && pair_t->mode < t->mode)
> +			cmd_t =3D pair_t;
>  =20

   No, it should be like in other drivers:

        if (pair) {
<http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Ddrivers/ide/palm_bk3710.c;h=3D09d813d313f4a44986a2f358d8ddc08c=
619533f1;hb=3DHEAD#l169>                =20
u8 mode =3D ide_get_best_pio_mode(pair, 255, 4);

<http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Ddrivers/ide/palm_bk3710.c;h=3D09d813d313f4a44986a2f358d8ddc08c=
619533f1;hb=3DHEAD#l170>=20

<http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Ddrivers/ide/palm_bk3710.c;h=3D09d813d313f4a44986a2f358d8ddc08c=
619533f1;hb=3DHEAD#l171>                =20
if (mode < pio)
<http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Ddrivers/ide/palm_bk3710.c;h=3D09d813d313f4a44986a2f358d8ddc08c=
619533f1;hb=3DHEAD#l172>                        =20
cmd_t =3D ide_timing_find_mode(XFER_PIO_0 + mode) ;
<http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Ddrivers/ide/palm_bk3710.c;h=3D09d813d313f4a44986a2f358d8ddc08c=
619533f1;hb=3DHEAD#l173>        =20
}


> +	}
> +
> +	/*
> +	 * store the adequate PIO mode timings, to be used later
> +	 * by ep93xx_ide_{read,write}
> +	 */
> +	ide_set_drivedata(drive, (void *)t);
> +	ide_set_hwifdata(drive->hwif, (void *)cmd_t);
> +
> +	/* reconfigure IDE controller according to PIO mode */
> +	switch (pio) {
> +	case 4:
> +		reg |=3D IDECFG_PIO_MODE_4 | ((1 << 8) & IDECFG_WST);
>  =20

   What does WST field mean? I also don't understand what purpose could=
=20
serve setting the PIO mode here if you ensure to apply all the necessar=
y=20
manually...

> +static struct ide_port_ops ep93xx_ide_port_ops =3D {
> +	.set_pio_mode =3D ep93xx_ide_set_pio_mode,
> +};
> +
> +static struct ide_port_info ep93xx_ide_port_info =3D {
> +	.name		=3D MODULE_NAME,
> +	.tp_ops 	=3D &ep93xx_ide_tp_ops,
> +	.port_ops 	=3D &ep93xx_ide_port_ops,
> +	.host_flags 	=3D IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE |
>  =20

  Is the latter really necessary?

> +	/*
> +	 * fill in ide_io_ports structure.
> +	 * the device IDE register to be accessed is selected through
> +	 * IDECTRL register's specific bitfields 'DA', 'CS1n' and 'CS0n':
> +	 *   b4   b3   b2    b1     b0
> +	 *   A2   A1   A0   CS1n   CS0n
> +	 * the values filled in this structure allows the value to be direc=
tly
> +	 * ORed to the IDECTRL register, hence giving directly the A[2:0] a=
nd
> +	 * CS1n/CS0n values for each IDE register.
> +	 * The values correspond to the transformation:
> +	 *   ((real IDE address) << 2) | CS1n value << 1 | CS0n value
> +	 */
> +	hw.io_ports.data_addr =3D 0x02;
> +	hw.io_ports.error_addr =3D 0x06;
> +	hw.io_ports.nsect_addr =3D 0x0A;
> +	hw.io_ports.lbal_addr =3D 0x0E;
> +	hw.io_ports.lbam_addr =3D 0x12;
> +	hw.io_ports.lbah_addr =3D 0x16;
>
>  =20

   Hm, where's this empty line from? :-)

> +	hw.io_ports.device_addr =3D 0x1A;
> +	hw.io_ports.command_addr =3D 0x1E;
> +	hw.io_ports.ctl_addr =3D 0x01;

MBR, Sergei


