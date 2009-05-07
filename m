From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Thu, 07 May 2009 10:36:28 +0100
Message-ID: <4A02AB9C.4050107@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com> <49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com> <4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:38503 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756128AbZEGJh0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 May 2009 05:37:26 -0400
In-Reply-To: <4A01C376.8000803@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Hi,

[...]
>
>
>> Sergei: I've added the delays you suggested in the read/write=20
>> procedures, accordingly to the delays specified in the processor's=20
>> user manual for PIO Mode 4.
>
>    Why only for PIO mode 4 if you're claiming support for modes 0 thr=
u 4?

The patch currently supports only PIO Mode 4, as it is hardcoded into=20
the CPU's IDE configuration register:

    writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_4 |
           ((1 << 8) & IDECFG_WST), IDE_REGISTER(IDECFG));

And also in the ide_port_info struct:

static struct ide_port_info ep93xx_ide_port_info =3D {
    .name =3D MODULE_NAME,
    .init_hwif =3D ep93xx_ide_init_hwif,
    .tp_ops =3D &ep93xx_ide_tp_ops,
    .host_flags =3D IDE_HFLAG_SINGLE | IDE_HFLAG_NO_DMA | IDE_HFLAG_MMI=
O |
        IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_NO_UNMASK_IRQS,
    .pio_mask =3D ATA_PIO4,
};

So you're saying I should support all PIO modes? If so, I would have to=
=20
make conditional code, checking perhaps a module param to sort which PI=
O=20
mode to use.
Also, the manual delays should also depend on the PIO mode selected...
It would be done either by a module param (defaulting to PIO Mode 4), o=
r=20
through a kernel configuration variable...

>
> [...]
>
>    Please submit the above parts separately to linux-arm-kernel, as t=
he
> platform code doesn't belong to the driver.
>

Ok.

>
>
>> +
>> +/* Macro for checking -IORDY line state */
>> +#define    ep93xx_ide_check_iordy() ({    \
>> +    u32 _reg =3D readl(IDE_REGISTER(IDECTRL));    \
>> +    (_reg & IDECTRL_IORDY) ? 1 : 0;    \
>> +})
>
>    Make this an inline function, please.

Ok.

[...]

>>
>> +
>> +/*
>> + * EP93xx IDE PIO low-level hardware initialization routine
>> + */
>> +static void ep93xx_ide_init_hwif(ide_hwif_t *hwif)
>> +{
>> +    unsigned long base =3D hwif->config_data;
>> +
>> +    /* enforce reset state */
>> +    ep93xx_ide_clean_regs(base);
>> +
>> +    /* set gpio port E, G and H for IDE */
>> +    ep93xx_ide_on_gpio(1);
>
>    Shouldn't this be done in the platform code instead?

The idea is to make this driver loadable, as suggested earlier by Ryan=20
and Hartley.
The IDE pins are initially (and by default) set to GPIO function. If th=
e=20
IDE driver is registered, through specific platform code or by loading=20
the module at runtime, then the IDE driver cares to configure the IDE=20
pins for IDE function, returning them to GPIO function once the driver=20
is unloaded.

I think this is the approach desired by the EP93xx maintainers, correct=
?=20
(Ryan? Hartley?)

[...]
>
>>
>> +static u8 ep93xx_ide_readb(unsigned long base, unsigned long addr)
>> +{
>> +    u32 reg;
>> +
>> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_D=
IORN |
>> +        IDECTRL_DIOWN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(25);
>> +
>> +    reg &=3D ~IDECTRL_DIORN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(70);
>> +
>> +    while (!ep93xx_ide_check_iordy())
>> +        cpu_relax();
>> +
>> +    reg |=3D IDECTRL_DIORN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(25);
>> +
>> +    return readl(IDE_REGISTER(IDEDATAIN));
>
>    Hey, how this even works (if the data doesn't get latched=20
> somehow)?! You
> should read the register right *before* the deassertion of -DIORx! Th=
e
> minimum data hold time is only 5 ns and the data lines will be trista=
ted
> within 30 ns maximum...

Will be fixed.

>
> [...]
>
>> +static u16 ep93xx_ide_readw(unsigned long base, unsigned long addr)
>> +{
>> +    u32 reg;
>> +
>> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_D=
IORN |
>> +        IDECTRL_DIOWN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(25);
>> +
>> +    reg &=3D ~IDECTRL_DIORN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(70);
>> +
>> +    while (!ep93xx_ide_check_iordy())
>> +        cpu_relax();
>> +
>> +    reg |=3D IDECTRL_DIORN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(25);
>> +
>> +    return readl(IDE_REGISTER(IDEDATAIN));
>> +}
>
>    I don't see any difference between ep93xx_ide_read[bw](), so why d=
on't
> you use a single function?

The difference is only the return value, which casts to either u8 or u1=
6=20
type.
Perhaps there's no need for two different functions, assuming the=20
high-level code will always cast down the variables to their correct=20
type (u8, u16).

>
>> +static void
>> +ep93xx_ide_writeb(unsigned long base, u8 value, unsigned long addr)
>> +{
>> +    u32 reg;
>> +
>> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_D=
IORN |
>> +        IDECTRL_DIOWN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(25);
>> +
>> +    writel(value, IDE_REGISTER(IDEDATAOUT));
>
>    Hum, do you know at which moments this controller starts/stops dri=
ving
> data lines on the IDE bus? After DIOWx- assertion/deassertion?

I will look into that. I based this source code in the CPU's user guide=
,=20
which tips a correct procedure for reading/writing in PIO mode.
But I will check that, as I already had some trouble with the user's=20
guide...

>
>> +
>> +    reg &=3D ~IDECTRL_DIOWN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(70);
>> +
>> +    while (!ep93xx_ide_check_iordy())
>> +        cpu_relax();
>> +
>> +    reg |=3D IDECTRL_DIOWN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +    ndelay(25);
>> +}
>> +
>
> [...]
>
>>
>
>    The same question: why we need both ep93xx_ide_write[bw]()?

Same answer as before. Perhaps there's no need for those.

>
>> +
>> +static void
>> +ep93xx_ide_readsw(unsigned long base, unsigned long addr, void *buf=
,
>> +              unsigned int len)
>> +{
>> +    u16 *data =3D (u16 *) buf;
>> +
>> +    for (; len; len--)
>
>    IMHO, while (len--) fits better...

Ok.

>
>> +        *data++ =3D cpu_to_le16(ep93xx_ide_readw(base, addr));
>> +}
>> +
>
>> +
>> +/*
>> + * EP93xx IDE PIO Transport Operations
>> + */
>> +
>> +static void ep93xx_ide_exec_command(struct hwif_s *hwif, u8 cmd)
>> +{
>> +    ep93xx_ide_writeb(hwif->config_data, cmd,
>> +                  hwif->io_ports.command_addr);
>
>    It's preferrable if you do not insert unnecessary spaces in the
> multiline statements:
>
>     ep93xx_ide_writeb(hwif->config_data, cmd,
>               hwif->io_ports.command_addr);
>
>    This also looks prettier. :-)

Ok.

>
>> +static void
>> +ep93xx_ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf, u8=20
>> valid)
>> +{
>> +    ide_hwif_t *hwif =3D drive->hwif;
>> +    struct ide_io_ports *io_ports =3D &hwif->io_ports;
>> +
>> +    if (valid & IDE_VALID_ERROR)
>> +        tf->error =3D
>> +            ep93xx_ide_readb(hwif->config_data,
>
>> +                     io_ports->feature_addr);
>
>    Again, tabs are strongly preferred over spaces (and carrying the
> statement over to the next line where it's not necessary):
>
>         tf->error =3D ep93xx_ide_readb(hwif->config_data,
>                          io_ports->feature_addr);

Ok.

>
>> +static int __devinit ep93xx_ide_probe(struct platform_device *pdev)
>> +{
>> +    int retval;
>> +    int    irq;
>
>    Stray tab?
>
> [...]

Will be fixed.

>
>> +    retval =3D ide_host_add(&ep93xx_ide_port_info, hws, &host);
>> +    if (retval) {
>> +        dev_err(&pdev->dev,
>> +            "unable to add EP93xx IDE host controller!\n");
>
>    s/add/register/, s/host controller/driver/

Ok.

[...]


>    Since this is not a hotplug driver, you can save some memory on=20
> making ep93xx_ide_probe() __init -- using platform_driver_probe() her=
e=20
> instead of platform_driver_register() and *not* initializing the=20
> 'probe' field of the 'struct platform_driver'.

I think Ryan and Hartley would like this driver to be=20
loadable/unloadable at runtime, as I pointed out earlier in this mail.
I can make the fixes about this, ensuring Ryan and Hartley will both=20
agree to them.


> MBR, Sergei
>

Regards,
Jo=E3o


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

