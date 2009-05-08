From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 13:47:42 +0100
Message-ID: <4A0429EE.6000906@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com> <49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com> <4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com> <4A02AB9C.4050107@inov.pt> <4A041632.10609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:54632 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758535AbZEHMss (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 08:48:48 -0400
In-Reply-To: <4A041632.10609@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Sergei Shtylyov escreveu:
> Jo=E3o Ramos wrote:
>
>>>> Sergei: I've added the delays you suggested in the read/write=20
>>>> procedures, accordingly to the delays specified in the processor's=
=20
>>>> user manual for PIO Mode 4.
>
>>>    Why only for PIO mode 4 if you're claiming support for modes 0=20
>>> thru 4?
>
>> The patch currently supports only PIO Mode 4, as it is hardcoded int=
o=20
>> the CPU's IDE configuration register:
>
>>    writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_4 |
>>           ((1 << 8) & IDECFG_WST), IDE_REGISTER(IDECFG));
>
>> And also in the ide_port_info struct:
>
>> static struct ide_port_info ep93xx_ide_port_info =3D {
>>    .name =3D MODULE_NAME,
>>    .init_hwif =3D ep93xx_ide_init_hwif,
>>    .tp_ops =3D &ep93xx_ide_tp_ops,
>>    .host_flags =3D IDE_HFLAG_SINGLE | IDE_HFLAG_NO_DMA | IDE_HFLAG_M=
MIO |
>>        IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_NO_UNMASK_IRQS,
>>    .pio_mask =3D ATA_PIO4,
>
>    Note that the ATA_PIO4 mask means support for PIO modes 0 thru 4,=20
> not just PIO mode 4 (although in the absense of the set_pio_mode()=20
> method this mask hardly matters at all)...

I've already seen that, as stated in my earlier mails. Now I've got the=
=20
full picture about the IDE subsystem ;-) .

>
>> };
>
>> So you're saying I should support all PIO modes? If so, I would have=
 to=20
>
>    For the safe functining of your IDE driver, yes; you should suppor=
t=20
> at least PIO0 as a safe bet. Think about CompactFlash -- the older=20
> cards don't even support PIO4, only PIO2 maximum.

I've already done that, implementing the 'pio_set_mode' method.

>
>> make conditional code, checking perhaps a module param to sort which=
=20
>> PIO mode to use.
>
>
>> Also, the manual delays should also depend on the PIO mode selected.=
=2E.
>
>    Sure.

As discussed with Bartlomiej Zolnierkiewicz, I will  use  struct=20
ide_timing to figure out the correct timings for each PIO mode, and use=
=20
the adequate delays in my read/write functions.

>
>> It would be done either by a module param (defaulting to PIO Mode 4)=
,=20
>> or through a kernel configuration variable...
>
>    Why? We have set_pio_mode() method in 'struct ide_port_ops' for th=
at.
> The IDE core will select the best PIO mode for you based on the=20
> drive's capabilities -- you just need to implement this method.

Now I got it ;-) . Sorry, I'm quite inexperient in the IDE subsystem=20
(and in kernel programming) so it took me a while to figure that out.
But I've done that and I've already tested it, and it works.
I am just finishing some other fixes and I will submit a new patch soon=
=2E

>
>>>> +
>>>> +/*
>>>> + * EP93xx IDE PIO low-level hardware initialization routine
>>>> + */
>>>> +static void ep93xx_ide_init_hwif(ide_hwif_t *hwif)
>>>> +{
>>>> +    unsigned long base =3D hwif->config_data;
>>>> +
>>>> +    /* enforce reset state */
>>>> +    ep93xx_ide_clean_regs(base);
>>>> +
>>>> +    /* set gpio port E, G and H for IDE */
>>>> +    ep93xx_ide_on_gpio(1);
>
>>>    Shouldn't this be done in the platform code instead?
>
>> The idea is to make this driver loadable, as suggested earlier by=20
>> Ryan and Hartley.
>> The IDE pins are initially (and by default) set to GPIO function. If=
=20
>> the IDE driver is registered, through specific platform code or by=20
>> loading the module at runtime, then the IDE driver cares to configur=
e=20
>> the IDE pins for IDE function, returning them to GPIO function once=20
>> the driver is unloaded.
>
>    I'm not sure you can just "return the pins to GPIO function" since=
=20
> they will remain connected to the IDE port and will affect its state=20
> even being in GPIO mode... I think you don't have a choice here: they=
=20
> are either always belong to GPIO (if there's no IDE port) or always=20
> belong to IDE (if the IDE port is present).

The point is that user's may select (or not) the IDE driver.
Some patches are already in the arm-linux mailing list for this; by=20
default all pins are configured for GPIO function, and they remain that=
=20
way if no IDE option is selected.
If the IDE driver is selected and compiled (and running), the driver=20
will then care to claim the IDE pins to the IDE function, through a=20
machine-specific core call (such as ep93xx_ide_on_gpio).
This approach works for both systems with and without IDE driver select=
ed.

>
>> [...]
>
>>>> +static u8 ep93xx_ide_readb(unsigned long base, unsigned long addr=
)
>>>> +{
>>>> +    u32 reg;
>>>> +
>>>> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) |=20
>>>> IDECTRL_DIORN |
>>>> +        IDECTRL_DIOWN;
>>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>>> +    ndelay(25);
>>>> +
>>>> +    reg &=3D ~IDECTRL_DIORN;
>>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>>> +    ndelay(70);
>>>> +
>>>> +    while (!ep93xx_ide_check_iordy())
>>>> +        cpu_relax();
>>>> +
>>>> +    reg |=3D IDECTRL_DIORN;
>>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>>> +    ndelay(25);
>>>> +
>>>> +    return readl(IDE_REGISTER(IDEDATAIN));
>
>>>    Hey, how this even works (if the data doesn't get latched=20
>>> somehow)?! You
>>> should read the register right *before* the deassertion of -DIORx! =
The
>>> minimum data hold time is only 5 ns and the data lines will be=20
>>> tristated
>>> within 30 ns maximum...
>
>> Will be fixed.
>
>    Again, I don't know, maybe the data register is indeed latched by=20
> the controller at the rising edge of -DIOR... because this code most=20
> probably wouldn't work otherwise. Please check the documentation,=20
> maybe it's illegal to read the data before the deassertion of -DIOR. =
=20
> But at least doing it after 25 ns delay looked too much fishy...

Please check my earliest emails; i've described the behaviour of the ID=
E=20
controller.

>
>>>> +
>>>> +    reg &=3D ~IDECTRL_DIOWN;
>>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>>> +    ndelay(70);
>>>> +
>>>> +    while (!ep93xx_ide_check_iordy())
>>>> +        cpu_relax();
>>>> +
>>>> +    reg |=3D IDECTRL_DIOWN;
>>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>>> +    ndelay(25);
>>>> +}
>>>> +
>
>>> [...]
>
>>>    The same question: why we need both ep93xx_ide_write[bw]()?
>
>> Same answer as before. Perhaps there's no need for those.
>
>>>    Since this is not a hotplug driver, you can save some memory on=20
>>> making ep93xx_ide_probe() __init -- using platform_driver_probe()=20
>>> here instead of platform_driver_register() and *not* initializing=20
>>> the 'probe' field of the 'struct platform_driver'.
>
>> I think Ryan and Hartley would like this driver to be=20
>> loadable/unloadable at runtime, as I pointed out earlier in this mai=
l.
>
>    So what? It'll remain [un]loadable...

I've also came to that conclusion (now).

Gosh, I really need to study harder my "Linux Device Drivers" book ;-) =
=2E

Best regards,
Jo=E3o Ramos


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

