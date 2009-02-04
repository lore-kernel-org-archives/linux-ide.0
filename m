From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Wed, 04 Feb 2009 19:08:09 +0300
Message-ID: <4989BD69.5050601@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <498987E6.7040909@ru.mvista.com> <200902041547.44149.stf_xl@wp.pl> <4989BC8B.4010105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:21511 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753926AbZBDQHn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Feb 2009 11:07:43 -0500
In-Reply-To: <4989BC8B.4010105@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Hello, I wrote:

>>>> diff --git a/arch/arm/mach-at91/include/mach/board.h 
>>>> b/arch/arm/mach-at91/include/mach/board.h
>>>> index fb51f0e..6674b9b 100644
>>>> --- a/arch/arm/mach-at91/include/mach/board.h
>>>> +++ b/arch/arm/mach-at91/include/mach/board.h
>>>> @@ -59,6 +59,18 @@ struct at91_cf_data {
>>>> };
>>>> extern void __init at91_add_device_cf(struct at91_cf_data *data);
>>>>
>>>> + /* Compact Flash True IDE mode */
>>>> +struct at91_ide_data {
>>>> +    u8    irq_pin;        /* the same meaning as for CF */

>>>  I again have to express my dislike about not passing IRQ the usual 
>>> way. Also, see my comments to the platform code.

>> Yes, I know, I don't like to argue. Only reasoning to use platform irq 
>> resource
>> seams to be: "because other drivers do". However we have exception - 
>> at91_cf
>> also use board->irq_pin, so maybe this driver could also do ?

>    Then why have the memory resource when we can calculate it from the 
> chip select? (I'm not asking you to do that, since the platfrom device 
> resources are user-visible thru /proc/iomem -- even if the driver is not 
> enabled.)

    Oh, I forgot that it's ARM with its #ifdef hell. :-D
Then they're only visible when the driver is enabled.

MBR, Sergei

