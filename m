From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263
 cpu
Date: Thu, 12 Feb 2009 19:33:08 +0300
Message-ID: <49944F44.1080807@ru.mvista.com>
References: <200902091145.11266.stf_xl@wp.pl> <4992D9A4.30205@ru.mvista.com> <200902121005.46772.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:38614 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753493AbZBLQcq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Feb 2009 11:32:46 -0500
In-Reply-To: <200902121005.46772.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

>>[...]

>>>+	if (data->flags & AT91_CF_TRUE_IDE) {
>>>+		/* check if device is present */
>>>+		if (data->det_pin && at91_get_gpio_value(data->det_pin) != 0) {
>>>+			printk(KERN_ERR "AT91 CF True IDE: no device detected\n");
>>>+			return;
>>>+		}
>>>+		if (data->rst_pin) {
>>>+			/* reset the card */
>>>+			at91_set_gpio_output(data->rst_pin, 0);
>>>+			/* wait as defined in ATA7 vol2 (rev 4a) figure 36 */
>>>+			udelay(25);
>>>+			at91_set_gpio_output(data->rst_pin, 1);

>>   I'm still not sure why this is needed. Do you think thta power-on 
>>reset is not enough?

> HW reset is not needed when board is powered-on. But situation is
> diffrent when we have reboot due to board reset booton press.
> There are configuration where signal from reset button is connected
> to CF card (or disk), in some cases device reset signal is connected to
> GPIO with assumption to be asserted by software.

    OK, thanks for the explanation.

> I don't know if we can remove this.

    Well, seems worth keeping.

> In hw reset case system/driver will run with undefined device state,

    What do you mean by undefined? It could have not come out of reset which 
shoiuld mean that the IDE probing code will have to wait some time before BSY 
clears -- see ide_port_wait_ready().

> in example device can generate interrupts.

    Interrupts after any kind of reset? That just shouldn't happen -- it's 
against the ATA spec at least.

> Stanislaw Gruszka

MBR, Sergei
