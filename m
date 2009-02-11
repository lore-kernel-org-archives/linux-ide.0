From: Andrew Victor <avictor.za@gmail.com>
Subject: Re: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Wed, 11 Feb 2009 22:03:29 +0200
Message-ID: <cd73a99e0902111203k7670f9d8w17cc90b7dec343fd@mail.gmail.com>
References: <200902091145.11266.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:12256 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757658AbZBKUDb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2009 15:03:31 -0500
Received: by ug-out-1314.google.com with SMTP id 39so18128ugf.37
        for <linux-ide@vger.kernel.org>; Wed, 11 Feb 2009 12:03:29 -0800 (PST)
In-Reply-To: <200902091145.11266.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

hi Stanislaw,

> +       if (data->flags & AT91_CF_TRUE_IDE) {
> +               /* check if device is present */
> +               if (data->det_pin && at91_get_gpio_value(data->det_pin) != 0) {
> +                       printk(KERN_ERR "AT91 CF True IDE: no device detected\n");
> +                       return;
> +               }
> +               if (data->rst_pin) {
> +                       /* reset the card */
> +                       at91_set_gpio_output(data->rst_pin, 0);
> +                       /* wait as defined in ATA7 vol2 (rev 4a) figure 36 */
> +                       udelay(25);
> +                       at91_set_gpio_output(data->rst_pin, 1);
> +               }

Shouldn't this rather be done in the at91_ide driver?
I don't want to duplicate it in all the different at91sam9XX_devices.c files.

You could also define two separate "CF type" devices - one for CS4,
another for CS5.
That would allow for two independent "CF type" interfaces to be used
at the same time (see at91sam9260_devices.c in maxim.org.za patches).


Regards,
  Andrew Victor
