From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 -rt] ide: workaround buggy hardware issues with preemptable
 hardirqs
Date: Sat, 28 Jun 2008 14:43:46 +0400
Message-ID: <486615E2.3080802@ru.mvista.com>
References: <20080623234037.GA6793@polina.dev.rtsoft.ru>	<20080623235141.GB17297@elte.hu>	<20080624000016.GA12547@polina.dev.rtsoft.ru>	<20080625123431.GA25452@polina.dev.rtsoft.ru>	<20080628005436.GA1956@polina.dev.rtsoft.ru> <20080628101431.0b64d6c2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:38567 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754583AbYF1Knz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jun 2008 06:43:55 -0400
In-Reply-To: <20080628101431.0b64d6c2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: avorontsov@ru.mvista.com, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>

Hello.

Alan Cox wrote:
>> But some hardware (namely ULi M5228 in the ULi M1575 "Super South Brige")
>> behaves in a strange way: it asserts interrupts as edge sensitive. And
>> because preemptable IRQ handler disables PIC's interrupt, PIC will likely
>> miss it.
>>     
>
> You mean "I've programmed the hardware wrong"
>
> If your M5228 is in native mode it should be generating a level trigger,
> providing you've programmed it in full that way. If you have it in legacy
>   

   His boot log shows the native mode.
   And you don't have much control about the interrupt sense at the IDE 
controller side, you can only select legacy/native (which would mean 
edge/level IRQs respectively) mode but the BIOS has a freedom to say 
misprogram ELCR for the PCI interrupt the controller is using.

> mode then it honours IDEIRT and you want the relevant PIC/APIC input set
> to level.
>
>   

   What's IDEIRT, some ISA bridge register? And why should one set 
[A]PIC to level mode for legacy mode IDE? :-O

> How to program an IDE controller out of legacy mode is a public open
> standard document.
>   

   It's *not* in legacy mode, boot log shows "100# native mode".

>> It would be great to re-configure the ULi bridge or ULi IDE controller
>> to behave sanely, but no one knows how or if this is possible at all
>> (no available specifications).
>>     
>
> You need an NDA with ULi for the documentation or I suspect you can
> program the APIC or EISA level registers to match assuming its a PCI like
> bridge.
>   

   He has an OpenPIC, it's PowerPC SoC, so no ELCR either. Anton said to 
me that OpenPIC inputs from PCI IRQs are correctly programmed for level 
trigger.
Nothe that this ULi chip is on PCI Express, so maybe something is wrong 
with how IRQs are delivered over it to the SoC's PCIE controller

MBR, Sergei


