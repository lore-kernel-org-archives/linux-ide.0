From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: EP93xx PIO IDE driver proposal
Date: Thu, 7 May 2009 12:52:53 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090172C8D6@mi8nycmail19.Mi8.com>
References: <49CCD7C4.8000207@inov.pt>
	<49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com>
	<49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com>
	<49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com>
	<4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com>
	<4A02AB9C.4050107@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-class: urn:content-classes:message
In-Reply-To: <4A02AB9C.4050107@inov.pt>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: =?iso-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday, May 07, 2009 2:36 AM, Jo=E3o Ramos wrote:
>>>
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
>>
>>    Shouldn't this be done in the platform code instead?
>
> The idea is to make this driver loadable, as suggested earlier by
> Ryan and Hartley.
> The IDE pins are initially (and by default) set to GPIO function.
> If the IDE driver is registered, through specific platform code or
> by loading the module at runtime, then the IDE driver cares to
> configure the IDE pins for IDE function, returning them to GPIO
> function once the driver is unloaded.
>
> I think this is the approach desired by the EP93xx maintainers,
> correct? (Ryan? Hartley?)

The pins should default to gpio mode and only be set to IDE when this
driver is used.  =


If the IDE group objects to having the ep93xx_ide_on_gpio() call in
the driver it can be moved to the platform code.  I assume if a user
has selected this driver they are not planning on using the pins for
gpio so when the driver is registered the pins could be put into IDE
mode at that time.  The drawback is when the driver is a module the
pins will still be unavailable for gpio when the driver is not loaded.

>>    Since this is not a hotplug driver, you can save some memory on =

>> making ep93xx_ide_probe() __init -- using platform_driver_probe() here =

>> instead of platform_driver_register() and *not* initializing the =

>> 'probe' field of the 'struct platform_driver'.
>
> I think Ryan and Hartley would like this driver to be =

> loadable/unloadable at runtime, as I pointed out earlier in this mail.
> I can make the fixes about this, ensuring Ryan and Hartley will both =

> agree to them.

Ryan might have a comment on this.  My platform does not use IDE at
this time.

Regards,
Hartley

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
