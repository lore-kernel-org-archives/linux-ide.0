From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Thu, 05 Feb 2009 19:09:06 +0300
Message-ID: <498B0F22.3090403@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <200902041547.44149.stf_xl@wp.pl> <4989BC8B.4010105@ru.mvista.com> <200902051601.50822.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56271 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751166AbZBEQIl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Feb 2009 11:08:41 -0500
In-Reply-To: <200902051601.50822.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Stanislaw Gruszka wrote:

>>>>>extern void __init at91_add_device_cf(struct at91_cf_data *data);
>>>>>
>>>>>+ /* Compact Flash True IDE mode */
>>>>>+struct at91_ide_data {
>>>>>+	u8	irq_pin;		/* the same meaning as for CF */

>>>> I again have to express my dislike about not passing IRQ the usual 
>>>>way. Also, see my comments to the platform code.

>>>Yes, I know, I don't like to argue. Only reasoning to use platform irq resource
>>>seams to be: "because other drivers do". However we have exception - at91_cf
>>>also use board->irq_pin, so maybe this driver could also do ?

>>    Then why have the memory resource when we can calculate it from the chip 
>>select?  

> Great idea, I very like it :)

    It should have arisen from trying to follow your approach consistently.
    You can then drop the whole idea of using the platform device -- 'struct 
device' already has 'platform_data' member (although... there is a prominent 
example of a platfrom driver using only the platform data to pass all the 
resource information: drivers/serial/8250.c).

> But memory is a platform (cpu) resource,

    I don't get what you're trying to say. AFAIK, there has never been an 
*implication* that the platfrom device resources should be CPU-, and not 
board-specific.

> however board dependend.

    Haven't you just told us that it's not board, but CPU dependent?

>>(I'm not asking you to do that, since the platfrom device resources   
>>are user-visible thru /proc/iomem -- even if the driver is not enabled.)

> Let's distinguish platform (cpu) resources and board resources.

    I'm seeing no point in such distinction. The platfrom device framework was 
created exactly with the assorted on-board devices in mind.

> If you take a look at arch/arm/mach-at91/*_devices.c files, 
> IORESOURCE_IRQ are used for interrupts from devices that are integrated
> on the chip. Board specific irq pins (like in at91_cf, at91_ether) are not
> passed to platform driver via platform_resource but via board data.

    I don't care what the particular broken ARM platfrom code does. If it 
can't pass resources in a normal way, it should be fixed, and not followed as 
a good example.

>>>>>diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
>>>>>new file mode 100644
>>>>>index 0000000..3a1f7e0
>>>>>--- /dev/null
>>>>>+++ b/drivers/ide/at91_ide.c
>>>>>@@ -0,0 +1,496 @@
>>>>>+/*
>>>>>+ * IDE host driver for AT91SAM9 Static Memory Controller

>>>>  Why not call the driver 'at91sam9_ide'?

>>>>>+/*
>>>>>+ * AT91 Static Memory Controller

>>>> AT91SAM9.

>>>Ok, currently only SAM9 can be used with driver. However I think adding
>>>support to AT91RM9200 to this driver will be not much effort.

>>    Can you answer the simple question: why we should try to support two 
>>incompatible chips with a single driver? Because the driver name will be 
>>shorter? :-)

> Very funny. I think patch adding RM9200 support to this driver will have less
> than 50 lines changeset,  whereas writing new driver would be about 500 lines.

    This approach is so broken-minded that I'm just out words to argue any more.
    Let's then support say all the PCI IDE chipsets with the single driver 
(actully, there was a driver that tried to support 2 incompatible Promise chip 
families but it got split finally). Moreover, with AT91RM9200 lacking True IDE 
mode support, the code (if anybody in their right mind would undertake the 
task of adding IDE support) will be different enough from what is there 
already, that I doubt that that imaginary porgrammer would keep clinging to 
the doubtful idea to the very end... anyway, I'm now considering the very 
possibilty of anybody trying to do that minimal, exactly due to AT91RM9200 
lacking True IDE support.

>>>I don't think
>>>someone will want to write new driver for RM9200 insted using this one.

>>    You're right, nobody will want that... because AT91RM9200 as is has *no 
>>support for True IDE mode*. ;-)

> Atmel documents are confusing. AT91RM9200 datasheet tells there is no
> True IDE support,

    There is no confusion there -- at least for me. Yes, there is no True IDE 
support.

> but RM9200 hard drive application note (which I send you a link before) tell it is.

    That is just a total hack. I don't think anyone will really want to use 
the GPIO controlled chip selects that this application note describes... well, 
if only out of total desperation. :-)

> Cheers
> Stanislaw Gruszka

MBR, Sergei
