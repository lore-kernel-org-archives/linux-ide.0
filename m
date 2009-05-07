From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 10:09:21 +1200
Message-ID: <4A035C11.9050505@bluewatersys.com>
References: <49CCD7C4.8000207@inov.pt>
	<49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com>
	<49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com>
	<49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com>
	<4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com>
	<4A02AB9C.4050107@inov.pt>
	<BD79186B4FD85F4B8E60E381CAEE19090172C8D6@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090172C8D6@mi8nycmail19.Mi8.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

H Hartley Sweeten wrote:
> On Thursday, May 07, 2009 2:36 AM, Jo=E3o Ramos wrote:
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
>>>    Shouldn't this be done in the platform code instead?
>> The idea is to make this driver loadable, as suggested earlier by
>> Ryan and Hartley.
>> The IDE pins are initially (and by default) set to GPIO function.
>> If the IDE driver is registered, through specific platform code or
>> by loading the module at runtime, then the IDE driver cares to
>> configure the IDE pins for IDE function, returning them to GPIO
>> function once the driver is unloaded.
>>
>> I think this is the approach desired by the EP93xx maintainers,
>> correct? (Ryan? Hartley?)
> =

> The pins should default to gpio mode and only be set to IDE when this
> driver is used.  =

> =

> If the IDE group objects to having the ep93xx_ide_on_gpio() call in
> the driver it can be moved to the platform code.  I assume if a user
> has selected this driver they are not planning on using the pins for
> gpio so when the driver is registered the pins could be put into IDE
> mode at that time.  The drawback is when the driver is a module the
> pins will still be unavailable for gpio when the driver is not loaded.
> =

>>>    Since this is not a hotplug driver, you can save some memory on =

>>> making ep93xx_ide_probe() __init -- using platform_driver_probe() here =

>>> instead of platform_driver_register() and *not* initializing the =

>>> 'probe' field of the 'struct platform_driver'.
>> I think Ryan and Hartley would like this driver to be =

>> loadable/unloadable at runtime, as I pointed out earlier in this mail.
>> I can make the fixes about this, ensuring Ryan and Hartley will both =

>> agree to them.
> =

> Ryan might have a comment on this.  My platform does not use IDE at
> this time.

You can (and should) use platform_driver_probe and still have the module
be loadable. For the gpio settings, I think that probably the best
approach is to use gpio_request for each of the gpio pins so that
gpio_lib knows that they are in use and sysfs/debugfs will correctly
show they are assigned to ide, and then call ep93xx_ide_on_gpio, so you
will have something like in your init code:

  /* Request gpio bank E */
  for (i =3D 0; i < 7; i++) {
	  err =3D gpio_request(EP93XX_GPIO_LINE_E(i), "ep93xx_ide");
	  if (err)
		  goto fail_gpio_e;
	  err =3D gpio_request(EP93XX_GPIO_LINE_F(i), "ep93xx_ide");
	  if (err)
		  goto fail_gpio_f;
	  err =3D gpio_request(EP93XX_GPIO_LINE_G(i), "ep93xx_ide");
	  if (err)
		  goto fail_gpio_g;
  }

  ep93xx_ide_on_gpio(1);
  return 0;

  fail_gpio_g:
    free_gpio(EP93XX_GPIO_LINE_F(i);
  fail_gpio_f:
    free_gpio(EP93XX_GPIO_LINE_E(i);
  fail_gpio_e:
    for (; i >=3D 0; --i) {
            free_gpio(EP93XX_GPIO_LINE_E(i);
            free_gpio(EP93XX_GPIO_LINE_F(i);
            free_gpio(EP93XX_GPIO_LINE_G(i);
    }

and the following in the release code:

  /* Free gpios */
  for (i =3D 0; i < 7; i++) {
	gpio_free(EP93XX_GPIO_LINE_E(i));
	gpio_free(EP93XX_GPIO_LINE_F(i));
	gpio_free(EP93XX_GPIO_LINE_G(i));
  }

  ep93xx_gpio_on_ide(0);

That way, the module can be loaded at runtime. If any of the gpios are
already in use, then the module load will fail. If not, the gpios will
all be requested and the pins put into alternative function mode. When
the module is removed the gpios will be released and put back into gpio
mode.

If the gpio management is put into the platform code them, as Hartley
said, the E, F and G gpios will all configured for ide regardless of
whether it is actually being used.

~Ryan

-- =

Bluewater Systems Ltd - ARM Technology Solution Centre

       Ryan Mallon                              Unit 5, Amuri Park
       Phone: +64 3 3779127                     404 Barbadoes St
       Fax:   +64 3 3779135                     PO Box 13 889
       Email: ryan@bluewatersys.com             Christchurch, 8013
       Web:   http://www.bluewatersys.com       New Zealand
       Freecall Australia  1800 148 751         USA 1800 261 2934

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
