From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 00:32:37 +0100
Message-ID: <4A036F95.7050601@inov.pt>
References: <49CCD7C4.8000207@inov.pt>
	<49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com>
	<49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com>
	<49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com>
	<4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com>
	<4A02AB9C.4050107@inov.pt>
	<BD79186B4FD85F4B8E60E381CAEE19090172C8D6@mi8nycmail19.Mi8.com>
	<4A035C11.9050505@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE19090172C9CC@mi8nycmail19.Mi8.com>
	<4A0365D5.5020306@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE19090172C9E1@mi8nycmail19.Mi8.com>
	<4A036AE1.5080706@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4A036AE1.5080706@bluewatersys.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Ryan Mallon escreveu:
> H Hartley Sweeten wrote:
>   =

>> On Thursday, May 07, 2009 3:51 PM, Ryan Mallon wrote:
>>     =

>>>>> You can (and should) use platform_driver_probe and still have
>>>>> the module be loadable. For the gpio settings, I think that
>>>>> probably the best approach is to use gpio_request for each of
>>>>> the gpio pins so that gpio_lib knows that they are in use and
>>>>> sysfs/debugfs will correctly show they are assigned to ide,
>>>>> and then call ep93xx_ide_on_gpio, so you will have something
>>>>> like in your init code:
>>>>>           =


As for the platform_driver_probe, I will fix that then.

>>>> Hmmm...
>>>>
>>>> How about doing all the request/free's in the ep93xx_ide_on_gpio()
>>>> function?  That way the platform code can initially call it and set
>>>> all the pins into gpio mode (freeing them).  Then later when the
>>>> IDE driver is loaded it can call the function to try and put the
>>>> pins into IDE mode (requesting them).  If any of the pins are
>>>> unavailable the ep93xx_ide_on_gpio() function can return the
>>>> necessary error code preventing the IDE driver from loading.  When
>>>> the driver is unloaded it just needs to call the core to free
>>>> the gpio's.
>>>>
>>>> Something like:
>>>>
>>>> int ep93xx_ide_on_gpio(int enable)
>>>> {
>>>> 	u32 reg;
>>>> 	int err;
>>>> 	int i;
>>>>
>>>> 	reg =3D __raw_read(EP93XX_SYSCON_DEVICE_CONFIG);
>>>>
>>>> 	if (enable) {
>>>> 		for (i =3D 0; i < 8; i++) {
>>>> 			err =3D gpio_request(EP93XX_GPIO_LINE_E(i), "ep93xx_ide");
>>>> 			if (err)
>>>> 				goto fail_gpio_e;
>>>> 			err =3D gpio_request(EP93XX_GPIO_LINE_F(i), "ep93xx_ide");
>>>> 			if (err)
>>>> 				goto fail_gpio_f;
>>>> 			err =3D gpio_request(EP93XX_GPIO_LINE_G(i), "ep93xx_ide");
>>>> 			if (err)
>>>> 				goto fail_gpio_g;
>>>> 		}
>>>> 		reg &=3D ~(EP93XX_SYSCON_DEVICE_CONFIG_EONIDE |
>>>> 			EP93XX_SYSCON_DEVICE_CONFIG_GONIDE |
>>>> 			EP93XX_SYSCON_DEVICE_CONFIG_HONIDE);
>>>> 	} else {
>>>> 		for (i =3D 0; i < 8; i++) {
>>>> 			gpio_free(EP93XX_GPIO_LINE_E(i));
>>>> 			gpio_free(EP93XX_GPIO_LINE_F(i));
>>>> 			gpio_free(EP93XX_GPIO_LINE_G(i));
>>>> 		}
>>>> 		reg |=3D (EP93XX_SYSCON_DEVICE_CONFIG_EONIDE |
>>>> 			EP93XX_SYSCON_DEVICE_CONFIG_GONIDE |
>>>> 			EP93XX_SYSCON_DEVICE_CONFIG_HONIDE);
>>>> 	}
>>>> 	=

>>>> 	__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
>>>> 	__raw_writel(reg, EP93XX_SYSCON_DEVICE_CONFIG);	=

>>>>         =

>>> Is this going to be modified later to use the ep93xx_syscon_ functions
>>> once they are merged?
>>>       =

>> Yes, hopefully that occurs sometime soon.  Still no responses on it.
>>     =


I was hoping for that patch to be merged to use the functions provided =

to write Syscon locked registers.
In the meanwhile, as it isn't in the mainline kernel yet, I used this form.

>>     =

>>>> 	return 0;
>>>>
>>>> fail_gpio_g:
>>>> 	free_gpio(EP93XX_GPIO_LINE_F(i);
>>>> fail_gpio_f:
>>>> 	free_gpio(EP93XX_GPIO_LINE_E(i);
>>>> fail_gpio_e:
>>>> 	for ( ; i >=3D 0; --i) {
>>>> 		free_gpio(EP93XX_GPIO_LINE_E(i);
>>>> 		free_gpio(EP93XX_GPIO_LINE_F(i);
>>>> 		free_gpio(EP93XX_GPIO_LINE_G(i);
>>>> 	}
>>>> 	return err;
>>>> }
>>>>         =

>>> Yeah, that makes sense. Keeps the driver nice and clean that way too.
>>> The ep93xx_ide_on_gpio function for core.c should be posted as a
>>> separate patch though.
>>>
>>>       =

>> I agree.  Actually that patch needs to go in now so that the port E/F/G
>> pins will work for normal GPIO.  The syscon register defaults at reset w=
ith
>> the bits cleared so the boot state has them set for IDE mode.  That drove
>> me nuts for quite a while...
>>
>> If wanted I will put together the necessary patch for this.
>>     =

>
> That would be good. I think that we should default all of the pins to
> gpio mode on boot, and then drivers should call into core.c to put pins
> in alternative function mode where necessary.
>   =


Hartley, will you handle this then, or do you want me to submit a =

separate patch for the renewed 'ep93xx_ide_on_gpio' function?
I can do this and test it already with the IDE patch to see if it's OK.

>   =

>> This function will hopefully get a bit cleaner later.  I've been messing
>> with an addition to the GPIOLIB API to add support for "ports".  When/if
>> that goes in all the for() loops go away and you just need to do a
>> gpio_port_request(...) to grab the pins and gpio_port_free(...) to put
>> them back.
>>     =

>
> It would be nice if gpiolib had some understanding of alternative
> function modes for gpios. However I'm not sure that it can be done in a
> generic way that will suit all architectures/chips.
>
>   =

>> Ahh.. If only the days were longer....
>>     =

>
> Agreed :-).
>
> ~Ryan
>
>   =



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
