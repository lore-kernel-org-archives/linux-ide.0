From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3 v2] AT91: initialize Compact Flash on AT91SAM9263
 cpu
Date: Sun, 15 Feb 2009 19:07:25 +0300
Message-ID: <49983DBD.6070300@ru.mvista.com>
References: <200902061214.19789.stf_xl@wp.pl> <498C272A.5070101@ru.mvista.com> <200902061432.20291.stf_xl@wp.pl> <49983C23.3010701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33960 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752400AbZBOQHF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Feb 2009 11:07:05 -0500
In-Reply-To: <49983C23.3010701@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Hello, I wrote:

>>>> +    if (data->det_pin) {
>>>> +        /* check if device is present */
>>>> +        at91_set_gpio_input(data->det_pin, 1);
>>>> +        at91_set_deglitch(data->det_pin, 1);
>>>> +        if (at91_get_gpio_value(data->det_pin) != 0) {
>>>> +            printk(KERN_ERR "AT91: no CF card detected\n");
>>>> +            return;
>>>> +        }
>>>> +    }

>>>   Bart, I'm not sure: don't we support warm-plug now? Or it won't 
>>> avail us with CF?

>> Uhh, this code is wrong at least for PCMCIA as we hotplug there. I 
>> don't think
>> hotplug is supported for ATA devices.

>    I didn't say hot plug, I said *warm* plug. You can force port probing 
> via sysfs, if I don't mistake... Bart?

    See Documentation/ide/warm-plug-howto.txt

MBR, Sergei
