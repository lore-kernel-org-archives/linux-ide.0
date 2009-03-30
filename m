From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Mon, 30 Mar 2009 19:34:31 +0400
Message-ID: <49D0E687.4040101@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56333 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751013AbZC3PeE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Mar 2009 11:34:04 -0400
In-Reply-To: <49D0CAE4.9090306@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Jo=E3o Ramos wrote:
> Here is the revised patch according to your comments.

> Most significant changes are:
[...]
>  - Removed useless blank lines and white-spaces (Ryan);

   Not all of them yet. :-)


> Regards,
> Jo=E3o
>=20
> Patch follows.
>=20
> diff -urN linux-2.6.29.orig/arch/arm/mach-ep93xx/core.c=20
> linux-2.6.29/arch/arm/mach-ep93xx/core.c
> --- linux-2.6.29.orig/arch/arm/mach-ep93xx/core.c    2009-03-23=20
> 23:12:14.000000000 +0000
> +++ linux-2.6.29/arch/arm/mach-ep93xx/core.c    2009-03-30=20
> 13:52:04.000000000 +0100
> @@ -537,6 +537,51 @@
>      platform_device_register(&ep93xx_i2c_device);
>  }
> =20
> +static struct resource ep93xx_ide_resources[] =3D {
> +    [0] =3D {

    Your code uses 4-space indentation instead of single-tab -- this st=
yle is=20
not acceptable. I'd advise to run the patch thru scripts/checkpatch.pl =
to find=20
and fix the coding style mistakes.

> +        .start    =3D EP93XX_IDE_PHYS_BASE,
> +        .end    =3D EP93XX_IDE_PHYS_BASE + 0x38 - 1,

    Why not just 0x37?
    Again, your indentation is strange.

> diff -urN linux-2.6.29.orig/drivers/ide/ep93xx-ide-pio.c=20
> linux-2.6.29/drivers/ide/ep93xx-ide-pio.c
> --- linux-2.6.29.orig/drivers/ide/ep93xx-ide-pio.c    1970-01-01=20
> 01:00:00.000000000 +0100
> +++ linux-2.6.29/drivers/ide/ep93xx-ide-pio.c    2009-03-30=20

    Please post this part separately to the linux-ide mail list.
    I'd suggest to drop that -pio postfix. Many IDE drivers are PIO onl=
y,=20
there's nothing specifal about it. Moreover, it seems like the hardware=
=20
supports DMA too, so the driver might be extended to support that too..=
=2E

> @@ -0,0 +1,666 @@
> +/*
> + * Support for Cirrus Logic's EP93xx (EP9312, EP9315) CPUs
> + * PIO IDE host driver.
> + *
> + * Copyright (c) 2009, Joao Ramos <joao.ramos@inov.pt>
> + *                     INESC Inovacao (INOV)
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/ioport.h>
> +#include <linux/device.h>
> +
> +#include <asm/io.h>
> +
> +#include <linux/ide.h>
> +
> +#define    MODULE_NAME    "ep93xx-ide-pio"
> +
> +/*
> + * Configuration and usage of the IDE device is made through the
> + * IDE Interface Register Map (EP93xx User's Guide, Section 27).
> + *
> + * This section holds common registers and flag definitions for
> + * that interface.
> + */
> +
> +/* IDE Control Register base offset */

    What do you mean by "base offset"? I'd suggest to drop this or repl=
ace=20
with mere "offset"...

> +/* Macro for acessing registers using base address and specified off=
sets */
> +#define    IDE_REGISTER(_offset)    ((void __iomem *)(base +=20
> OFFSET_##_offset))

    Your patch is line-wrapped.

> +/*
> + * IDE Control Register bit fields
> + */
> +#define    IDECTRL_CS0N            0x00000001
> +#define    IDECTRL_CS1N            0x00000002
> +#define    IDECTRL_DA                0x0000001C
> +#define    IDECTRL_DIORN            0x00000020
> +#define    IDECTRL_DIOWN            0x00000040

    Manually generated PIO cycles? Oh horror... B-)

> +/*
> + * IDE Interface register map default state
> + * (shutdown)
> + */
> +static void
> +ep93xx_ide_pio_clean_regs(unsigned long base)
> +{
> +    /* disable IDE interface initially, ensuring that no device is=20
> selected */
> +    writel((IDECTRL_CS0N | IDECTRL_CS1N), IDE_REGISTER(IDECTRL));
> +
> +    /* clear IDE registers */
> +    writel(0, IDE_REGISTER(IDECFG));

    Writing 0 to this register generates an invalid cycle on IDE bus if=
 I=20
don't mistake (CS0/1 and DIOR/W all asserted), are you sure you want th=
is?

> +/*
> + * EP93xx IDE PIO low-level hardware initialization routine
> + */
> +static void
> +ep93xx_ide_pio_init_hwif(ide_hwif_t *hwif)
> +{
> +    unsigned long base =3D hwif->config_data;
> +
> +    /* enforce reset state */
> +    ep93xx_ide_pio_clean_regs(base);
> +
> +    /* set gpio port E, G and H for IDE */
> +    ep93xx_ide_gpio_on_ide();
> +
> +    /*
> +     * configure IDE interface:
> +     *   - IDE Master Enable
> +     *   - Polled IO Operation
> +     *   - PIO Mode 4 (16.67 MBps)
> +     *   - 1 Wait State (10 ns)
> +     */
> +    writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_4 |
> +           ((1 << 8) & IDECFG_WST), IDE_REGISTER(IDECFG));
> +}
> +
> +/*
> + * EP93xx IDE PIO low-level byte-read procedure.
> + */
> +static u8
> +ep93xx_ide_pio_readb(unsigned long base, unsigned long addr)
> +{
> +    u32    reg;
> +
> +    /*
> +     * initial state: DIORn=3D1, DIOWn=3D1
> +     * write address out
> +     * select CS configuration
> +     */
> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DI=
ORN |
> +          IDECTRL_DIOWN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * bring DIORn low
> +     */
> +    reg &=3D ~IDECTRL_DIORN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * bring DIORn high
> +     */
> +    reg |=3D IDECTRL_DIORN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * read IDE Data Input Register
> +     */
> +    return (readl(IDE_REGISTER(IDEDATAIN)) & 0xFF);

    Masking is pointless, it's achieved by truncation to 'u8'.

> +}

    I don't see what warrants minimum active/recovery time here. And I =
don't=20
see how you're supporitng PIO modes 3/4 as you're not checking -IORDY.

> +
> +/*
> + * EP93xx IDE PIO low-level byte-write procedure.
> + */
> +static void
> +ep93xx_ide_pio_writeb(unsigned long base, u8 value, unsigned long ad=
dr)
> +{
> +    u32    reg;
> +
> +    /*
> +     * initial state: DIORn=3D1, DIOWn=3D1
> +     * write address out
> +     * select CS configuration
> +     */
> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DI=
ORN |
> +          IDECTRL_DIOWN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * write IDE Data Output Register
> +     */
> +    writel(value & 0xFF, IDE_REGISTER(IDEDATAOUT));

    Masking with 0xFF is pointless.

> +
> +    /*
> +     * bring DIOWn low
> +      */
> +    reg &=3D ~IDECTRL_DIOWN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * bring DIOWn high
> +      */
> +    reg |=3D IDECTRL_DIOWN;
> +    writel(reg, IDE_REGISTER(IDECTRL));

    Again, I don't see what warrants minimum active/recovery time and c=
hecks=20
-IORDY...

> +}
> +
> +/*
> + * EP93xx IDE PIO low-level word-read procedure.
> + */
> +static u16
> +ep93xx_ide_pio_readw(unsigned long base, unsigned long addr)
> +{
> +    u32    reg;
> +
> +    /*
> +     * initial state: DIORn=3D1, DIOWn=3D1
> +     * write address out
> +     * select CS configuration
> +     */
> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DI=
ORN |
> +          IDECTRL_DIOWN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * bring DIORn low
> +     */
> +    reg &=3D ~IDECTRL_DIORN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * bring DIORn high
> +     */
> +    reg |=3D IDECTRL_DIORN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * read IDE Data Input Register
> +     */
> +    return (readl(IDE_REGISTER(IDEDATAIN)) & 0xFFFF);

    Masking is pointless. Nothing warrants minimum active/recovery time=
 and=20
checks -IORDY.

> +}
> +
> +/*
> + * EP93xx IDE PIO low-level word-write procedure.
> + */
> +static void
> +ep93xx_ide_pio_writew(unsigned long base, u8 value, unsigned long ad=
dr)

    'value' must be 'u16'

> +{
> +    u32    reg;
> +
> +    /*
> +     * initial state: DIORn=3D1, DIOWn=3D1
> +     * write address out
> +     * select CS configuration
> +     */
> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DI=
ORN |
> +          IDECTRL_DIOWN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * write IDE Data Output Register
> +     */
> +    writel(value & 0xFFFF, IDE_REGISTER(IDEDATAOUT));

    Masking with 0xFFFF is pointless.

> +
> +    /*
> +     * bring DIOWn low
> +      */
> +    reg &=3D ~IDECTRL_DIOWN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +
> +    /*
> +     * bring DIOWn high
> +      */
> +    reg |=3D IDECTRL_DIOWN;
> +    writel(reg, IDE_REGISTER(IDECTRL));
> +}

    Nothing warrants minimum active/recovery time and checks -IORDY...

> +/*
> + * EP93xx IDE PIO low-level word buffer-read procedure
> + */
> +static void
> +ep93xx_ide_pio_readsw(unsigned long base, unsigned long addr, void *=
buf,
> +                      unsigned int len)
> +{
> +    u16    *data =3D (u16 *)buf;
> +
> +    for (;len;len--)

    Put spaces after ; please.

> +        *data++ =3D ep93xx_ide_pio_readw(base, addr);

    Is this little-endian only code? If not, it's not valid in the big =
endian=20
mode...

> +

    Empty line not needed here...

> +}
> +
> +/*
> + * EP93xx IDE PIO low-level word buffer-write procedure
> + */
> +static void
> +ep93xx_ide_pio_writesw(unsigned long base, unsigned long addr, void =
*buf,
> +                       unsigned int len)
> +{
> +    u16    *data =3D (u16 *)buf;
> +  =20
> +    for (;len;len--)

    Add spaces after ; please.

[...]

> +static struct ide_port_info    ep93xx_ide_pio_port_info =3D {
> +    .name        =3D MODULE_NAME,
> +    .init_hwif    =3D ep93xx_ide_pio_init_hwif,
> +    .tp_ops     =3D &ep93xx_ide_pio_tp_ops,
> +    .host_flags    =3D IDE_HFLAG_SINGLE | IDE_HFLAG_NO_DMA | IDE_HFL=
AG_MMIO |
> +                  IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_NO_UNMASK_IRQS,
> +    .pio_mask    =3D ATA_PIO4,

    I'm not seeing the proper support for any of the PIO modes in your =
driver=20
as yet...

> +static int __devinit ep93xx_ide_pio_probe(struct platform_device *pd=
ev)
> +{
> +    int    retval;
> +
> +    void __iomem    *ide_base;
> +
> +    struct resource    *mem_res;
> +    struct resource    *irq_res;
> +
> +    hw_regs_t    hw;
> +    hw_regs_t    *hws[] =3D {&hw, NULL, NULL, NULL};
> +
> +    struct ide_host    *host;
> +
> +    /*
> +     * collect resources from platform_device structure
> +     */
> +    mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +    if (!mem_res) {
> +        dev_err(&pdev->dev, "could not retrieve device memory=20
> resources!\n");
> +        retval =3D -ENXIO;
> +        goto fail_return;
> +    }
> +
> +    irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);

    You could also use platform_get_irq()...

> +    if (!irq_res) {
> +        dev_err(&pdev->dev, "could not retrieve device IRQ resource!=
\n");
> +        retval =3D -ENXIO;
> +        goto fail_return;
> +    }
> +  =20
> +    /* request IDE controller registers memory area */
> +    if (!request_mem_region(mem_res->start, mem_res->end -=20
> mem_res->start + 1,
> +                            MODULE_NAME)) {
> +        dev_err(&pdev->dev, "could not request memory resources!\n")=
;
> +        retval =3D -EBUSY;
> +        goto fail_return;

    Pointless goto/label, you could just instead use:

	return retval;

> +    }
> +
> +    /* map physical memory to virtual memory */
> +    ide_base =3D ioremap(mem_res->start, mem_res->end - mem_res->sta=
rt + 1);
> +    if (!ide_base) {
> +        dev_err(&pdev->dev, "could not map memory resources!\n");
> +        retval =3D -ENOMEM;
> +        goto fail_release_mem;
> +    }
> +
> +    memset(&hw, 0, sizeof(hw));
> +
> +    /*
> +     * fill in ide_io_ports structure.
> +     * we use magic numbers 0x10 for io_addr and 0x0E for ctl_addr,
> +     * hence the lowest 3 bits will give us the real address (rangin=
g from
> +     * 0 to 7) and the subsequent 2 bits will give us the CS1n and C=
S0n
> +     * values:
> +     *   CS1n  CS0n   A2   A1   A0
> +     *     1    0      x    x    x   -> IO_ADDR (base 0x10)
> +     *     0    1      x    x    x   -> CTL_ADDR (base 0x0E)
> +     */
> +    ide_std_init_ports(&hw, 0x10, 0x0E);
> +
> +    hw.irq =3D irq_res->start;
> +    hw.chipset =3D ide_generic;
> +    hw.dev =3D &pdev->dev;
> +    hw.config =3D (unsigned long)ide_base;
> +
> +    retval =3D ide_host_add(&ep93xx_ide_pio_port_info, hws, &host);
> +    if ( retval ) {

    Put no spaces after ( and before ), please.

> +static struct platform_driver    ep93xx_ide_pio_driver =3D {
> +    .probe =3D ep93xx_ide_pio_probe,
> +    .remove =3D __exit_p(ep93xx_ide_pio_remove),
> +    .driver =3D {
> +        .name =3D MODULE_NAME,
> +        .owner =3D THIS_MODULE,
> +    },
> +};
> +
> +
> +

    Too many empty lines, perhaps?

> +static int __init ep93xx_ide_pio_init(void)
> +{
> +    return platform_driver_register(&ep93xx_ide_pio_driver);
> +}
> +module_init(ep93xx_ide_pio_init);
> +
> +static void __exit ep93xx_ide_pio_exit(void)
> +{
> +    platform_driver_unregister(&ep93xx_ide_pio_driver);
> +

    Empty line not needed here.

> +}

MBR, Sergei
