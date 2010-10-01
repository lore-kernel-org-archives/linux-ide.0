From: Richard <tuxbox.guru@gmail.com>
Subject: Re: Marvel PMP SATA controller
Date: Fri, 01 Oct 2010 07:33:26 +0100
Message-ID: <4CA580B6.8030204@gmail.com>
References: <4CA2E33B.70001@gmail.com> <4CA399FD.6030904@teksavvy.com> <4CA3A27B.3030906@gmail.com> <4CA4932D.6040501@teksavvy.com> <4CA498B5.6090503@gmail.com> <4CA52A20.6060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44822 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab0JAGda (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Oct 2010 02:33:30 -0400
Received: by wwj40 with SMTP id 40so894412wwj.1
        for <linux-ide@vger.kernel.org>; Thu, 30 Sep 2010 23:33:29 -0700 (PDT)
In-Reply-To: <4CA52A20.6060208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org

On 01/10/10 01:24, Robert Hancock wrote:
> On 09/30/2010 08:03 AM, Richard wrote:
>> On 30/09/10 14:39, Mark Lord wrote:
>>> On 10-09-29 04:32 PM, Richard wrote:
>>>> On 29/09/10 20:56, Mark Lord wrote:
>>>
>>>>> What are you trying to do?
>>>> Hi Mark,
>>>>
>>>> Its an embedded device whereby the one HDD I have does not work with
>>>> the Marvel PMP. I have the command to send to the PMP controller but
>>>> I am not an officianado with linux SATA(the code I have is from
>>>> VxWorks) The drive is confirmed working, but the PMP chip does not
>>>> default to SATA Generation 1, and this HDD is a bit dumb to figure it
>>>> out :) - so I have to force the PMP controller to Gen1 mode.
>>>> (I have tons of drives that work just fine, its just this ONE Maxtor
>>>> drive that is being a pain)
>>>>
>>>> The short - I need to write a command to the SATA controller before
>>>> this HDD can be recognised.
>>> ..
>>>
>>> Does the existing libata parameter take care of it for you?
>>>
>>> linux/Documentation/kernel-parameters.txt:
>>> eg. libata.force=[ID:]1.5" ## replace [ID:] with port[.device] for the
>>> PMP and/or HD
>>>
>> Unfortunately not.. which is why I asked how to write commands directly
>> on to the SATA bus from kernel space.
>
> Looking at the code it seems like it should.. what kernel version are 
> you using? See sata_set_spd in libata-core.c, which calls 
> sata_scr_write, which calls sata_pmp_scr_write if it's not a host link..
Its a bit more than 'Put it in to 1.5Gbps speed' - Even when selecting 
this speed nothing happens. When I write to the PMP controller using a 
Finisar SATA analyser (Write 0xE8 Register 0x02 Value 0x11) which 
according to the Marvel specifications is 'Set to SATA Generation 1 and 
Reset Drive' things start to happen.  Unfortunately the kernel is a 
2.6.18 one and there is no hope of updating it in the short term as its 
used across many projects.

Richard
