From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Wed, 06 May 2009 21:05:58 +0400
Message-ID: <4A01C376.8000803@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com> <49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com> <4A019BE4.9020903@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42959 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751117AbZEFRFi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 May 2009 13:05:38 -0400
In-Reply-To: <4A019BE4.9020903@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Hello.

Jo=E3o Ramos wrote:

> So here is the revised patch, according to yours comments, to add=20
> support for the IDE host controller in the Cirrus Logic's EP93xx CPUs=
=2E
> This patch is made against kernel 2.6.30-rc4 (latest release candidat=
e=20
> in Linus's tree).

> I've preferred to attach the patch instead of inlining it in this mai=
l,=20
> as my mailer seems to deform the patch output.

> Please confirm if the patch is ok.

    It looks OK tab-wise now...

> Sergei: I've added the delays you suggested in the read/write=20
> procedures, accordingly to the delays specified in the processor's us=
er=20
> manual for PIO Mode 4.

    Why only for PIO mode 4 if you're claiming support for modes 0 thru=
 4?

> These delays really introduce quite a performance loss. Although the=20
> driver is working, these delays make file transfers quite slow; do we=
=20
> really need to enforce manually these delays?

    Unfortunately, yes.

> I mean, on a 200MHz CPU (5ns instruction cycle), can't we assume that=
=20
> instructions and branches that occur between C code instructions will=
=20
> suffice to some of these delays

    You need to accurately measure that, not just assume.

> (the delays are 25ns + 70ns + 25ns), or=20


> yet, can't we reduce some of these delays assuming some instruction=20
> cycle time is already spent on branches and instructions between read=
s=20
> and writes to the IDE control registers?

    We can in principle, but that time should be accurately measured.

> Best regards,
> Jo=E3o Ramos

> ---------------------------------------------------------------------=
---
>=20
> Add IDE host controller support for Cirrus Logic's EP93xx CPUs.
> This driver currently supports only PIO-4 transfer mode.

    It claims support for all modes 0 to 4 nevertheless.

> Signed-off-by: Joao Ramos <joao.ramos@inov.pt>

> ---

> diff -urN linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/core.c linux-2.6=
=2E30-rc4/arch/arm/mach-ep93xx/core.c
> --- linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/core.c	2009-04-30 05:4=
8:16.000000000 +0100
> +++ linux-2.6.30-rc4/arch/arm/mach-ep93xx/core.c	2009-05-06 13:57:56.=
000000000 +0100
> @@ -537,6 +537,49 @@

[...]

> diff -urN linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/include/mach/ep9=
3xx-regs.h linux-2.6.30-rc4/arch/arm/mach-ep93xx/include/mach/ep93xx-re=
gs.h
> --- linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/include/mach/ep93xx-re=
gs.h	2009-04-30 05:48:16.000000000 +0100
> +++ linux-2.6.30-rc4/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h	=
2009-05-06 13:57:56.000000000 +0100
> @@ -78,6 +78,7 @@

[...]

> diff -urN linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/include/mach/pla=
tform.h linux-2.6.30-rc4/arch/arm/mach-ep93xx/include/mach/platform.h
> --- linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/include/mach/platform.=
h	2009-04-30 05:48:16.000000000 +0100
> +++ linux-2.6.30-rc4/arch/arm/mach-ep93xx/include/mach/platform.h	200=
9-05-06 13:57:56.000000000 +0100

[...]

    Please submit the above parts separately to linux-arm-kernel, as th=
e
platform code doesn't belong to the driver.

> diff -urN linux-2.6.30-rc4.orig/drivers/ide/ep93xx-ide.c linux-2.6.30=
-rc4/drivers/ide/ep93xx-ide.c
> --- linux-2.6.30-rc4.orig/drivers/ide/ep93xx-ide.c	1970-01-01 01:00:0=
0.000000000 +0100
> +++ linux-2.6.30-rc4/drivers/ide/ep93xx-ide.c	2009-05-06 14:48:17.000=
000000 +0100
> @@ -0,0 +1,530 @@
> +/*
> + * Support for Cirrus Logic's EP93xx (EP9312, EP9315) CPUs
> + * IDE host controller driver.
> + *
> + * Copyright (c) 2009, Joao Ramos <joao.ramos@inov.pt>
> + *                     INESC Inovacao (INOV)
> + *

[...]

> +
> +/* Macro for checking -IORDY line state */
> +#define	ep93xx_ide_check_iordy() ({	\
> +	u32 _reg =3D readl(IDE_REGISTER(IDECTRL));	\
> +	(_reg & IDECTRL_IORDY) ? 1 : 0;	\
> +})

    Make this an inline function, please.

> +
> +/*
> + * IDE Control Register bit fields
> + */
> +#define	IDECTRL_CS0N			0x00000001
> +#define	IDECTRL_CS1N			0x00000002
> +#define	IDECTRL_DA				0x0000001C
> +#define	IDECTRL_DIORN			0x00000020
> +#define	IDECTRL_DIOWN			0x00000040
> +#define	IDECTRL_DASPN			0x00000080
> +#define	IDECTRL_DMARQ			0x00000100
> +#define	IDECTRL_INTRQ			0x00000200
> +#define	IDECTRL_IORDY			0x00000400
> +
> +/*
> + * IDE Configuration Register bit fields
> + */
> +#define	IDECFG_IDEEN			0x00000001
> +#define	IDECFG_PIO				0x00000002
> +#define	IDECFG_MDMA				0x00000004
> +#define	IDECFG_UDMA				0x00000008
> +#define	IDECFG_PIO_MODE_0		0x00000000
> +#define	IDECFG_PIO_MODE_1		0x00000010
> +#define	IDECFG_PIO_MODE_2		0x00000020
> +#define	IDECFG_PIO_MODE_3		0x00000030
> +#define	IDECFG_PIO_MODE_4		0x00000040
> +#define	IDECFG_MDMA_MODE_0		0x00000000
> +#define	IDECFG_MDMA_MODE_1		0x00000010
> +#define	IDECFG_MDMA_MODE_2		0x00000020
> +#define	IDECFG_UDMA_MODE_0		0x00000000
> +#define	IDECFG_UDMA_MODE_1		0x00000010
> +#define	IDECFG_UDMA_MODE_2		0x00000020
> +#define	IDECFG_UDMA_MODE_3		0x00000030
> +#define	IDECFG_UDMA_MODE_4		0x00000040
> +#define	IDECFG_WST				0x00000300
> +
> +/*
> + * IDE Interface register map default state
> + * (shutdown)
> + */
> +static void ep93xx_ide_clean_regs(unsigned long base)
> +{
> +	/* disable IDE interface initially */
> +	writel((IDECTRL_CS0N | IDECTRL_CS1N | IDECTRL_DIORN |
> +			IDECTRL_DIOWN), IDE_REGISTER(IDECTRL));
> +
> +	/* clear IDE registers */
> +	writel(0, IDE_REGISTER(IDECFG));
> +	writel(0, IDE_REGISTER(IDEMDMAOP));
> +	writel(0, IDE_REGISTER(IDEUDMAOP));
> +	writel(0, IDE_REGISTER(IDEDATAOUT));
> +	writel(0, IDE_REGISTER(IDEDATAIN));
> +	writel(0, IDE_REGISTER(IDEMDMADATAOUT));
> +	writel(0, IDE_REGISTER(IDEMDMADATAIN));
> +	writel(0, IDE_REGISTER(IDEUDMADATAOUT));
> +	writel(0, IDE_REGISTER(IDEUDMADATAIN));
> +	writel(0, IDE_REGISTER(IDEUDMADEBUG));
> +}
> +
> +/*
> + * EP93xx IDE PIO low-level hardware initialization routine
> + */
> +static void ep93xx_ide_init_hwif(ide_hwif_t *hwif)
> +{
> +	unsigned long base =3D hwif->config_data;
> +
> +	/* enforce reset state */
> +	ep93xx_ide_clean_regs(base);
> +
> +	/* set gpio port E, G and H for IDE */
> +	ep93xx_ide_on_gpio(1);

    Shouldn't this be done in the platform code instead?

> +
> +	/*
> +	 * configure IDE interface:
> +	 *   - IDE Master Enable
> +	 *   - Polled IO Operation
> +	 *   - PIO Mode 4 (16.67 MBps)
> +	 *   - 1 Wait State (10 ns)
> +	 */
> +	writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_4 |
> +	       ((1 << 8) & IDECFG_WST), IDE_REGISTER(IDECFG));
> +}
> +
> +static u8 ep93xx_ide_readb(unsigned long base, unsigned long addr)
> +{
> +	u32 reg;
> +
> +	reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN=
 |
> +	    IDECTRL_DIOWN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(25);
> +
> +	reg &=3D ~IDECTRL_DIORN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(70);
> +
> +	while (!ep93xx_ide_check_iordy())
> +		cpu_relax();
> +
> +	reg |=3D IDECTRL_DIORN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(25);
> +
> +	return readl(IDE_REGISTER(IDEDATAIN));

    Hey, how this even works (if the data doesn't get latched somehow)?=
! You
should read the register right *before* the deassertion of -DIORx! The
minimum data hold time is only 5 ns and the data lines will be tristate=
d
within 30 ns maximum...

[...]

> +static u16 ep93xx_ide_readw(unsigned long base, unsigned long addr)
> +{
> +	u32 reg;
> +
> +	reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN=
 |
> +	    IDECTRL_DIOWN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(25);
> +
> +	reg &=3D ~IDECTRL_DIORN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(70);
> +
> +	while (!ep93xx_ide_check_iordy())
> +		cpu_relax();
> +
> +	reg |=3D IDECTRL_DIORN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(25);
> +
> +	return readl(IDE_REGISTER(IDEDATAIN));
> +}

    I don't see any difference between ep93xx_ide_read[bw](), so why do=
n't
you use a single function?

> +static void
> +ep93xx_ide_writeb(unsigned long base, u8 value, unsigned long addr)
> +{
> +	u32 reg;
> +
> +	reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN=
 |
> +	    IDECTRL_DIOWN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(25);
> +
> +	writel(value, IDE_REGISTER(IDEDATAOUT));

    Hum, do you know at which moments this controller starts/stops driv=
ing
data lines on the IDE bus? After DIOWx- assertion/deassertion?

> +
> +	reg &=3D ~IDECTRL_DIOWN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(70);
> +
> +	while (!ep93xx_ide_check_iordy())
> +		cpu_relax();
> +
> +	reg |=3D IDECTRL_DIOWN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(25);
> +}
> +

[...]

> +
> +static void
> +ep93xx_ide_writew(unsigned long base, u16 value, unsigned long addr)
> +{
> +	u32 reg;
> +
> +	reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN=
 |
> +	    IDECTRL_DIOWN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(25);
> +
> +	writel(value, IDE_REGISTER(IDEDATAOUT));
> +
> +	reg &=3D ~IDECTRL_DIOWN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(70);
> +
> +	while (!ep93xx_ide_check_iordy())
> +		cpu_relax();
> +
> +	reg |=3D IDECTRL_DIOWN;
> +	writel(reg, IDE_REGISTER(IDECTRL));
> +	ndelay(25);
> +}

    The same question: why we need both ep93xx_ide_write[bw]()?

> +
> +static void
> +ep93xx_ide_readsw(unsigned long base, unsigned long addr, void *buf,
> +		      unsigned int len)
> +{
> +	u16 *data =3D (u16 *) buf;
> +
> +	for (; len; len--)

    IMHO, while (len--) fits better...

> +		*data++ =3D cpu_to_le16(ep93xx_ide_readw(base, addr));
> +}
> +

> +
> +/*
> + * EP93xx IDE PIO Transport Operations
> + */
> +
> +static void ep93xx_ide_exec_command(struct hwif_s *hwif, u8 cmd)
> +{
> +	ep93xx_ide_writeb(hwif->config_data, cmd,
> +			      hwif->io_ports.command_addr);

    It's preferrable if you do not insert unnecessary spaces in the
multiline statements:

	ep93xx_ide_writeb(hwif->config_data, cmd,
			  hwif->io_ports.command_addr);

    This also looks prettier. :-)

> +static void
> +ep93xx_ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf, u8 v=
alid)
> +{
> +	ide_hwif_t *hwif =3D drive->hwif;
> +	struct ide_io_ports *io_ports =3D &hwif->io_ports;
> +
> +	if (valid & IDE_VALID_ERROR)
> +		tf->error =3D
> +		    ep93xx_ide_readb(hwif->config_data,

> +					 io_ports->feature_addr);

    Again, tabs are strongly preferred over spaces (and carrying the
statement over to the next line where it's not necessary):

		tf->error =3D ep93xx_ide_readb(hwif->config_data,
					     io_ports->feature_addr);

> +static int __devinit ep93xx_ide_probe(struct platform_device *pdev)
> +{
> +	int retval;
> +	int	irq;

    Stray tab?

[...]

> +	retval =3D ide_host_add(&ep93xx_ide_port_info, hws, &host);
> +	if (retval) {
> +		dev_err(&pdev->dev,
> +			"unable to add EP93xx IDE host controller!\n");

    s/add/register/, s/host controller/driver/

> +		goto fail_unmap;
> +	}
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	dev_info(&pdev->dev, "EP93xx IDE host controller driver initialized=
\n");
> +
> +	return 0;
> +
> +fail_unmap:
> +	iounmap(ide_base);
> +fail_release_mem:
> +	release_mem_region(mem_res->start, mem_res->end - mem_res->start + =
1);
> +	return retval;
> +}
> +
> +static int __devexit ep93xx_ide_remove(struct platform_device *pdev)
> +{
> +	struct resource *mem_res;
> +	struct ide_host *host =3D pdev->dev.driver_data;
> +
> +	/* IDE interface reset state */

    Punctuation missing...

> +	ep93xx_ide_clean_regs(host->ports[0]->config_data);
> +
> +	/* restore back GPIO port E, G and H for GPIO use */
> +	ep93xx_ide_on_gpio(0);
> +
> +	ide_host_remove(host);
> +
> +	iounmap((void __iomem *)(host->ports[0]->config_data));
> +
> +	mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(mem_res->start, mem_res->end - mem_res->start + =
1);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ep93xx_ide_driver =3D {
> +	.probe =3D ep93xx_ide_probe,
> +	.remove =3D __exit_p(ep93xx_ide_remove),
> +	.driver =3D {
> +		   .name =3D MODULE_NAME,
> +		   .owner =3D THIS_MODULE,
> +	},
> +};
> +
> +static int __init ep93xx_ide_init(void)
> +{
> +	return platform_driver_register(&ep93xx_ide_driver);

    Since this is not a hotplug driver, you can save some memory on mak=
ing=20
ep93xx_ide_probe() __init -- using platform_driver_probe() here instead=
 of=20
platform_driver_register() and *not* initializing the 'probe' field of =
the=20
'struct platform_driver'.

MBR, Sergei
