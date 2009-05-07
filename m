From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Thu, 07 May 2009 12:01:55 +0100
Message-ID: <4A02BFA3.2000200@inov.pt>
References: <49CCD7C4.8000207@inov.pt>	<49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com>	<49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com>	<49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com>	<4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com> <4A02AB9C.4050107@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:48751 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbZEGLDs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 May 2009 07:03:48 -0400
In-Reply-To: <4A02AB9C.4050107@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org


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
>>>      =20
>>    Hey, how this even works (if the data doesn't get latched=20
>> somehow)?! You
>> should read the register right *before* the deassertion of -DIORx! T=
he
>> minimum data hold time is only 5 ns and the data lines will be trist=
ated
>> within 30 ns maximum...
>>    =20

EP93xx User's Guide, Section 27 - 14 (IDEDataIn register Description)=20
<quote>:

"In PIO mode read operation, this register is the Input Data Registers,=
=20
containing the register contents or the data read from the device. The=20
register is loaded from the DD pins at the positive edge of the DIORn=20
signal. The register is read-only in this operation. ... "

Meaning, the data is latched from the data bus at the positive edge of=20
DIORn, and transfered into the IDEDATAIN register.

The above procedure is correct, according to this.

[...]
>
>>> +static void
>>> +ep93xx_ide_writeb(unsigned long base, u8 value, unsigned long addr=
)
>>> +{
>>> +    u32 reg;
>>> +
>>> +    reg =3D ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_=
DIORN |
>>> +        IDECTRL_DIOWN;
>>> +    writel(reg, IDE_REGISTER(IDECTRL));
>>> +    ndelay(25);
>>> +
>>> +    writel(value, IDE_REGISTER(IDEDATAOUT));
>>>      =20
>>    Hum, do you know at which moments this controller starts/stops dr=
iving
>> data lines on the IDE bus? After DIOWx- assertion/deassertion?
>>    =20
>
> I will look into that. I based this source code in the CPU's user gui=
de,=20
> which tips a correct procedure for reading/writing in PIO mode.
> But I will check that, as I already had some trouble with the user's=20
> guide...
>  =20

EP93xx User's Guide, Section 27 - 13 (IDEDataOut register Description)=20
<quote>:

"In PIO mode write operation, this register is the Output Data=20
Registers, containing the register contents or the data to be written t=
o=20
the device. The register is driven onto the DD pins when DIOWn is low.=20
The register is both read write in this operation. ..."

Meaning, according to this, the procedure is correct. First we prepare=20
the data in the IDEDATAOUT register, then we assert DIOWn and data from=
=20
IDEDATAOUT is transfered to the data bus.

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

