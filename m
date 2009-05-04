From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Mon, 04 May 2009 12:24:25 +0100
Message-ID: <49FED069.9080501@inov.pt>
References: <49CCD7C4.8000207@inov.pt>
	<49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com>
	<49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <49D0E687.4040101@ru.mvista.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

I'm sorry I've been busy all this time and I hadn't got the opportunity =

(untill now) to check this.
But now I am committed full-time on this.

Sergei Shtylyov escreveu:
> Jo=E3o Ramos wrote:
>> Here is the revised patch according to your comments.
>
>> Most significant changes are:
> [...]
>>  - Removed useless blank lines and white-spaces (Ryan);
>
>   Not all of them yet. :-)

I've seen your comments and I fixed those blank lines.
Sorry, old programming habits ;-) .

>
>
>> Regards,
>> Jo=E3o
>>
>> Patch follows.
>>
>> diff -urN linux-2.6.29.orig/arch/arm/mach-ep93xx/core.c =

>> linux-2.6.29/arch/arm/mach-ep93xx/core.c
>> --- linux-2.6.29.orig/arch/arm/mach-ep93xx/core.c    2009-03-23 =

>> 23:12:14.000000000 +0000
>> +++ linux-2.6.29/arch/arm/mach-ep93xx/core.c    2009-03-30 =

>> 13:52:04.000000000 +0100
>> @@ -537,6 +537,51 @@
>>      platform_device_register(&ep93xx_i2c_device);
>>  }
>>  =

>> +static struct resource ep93xx_ide_resources[] =3D {
>> +    [0] =3D {
>
>    Your code uses 4-space indentation instead of single-tab -- this =

> style is not acceptable. I'd advise to run the patch thru =

> scripts/checkpatch.pl to find and fix the coding style mistakes.

The problem is mainly my mailer settings: it deforms the patch output. =

Perhaps next time I should send the patch as an attachment?
Either way, i've run the patch through both Lindent.pl and checkpatch.pl =

and fixed some identation issues.

[...]


>
>> +/*
>> + * IDE Interface register map default state
>> + * (shutdown)
>> + */
>> +static void
>> +ep93xx_ide_pio_clean_regs(unsigned long base)
>> +{
>> +    /* disable IDE interface initially, ensuring that no device is =

>> selected */
>> +    writel((IDECTRL_CS0N | IDECTRL_CS1N), IDE_REGISTER(IDECTRL));
>> +
>> +    /* clear IDE registers */
>> +    writel(0, IDE_REGISTER(IDECFG));
>
>    Writing 0 to this register generates an invalid cycle on IDE bus if =

> I don't mistake (CS0/1 and DIOR/W all asserted), are you sure you want =

> this?

Zero (0) is the default value for the IDE Configuration Register, as =

stated in EP93xx User's Guide (Section 27, page 11).
Besides, CS0/1 and DIOR/W lines are controlled through IDE Control Register.
In that case, perhaps it would be best to have it also set to it's =

default value, deasserting DIOR/W as well:

writel((IDECTRL_CS0N | IDECTRL_CS1N | IDECTRL_DIORN | IDECTRL_DIOWN), =

IDE_REGISTER(IDECTRL));

>
>> +/*
>> + * EP93xx IDE PIO low-level hardware initialization routine
>> + */
>> +static void
>> +ep93xx_ide_pio_init_hwif(ide_hwif_t *hwif)
>> +{
>> +    unsigned long base =3D hwif->config_data;
>> +
>> +    /* enforce reset state */
>> +    ep93xx_ide_pio_clean_regs(base);
>> +
>> +    /* set gpio port E, G and H for IDE */
>> +    ep93xx_ide_gpio_on_ide();
>> +
>> +    /*
>> +     * configure IDE interface:
>> +     *   - IDE Master Enable
>> +     *   - Polled IO Operation
>> +     *   - PIO Mode 4 (16.67 MBps)
>> +     *   - 1 Wait State (10 ns)
>> +     */
>> +    writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_4 |
>> +           ((1 << 8) & IDECFG_WST), IDE_REGISTER(IDECFG));
>> +}
>> +
>> +/*
>> + * EP93xx IDE PIO low-level byte-read procedure.
>> + */
>> +static u8
>> +ep93xx_ide_pio_readb(unsigned long base, unsigned long addr)
>> +{
>> +    u32    reg;
>> +
>> +    /*
>> +     * initial state: DIORn=3D1, DIOWn=3D1
>> +     * write address out
>> +     * select CS configuration
>> +     */
>> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN=
 |
>> +          IDECTRL_DIOWN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +
>> +    /*
>> +     * bring DIORn low
>> +     */
>> +    reg &=3D ~IDECTRL_DIORN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +
>> +    /*
>> +     * bring DIORn high
>> +     */
>> +    reg |=3D IDECTRL_DIORN;
>> +    writel(reg, IDE_REGISTER(IDECTRL));
>> +
>> +    /*
>> +     * read IDE Data Input Register
>> +     */
>> +    return (readl(IDE_REGISTER(IDEDATAIN)) & 0xFF);
>
>    Masking is pointless, it's achieved by truncation to 'u8'.
>
>> +}
>
>    I don't see what warrants minimum active/recovery time here. And I =

> don't see how you're supporitng PIO modes 3/4 as you're not checking =

> -IORDY.

So, you're saying I should check for the IORDY value at the beginning =

and end of each transfer?
What exactly do you mean by 'warrant minimum active/recovery time'? =

Should I insert manual delays to ensure timing issues?

[...]

>> +/*
>> + * EP93xx IDE PIO low-level word buffer-read procedure
>> + */
>> +static void
>> +ep93xx_ide_pio_readsw(unsigned long base, unsigned long addr, void =

>> *buf,
>> +                      unsigned int len)
>> +{
>> +    u16    *data =3D (u16 *)buf;
>> +
>> +    for (;len;len--)
>
>    Put spaces after ; please.
>
>> +        *data++ =3D ep93xx_ide_pio_readw(base, addr);
>
>    Is this little-endian only code? If not, it's not valid in the big =

> endian mode...

Should I instead use array-indexing code such as:

for (; len; len--, i++)
    data[i] =3D ep93xx_ide_pio_readw(base, addr);

And the same for 'ep93xx_ide_pio_writesw()' function?

[...]

>
>> +static struct ide_port_info    ep93xx_ide_pio_port_info =3D {
>> +    .name        =3D MODULE_NAME,
>> +    .init_hwif    =3D ep93xx_ide_pio_init_hwif,
>> +    .tp_ops     =3D &ep93xx_ide_pio_tp_ops,
>> +    .host_flags    =3D IDE_HFLAG_SINGLE | IDE_HFLAG_NO_DMA | =

>> IDE_HFLAG_MMIO |
>> +                  IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_NO_UNMASK_IRQS,
>> +    .pio_mask    =3D ATA_PIO4,
>
>    I'm not seeing the proper support for any of the PIO modes in your =

> driver as yet...

If you mind to explain to me how to, I would appreciate...

>
>> +static int __devinit ep93xx_ide_pio_probe(struct platform_device *pdev)
>> +{
>> +    int    retval;
>> +
>> +    void __iomem    *ide_base;
>> +
>> +    struct resource    *mem_res;
>> +    struct resource    *irq_res;
>> +
>> +    hw_regs_t    hw;
>> +    hw_regs_t    *hws[] =3D {&hw, NULL, NULL, NULL};
>> +
>> +    struct ide_host    *host;
>> +
>> +    /*
>> +     * collect resources from platform_device structure
>> +     */
>> +    mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    if (!mem_res) {
>> +        dev_err(&pdev->dev, "could not retrieve device memory =

>> resources!\n");
>> +        retval =3D -ENXIO;
>> +        goto fail_return;
>> +    }
>> +
>> +    irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>
>    You could also use platform_get_irq()...

Fixed.

>
>> +    if (!irq_res) {
>> +        dev_err(&pdev->dev, "could not retrieve device IRQ =

>> resource!\n");
>> +        retval =3D -ENXIO;
>> +        goto fail_return;
>> +    }
>> +   +    /* request IDE controller registers memory area */
>> +    if (!request_mem_region(mem_res->start, mem_res->end - =

>> mem_res->start + 1,
>> +                            MODULE_NAME)) {
>> +        dev_err(&pdev->dev, "could not request memory resources!\n");
>> +        retval =3D -EBUSY;
>> +        goto fail_return;
>
>    Pointless goto/label, you could just instead use:
>
>     return retval;

Fixed.

Best regards,
Jo=E3o Ramos

-- =

************************************************************************

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

************************************************************************


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
