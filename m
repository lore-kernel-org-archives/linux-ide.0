From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 05 May 2009 16:04:38 +0400
Message-ID: <4A002B56.1000802@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com> <49FED069.9080501@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:7579 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753314AbZEEMDO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2009 08:03:14 -0400
In-Reply-To: <49FED069.9080501@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Hello.

Jo=E3o Ramos wrote:

>>> Patch follows.
>>>
>>> diff -urN linux-2.6.29.orig/arch/arm/mach-ep93xx/core.c=20
>>> linux-2.6.29/arch/arm/mach-ep93xx/core.c
>>> --- linux-2.6.29.orig/arch/arm/mach-ep93xx/core.c    2009-03-23=20
>>> 23:12:14.000000000 +0000
>>> +++ linux-2.6.29/arch/arm/mach-ep93xx/core.c    2009-03-30=20
>>> 13:52:04.000000000 +0100
>>> @@ -537,6 +537,51 @@
>>>      platform_device_register(&ep93xx_i2c_device);
>>>  }
>>> =20
>>> +static struct resource ep93xx_ide_resources[] =3D {
>>> +    [0] =3D {

>>    Your code uses 4-space indentation instead of single-tab -- this=20
>> style is not acceptable. I'd advise to run the patch thru=20
>> scripts/checkpatch.pl to find and fix the coding style mistakes.

> The problem is mainly my mailer settings: it deforms the patch output=
=2E=20
> Perhaps next time I should send the patch as an attachment?

    Well, if the IDE maintainer doesn't mind, I don't either. Just make=
 sure=20
the attachment will have the MIME type of text/plain.

>>> +/*
>>> + * IDE Interface register map default state
>>> + * (shutdown)
>>> + */
>>> +static void
>>> +ep93xx_ide_pio_clean_regs(unsigned long base)
>>> +{
>>> +    /* disable IDE interface initially, ensuring that no device is=
=20
>>> selected */
>>> +    writel((IDECTRL_CS0N | IDECTRL_CS1N), IDE_REGISTER(IDECTRL));
>>> +
>>> +    /* clear IDE registers */
>>> +    writel(0, IDE_REGISTER(IDECFG));
>>
>>
>>    Writing 0 to this register generates an invalid cycle on IDE bus =
if=20
>> I don't mistake (CS0/1 and DIOR/W all asserted), are you sure you wa=
nt=20
>> this?

> Zero (0) is the default value for the IDE Configuration Register, as=20
> stated in EP93xx User's Guide (Section 27, page 11).
> Besides, CS0/1 and DIOR/W lines are controlled through IDE Control=20
> Register.

    Sorry, I seem to have mixed them up...

> In that case, perhaps it would be best to have it also set to it's=20
> default value, deasserting DIOR/W as well:

> writel((IDECTRL_CS0N | IDECTRL_CS1N | IDECTRL_DIORN | IDECTRL_DIOWN),=
=20
> IDE_REGISTER(IDECTRL));

    Yes, that's what I had in mind...

>>> +/*
>>> + * EP93xx IDE PIO low-level hardware initialization routine
>>> + */
>>> +static void
>>> +ep93xx_ide_pio_init_hwif(ide_hwif_t *hwif)
>>> +{
>>> +    unsigned long base =3D hwif->config_data;
>>> +
>>> +    /* enforce reset state */
>>> +    ep93xx_ide_pio_clean_regs(base);
>>> +
>>> +    /* set gpio port E, G and H for IDE */
>>> +    ep93xx_ide_gpio_on_ide();
>>> +
>>> +    /*
>>> +     * configure IDE interface:
>>> +     *   - IDE Master Enable
>>> +     *   - Polled IO Operation
>>> +     *   - PIO Mode 4 (16.67 MBps)
>>> +     *   - 1 Wait State (10 ns)
>>> +     */
>>> +    writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_4 |
>>> +           ((1 << 8) & IDECFG_WST), IDE_REGISTER(IDECFG));
>>> +}
>>> +
>>> +/*
>>> + * EP93xx IDE PIO low-level byte-read procedure.
>>> + */
>>> +static u8
>>> +ep93xx_ide_pio_readb(unsigned long base, unsigned long addr)
>>> +{
>>> +    u32    reg;
>>> +
>>> +    /*
>>> +     * initial state: DIORn=3D1, DIOWn=3D1
>>> +     * write address out
>>> +     * select CS configuration
>>> +     */
>>> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_=
DIORN |
>>> +          IDECTRL_DIOWN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +
>>> +    /*
>>> +     * bring DIORn low
>>> +     */
>>> +    reg &=3D ~IDECTRL_DIORN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +
>>> +    /*
>>> +     * bring DIORn high
>>> +     */
>>> +    reg |=3D IDECTRL_DIORN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +
>>> +    /*
>>> +     * read IDE Data Input Register
>>> +     */
>>> +    return (readl(IDE_REGISTER(IDEDATAIN)) & 0xFF);

>>    Masking is pointless, it's achieved by truncation to 'u8'.

>>> +}

>>    I don't see what warrants minimum active/recovery time here. And =
I=20
>> don't see how you're supporitng PIO modes 3/4 as you're not checking=
=20
>> -IORDY.

> So, you're saying I should check for the IORDY value at the beginning=
=20
> and end of each transfer?

    Only before deasserting -DIOx.

> What exactly do you mean by 'warrant minimum active/recovery time'?=20
> Should I insert manual delays to ensure timing issues?

    Yes, since Cirrus seems to have left you with no option other than=20
bit-banging to emulate I/O cycles, you'll have to use delays...

> [...]

>>> +/*
>>> + * EP93xx IDE PIO low-level word buffer-read procedure
>>> + */
>>> +static void
>>> +ep93xx_ide_pio_readsw(unsigned long base, unsigned long addr, void=
=20
>>> *buf,
>>> +                      unsigned int len)
>>> +{
>>> +    u16    *data =3D (u16 *)buf;
>>> +
>>> +    for (;len;len--)

>>    Put spaces after ; please.

>>> +        *data++ =3D ep93xx_ide_pio_readw(base, addr);

>>    Is this little-endian only code? If not, it's not valid in the bi=
g=20
>> endian mode...

> Should I instead use array-indexing code such as:

> for (; len; len--, i++)
>    data[i] =3D ep93xx_ide_pio_readw(base, addr);

> And the same for 'ep93xx_ide_pio_writesw()' function?

    No, it won't change anything. You should use cpu_to_le16() -- unles=
s=20
somehow ep93xx_ide_pio_readw() always returns little-endian data...

MBR, Sergei
