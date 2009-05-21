From: Karl Hiramoto <karl@hiramoto.org>
Subject: Re: PCI IRQ Pins
Date: Thu, 21 May 2009 17:07:34 +0200
Message-ID: <4A156E36.6080806@hiramoto.org>
References: <4A13EC76.3020206@hiramoto.org>	<m3r5ykgd97.fsf@intrepid.localdomain>	<20090520205151.GC4095@n2100.arm.linux.org.uk>	<m3zld7cuxk.fsf@intrepid.localdomain>	<4A14F160.6080605@hiramoto.org> <4A150B9A.7080700@hiramoto.org>	<4A1568FB.20508@ru.mvista.com> <4A156A21.2060108@hiramoto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:49352 "EHLO
	spunkymail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752989AbZEUPHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2009 11:07:42 -0400
In-Reply-To: <4A156A21.2060108@hiramoto.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "ath9k-devel@lists.ath9k.org" <ath9k-devel@lists.ath9k.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-ide@vger.kernel.org

Karl Hiramoto wrote:
> Sergei Shtylyov wrote:
>   
>> Hello.
>>
>> Karl Hiramoto wrote:
>>
>>     
>>>> Krzysztof Halasa wrote:
>>>>         
>>>>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>>>>>           
>>>>>> Normally you get a backtrace when a "nobody cared" message is
>>>>>> issued -
>>>>>> this should tell you which driver is probably the cause.
>>>>>>             
>>>>> Right - or that the other device is the cause (stuck IRQ line). So,
>>>>> Karl, please just post the backtrace.
>>>>>           
>>>> Krzysztof, you mentioned clearing the IRQ in the platform code, is
>>>> there an example of this somewhere?
>>>>         
>>>> There is a Compact flash on hda connected the the HPT371N, looking
>>>> at the IDE code it looks like the drive my not be ready, or the
>>>> drive may raise the IRQ..
>>>>         
>>>> As soon as request_irq is called, the IRQ happens.
>>>>         
>>>> CCing linux-IDE now, as it may be an issue with this driver.
>>>>         
>>>> Backtrace below, sorry about some of the lines being wrapped.
>>>>         
>>> I think i see the problem:
>>>       
>>> In the platform code, i should save the frequency of 33 Mhz in the
>>> correct register.
>>>       
>> You mean the PCI frequency?
>>
>>     
>>>> hpt366: HPT371N chipset detected
>>>> hpt366 0000:00:01.0: IDE controller (0x1103:0x0007 rev 0x02)
>>>> PCI: enabling device 0000:00:01.0 (0140 -> 0141)
>>>> hpt366 0000:00:01.0: IDE port disabled
>>>> hpt366 0000:00:01.0: no clock data saved by BIOS
>>>> hpt366 0000:00:01.0: DPLL base: 77 MHz, f_CNT: 120, assuming 50 MHz PCI
>>>>         
>> Hum, interesting... is your PCI indeed running at a frequency close to
>> 50 MHz?
>>     
>
> No, it's being miscalculated by the hpt366 driver. I think it should be
> 33 Mhz. At least i have not yet seen this IRQ "nobody cared" message
> when i set it to 33Mhz in the hpt366 driver.
> Still doing more tests to see if it comes up again, but it's hard to
> reproduce.
>
>
>   
Sorry, think i misspoke,  after reading the IXP4xx dev manual it says 
66Mhz PCI version 2.2.



-- 

--
Karl Hiramoto  http://karl.hiramoto.org/


