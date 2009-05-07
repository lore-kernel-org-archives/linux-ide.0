From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 10:51:01 +1200
Message-ID: <4A0365D5.5020306@bluewatersys.com>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com> <49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com> <4A019BE4.9020903@inov.pt> <4A01C376.8000803@ru.mvista.com> <4A02AB9C.4050107@inov.pt> <BD79186B4FD85F4B8E60E381CAEE19090172C8D6@mi8nycmail19.Mi8.com> <4A035C11.9050505@bluewatersys.com> <BD79186B4FD85F4B8E60E381CAEE19090172C9CC@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 130.120.124.202.static.snap.net.nz ([202.124.120.130]:37541
	"EHLO hayes.bluewaternz.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751452AbZEGWuy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 May 2009 18:50:54 -0400
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090172C9CC@mi8nycmail19.Mi8.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

H Hartley Sweeten wrote:
> On Thursday, May 07, 2009 3:09 PM, Ryan Mallon wrote:
>> You can (and should) use platform_driver_probe and still have the
>> module be loadable. For the gpio settings, I think that probably
>> the best approach is to use gpio_request for each of the gpio pins
>> so that gpio_lib knows that they are in use and sysfs/debugfs will
>> correctly show they are assigned to ide, and then call
>> ep93xx_ide_on_gpio, so you will have something like in your init code:
> 
> Hmmm...
> 
> How about doing all the request/free's in the ep93xx_ide_on_gpio()
> function?  That way the platform code can initially call it and set
> all the pins into gpio mode (freeing them).  Then later when the
> IDE driver is loaded it can call the function to try and put the
> pins into IDE mode (requesting them).  If any of the pins are
> unavailable the ep93xx_ide_on_gpio() function can return the
> necessary error code preventing the IDE driver from loading.  When
> the driver is unloaded it just needs to call the core to free
> the gpio's.
> 
> Something like:
> 
> int ep93xx_ide_on_gpio(int enable)
> {
> 	u32 reg;
> 	int err;
> 	int i;
> 
> 	reg = __raw_read(EP93XX_SYSCON_DEVICE_CONFIG);
> 
> 	if (enable) {
> 		for (i = 0; i < 8; i++) {
> 			err = gpio_request(EP93XX_GPIO_LINE_E(i), "ep93xx_ide");
> 			if (err)
> 				goto fail_gpio_e;
> 			err = gpio_request(EP93XX_GPIO_LINE_F(i), "ep93xx_ide");
> 			if (err)
> 				goto fail_gpio_f;
> 			err = gpio_request(EP93XX_GPIO_LINE_G(i), "ep93xx_ide");
> 			if (err)
> 				goto fail_gpio_g;
> 		}
> 		reg &= ~(EP93XX_SYSCON_DEVICE_CONFIG_EONIDE |
> 			EP93XX_SYSCON_DEVICE_CONFIG_GONIDE |
> 			EP93XX_SYSCON_DEVICE_CONFIG_HONIDE);
> 	} else {
> 		for (i = 0; i < 8; i++) {
> 			gpio_free(EP93XX_GPIO_LINE_E(i));
> 			gpio_free(EP93XX_GPIO_LINE_F(i));
> 			gpio_free(EP93XX_GPIO_LINE_G(i));
> 		}
> 		reg |= (EP93XX_SYSCON_DEVICE_CONFIG_EONIDE |
> 			EP93XX_SYSCON_DEVICE_CONFIG_GONIDE |
> 			EP93XX_SYSCON_DEVICE_CONFIG_HONIDE);
> 	}
> 	
> 	__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
> 	__raw_writel(reg, EP93XX_SYSCON_DEVICE_CONFIG);	

Is this going to be modified later to use the ep93xx_syscon_ functions
once they are merged?

> 	return 0;
> 
> fail_gpio_g:
> 	free_gpio(EP93XX_GPIO_LINE_F(i);
> fail_gpio_f:
> 	free_gpio(EP93XX_GPIO_LINE_E(i);
> fail_gpio_e:
> 	for ( ; i >= 0; --i) {
> 		free_gpio(EP93XX_GPIO_LINE_E(i);
> 		free_gpio(EP93XX_GPIO_LINE_F(i);
> 		free_gpio(EP93XX_GPIO_LINE_G(i);
> 	}
> 	return err;
> }

Yeah, that makes sense. Keeps the driver nice and clean that way too.
The ep93xx_ide_on_gpio function for core.c should be posted as a
separate patch though.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

       Ryan Mallon                              Unit 5, Amuri Park
       Phone: +64 3 3779127                     404 Barbadoes St
       Fax:   +64 3 3779135                     PO Box 13 889
       Email: ryan@bluewatersys.com             Christchurch, 8013
       Web:   http://www.bluewatersys.com       New Zealand
       Freecall Australia  1800 148 751         USA 1800 261 2934
