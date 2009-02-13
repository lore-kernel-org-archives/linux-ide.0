From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263
 cpu
Date: Fri, 13 Feb 2009 16:23:38 +0300
Message-ID: <4995745A.5000704@ru.mvista.com>
References: <200902091145.11266.stf_xl@wp.pl> <cd73a99e0902111203k7670f9d8w17cc90b7dec343fd@mail.gmail.com> <200902121033.57176.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2114 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754409AbZBMNXp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Feb 2009 08:23:45 -0500
In-Reply-To: <200902121033.57176.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <avictor.za@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

>>> +       if (data->flags & AT91_CF_TRUE_IDE) {
>>> +               /* check if device is present */
>>> +               if (data->det_pin && at91_get_gpio_value(data->det_pin) != 0) {
>>> +                       printk(KERN_ERR "AT91 CF True IDE: no device detected\n");
>>> +                       return;
>>> +               }
>>> +               if (data->rst_pin) {
>>> +                       /* reset the card */
>>> +                       at91_set_gpio_output(data->rst_pin, 0);
>>> +                       /* wait as defined in ATA7 vol2 (rev 4a) figure 36 */
>>> +                       udelay(25);
>>> +                       at91_set_gpio_output(data->rst_pin, 1);
>>> +               }
>>>       
>> Shouldn't this rather be done in the at91_ide driver?
>> I don't want to duplicate it in all the different at91sam9XX_devices.c files.
>>     
>
> Ok, I'll move detection stuff to the driver. Not sure about reset, see my 
>   

   AT91_CF_TRUE_IDE then can possibly be eliminated. There's not dire 
need for this device to have different names...

> previous mail on this issue. Could we move the reset into driver and
> risk system boot with device which possibly generate interrupts?
>   

   I don't see how keeping hardware reset in the platfrom code helps 
here -- you have that code inside #ifdef, so it's only executed when the 
driver is enabled anyway. Hm, except when the driver is built as a 
module -- in this case it should help...

MBR, Sergei


