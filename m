From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 16:48:25 +0300
Message-ID: <49787929.2010305@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <200901221212.55528.stf_xl@wp.pl> <49786138.20809@ru.mvista.com> <200901221414.39802.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27255 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752676AbZAVNry (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 08:47:54 -0500
In-Reply-To: <200901221414.39802.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Stanislaw Gruszka wrote:

>>>>>+/* Proper CS address space will be added */
>>>>>+#define AT91_IDE_TASK_FILE	0x00c00000
>>>>>+#define AT91_IDE_CTRL_REG	0x00e00000

>>   Besides, I'm not sure: these 2 address range are decoded via 1 SMC 
>>chip select or 2?

> These are in one chip select address space.

    Then some external circutry converts the single nCS into -CS0 and -CS1?

>>>Well, we could add #ifdef with diffrent implementation of init_smc_mode(), 
>>>set_8bit_mode(), etc... 

>>   No, #ifdef'ery is certainly not an option.

> Why?

    It's totally ugly and unacceptable way of doing things. It seems also 
totally wrong to add support for totally incompatible SMC to this driver 
(especially with #ifdef's). Another driver should be written if CF support is 
required.

> Other option is create some header files and implement and exporting these
> functions from processor specific code. This add files dependencies and spread
> things across sources, FWIW.

    I don't think it's feasible as that SMC is just too different.

>>>>>+	/* values are rounded up so we need to assure cycle is larger than pulse */
>>>>>+	if (t0 < t1 + t2 + t9)
>>>>>+		t0 = t1 + t2 + t9;
>>>>>+
>>>>>+	/* setup calculated timings */
>>>>>+	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(t1) |
>>>>>+						   AT91_SMC_NCS_WRSETUP_(0) |
>>>>>+						   AT91_SMC_NRDSETUP_(t1) |
>>>>>+						   AT91_SMC_NCS_RDSETUP_(0));
>>>>>+	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(t2) |
>>>>>+						   AT91_SMC_NCS_WRPULSE_(t1 + t2 + t9) |

>>>>  With zero address to CS setup time it's the same as t0.

>>>Not true for slower PIO modes.

>>   Well, you're right probably...

     They should better be the same and in any case t1 + t2 + t9 must be no 
less than t0min.

>>>But CS pulse can be t0.

>>   Yes, it must be no less than t0.

> Pulse time can be less than t0, cycle time no.

    nCS pulse time cannot be less than t0min as by address valid ATA spec 
means both address and -CSx valid, not just address.

>>>Maybe this is simpler, host have to react on IORDY signal but device
>>>just not assert it. 

>>>I would like to remove this code and have allways NWAIT
>>>READY mode to make flipping 8/16 simpler.

>>   I don't understand how these are connected.

> Both set SMC MODE register. If I will not change NWAIT in MODE register,
> I can write static values in set_8/16bit_mode and stop doing logical operation on it.

    No, that's undesirable.

>>>>   Why not pass it normally, via the platform device's resource?

>>>Irq pin is board specific. When use resource I will need in processor 
>>>code modify resource.

>>   So what? That's pretty normal and won't take much code.

> I see only more memory and code usage. Let's reverse question:
> Why use RESOURCE_IRQ when we have irq in board data?

    Len't reverse it again: why have it in board data when the normal location 
is the resource? :-)

> Cheers
> Stanislaw Gruszka

MBR, Sergei
