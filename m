From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 15:23:30 +0400
Message-ID: <4A041632.10609@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com> <49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com> <4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com> <4A02AB9C.4050107@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:29502 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756642AbZEHLXF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 07:23:05 -0400
In-Reply-To: <4A02AB9C.4050107@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Jo=E3o Ramos wrote:

>>> Sergei: I've added the delays you suggested in the read/write=20
>>> procedures, accordingly to the delays specified in the processor's=20
>>> user manual for PIO Mode 4.

>>    Why only for PIO mode 4 if you're claiming support for modes 0 th=
ru 4?

> The patch currently supports only PIO Mode 4, as it is hardcoded into=
=20
> the CPU's IDE configuration register:

>    writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_4 |
>           ((1 << 8) & IDECFG_WST), IDE_REGISTER(IDECFG));

> And also in the ide_port_info struct:

> static struct ide_port_info ep93xx_ide_port_info =3D {
>    .name =3D MODULE_NAME,
>    .init_hwif =3D ep93xx_ide_init_hwif,
>    .tp_ops =3D &ep93xx_ide_tp_ops,
>    .host_flags =3D IDE_HFLAG_SINGLE | IDE_HFLAG_NO_DMA | IDE_HFLAG_MM=
IO |
>        IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_NO_UNMASK_IRQS,
>    .pio_mask =3D ATA_PIO4,

    Note that the ATA_PIO4 mask means support for PIO modes 0 thru 4, n=
ot=20
just PIO mode 4 (although in the absense of the set_pio_mode() method t=
his=20
mask hardly matters at all)...

> };

> So you're saying I should support all PIO modes? If so, I would have =
to=20

    For the safe functining of your IDE driver, yes; you should support=
 at=20
least PIO0 as a safe bet. Think about CompactFlash -- the older cards d=
on't=20
even support PIO4, only PIO2 maximum.

> make conditional code, checking perhaps a module param to sort which =
PIO=20
> mode to use.


> Also, the manual delays should also depend on the PIO mode selected..=
=2E

    Sure.

> It would be done either by a module param (defaulting to PIO Mode 4),=
 or=20
> through a kernel configuration variable...

    Why? We have set_pio_mode() method in 'struct ide_port_ops' for tha=
t.
The IDE core will select the best PIO mode for you based on the drive's=
=20
capabilities -- you just need to implement this method.

>>> +
>>> +/*
>>> + * EP93xx IDE PIO low-level hardware initialization routine
>>> + */
>>> +static void ep93xx_ide_init_hwif(ide_hwif_t *hwif)
>>> +{
>>> +    unsigned long base =3D hwif->config_data;
>>> +
>>> +    /* enforce reset state */
>>> +    ep93xx_ide_clean_regs(base);
>>> +
>>> +    /* set gpio port E, G and H for IDE */
>>> +    ep93xx_ide_on_gpio(1);

>>    Shouldn't this be done in the platform code instead?

> The idea is to make this driver loadable, as suggested earlier by Rya=
n=20
> and Hartley.
> The IDE pins are initially (and by default) set to GPIO function. If =
the=20
> IDE driver is registered, through specific platform code or by loadin=
g=20
> the module at runtime, then the IDE driver cares to configure the IDE=
=20
> pins for IDE function, returning them to GPIO function once the drive=
r=20
> is unloaded.

    I'm not sure you can just "return the pins to GPIO function" since =
they=20
will remain connected to the IDE port and will affect its state even be=
ing=20
in GPIO mode... I think you don't have a choice here: they are either a=
lways=20
belong to GPIO (if there's no IDE port) or always belong to IDE (if the=
 IDE=20
port is present).

> [...]

>>> +static u8 ep93xx_ide_readb(unsigned long base, unsigned long addr)
>>> +{
>>> +    u32 reg;
>>> +
>>> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_=
DIORN |
>>> +        IDECTRL_DIOWN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +    ndelay(25);
>>> +
>>> +    reg &=3D ~IDECTRL_DIORN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +    ndelay(70);
>>> +
>>> +    while (!ep93xx_ide_check_iordy())
>>> +        cpu_relax();
>>> +
>>> +    reg |=3D IDECTRL_DIORN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +    ndelay(25);
>>> +
>>> +    return readl(IDE_REGISTER(IDEDATAIN));

>>    Hey, how this even works (if the data doesn't get latched=20
>> somehow)?! You
>> should read the register right *before* the deassertion of -DIORx! T=
he
>> minimum data hold time is only 5 ns and the data lines will be trist=
ated
>> within 30 ns maximum...

> Will be fixed.

    Again, I don't know, maybe the data register is indeed latched by t=
he=20
controller at the rising edge of -DIOR... because this code most probab=
ly=20
wouldn't work otherwise. Please check the documentation, maybe it's ill=
egal=20
to read the data before the deassertion of -DIOR.  But at least doing i=
t=20
after 25 ns delay looked too much fishy...

>>> +
>>> +    reg &=3D ~IDECTRL_DIOWN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +    ndelay(70);
>>> +
>>> +    while (!ep93xx_ide_check_iordy())
>>> +        cpu_relax();
>>> +
>>> +    reg |=3D IDECTRL_DIOWN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +    ndelay(25);
>>> +}
>>> +

>> [...]

>>    The same question: why we need both ep93xx_ide_write[bw]()?

> Same answer as before. Perhaps there's no need for those.

>>    Since this is not a hotplug driver, you can save some memory on=20
>> making ep93xx_ide_probe() __init -- using platform_driver_probe() he=
re=20
>> instead of platform_driver_register() and *not* initializing the=20
>> 'probe' field of the 'struct platform_driver'.

> I think Ryan and Hartley would like this driver to be=20
> loadable/unloadable at runtime, as I pointed out earlier in this mail=
=2E

    So what? It'll remain [un]loadable...

MBR, Sergei
