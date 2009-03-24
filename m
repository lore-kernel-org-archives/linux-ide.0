From: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?=
	<vladimir.dashevsky@gmail.com>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Tue, 24 Mar 2009 11:26:34 +0300
Message-ID: <49C8993A.9010206@gmail.com>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org> <49C63457.8040203@gmail.com> <49C6547E.5050005@kernel.org> <49C6623D.7080305@gmail.com> <49C66A24.5000804@kernel.org> <49C682CD.9010007@gmail.com> <49C6EE49.9080307@kernel.org> <49C774AC.50603@gmail.com> <49C77A00.6020204@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010403080006070704000108"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:2170 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbZCXI22 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Mar 2009 04:28:28 -0400
Received: by ey-out-2122.google.com with SMTP id 4so628116eyf.37
        for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2009 01:28:25 -0700 (PDT)
In-Reply-To: <49C77A00.6020204@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010403080006070704000108
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Tejun!
> No it won't show up and I can't really answer all your linux related
> questions.  Sorry.  :-P
>   
Nice system...
>
>>> Yeah, I know it has been in the spec but without hardware to play with
>>> it's difficult to add driver features and lack of general availability
>>> also means lower demand.
>>>   
>>>       
>> Well, I just cannot imagine how software raid can work without clearly
>> visible state. One drive mixed up in RAID5 and the whole array can get
>> damaged. And it is not so difficult to mix them up because drive names
>> may differ from physical slot numbers.
>>     
>
> Yeah, it can be tricky but highend machine usually go with sas and
> consumer grade machines don't really care, so there just aren't too
> many ahci machines with enclosure support.  Well, not here anyway.
>
>   
As for me, there is a lot of tasks where the main issue is a reliablity 
and not nesessary a performance.
SAS cannot be used for RAID anyway, it's closer to RAED. I guess that 
software RAID can be the best solution for every case where reliablity 
and online scalability is needed.
>>> I think it should be independent from RAID but having general
>>> enclosure support will be nice.  Care to post the patches?
>>>
>>>   
>>>       
>> Well, I can provide you with a code which works on my ICH9 Supermicro
>> platform. I believe it will also work with both ICH8 and ICH10.
>> However, since I could not install this module as traditional pci driver
>> (the kernel decided not to claim my ahci device since the main driver
>> present in the system) I had to rewrite it as a general linux kernel
>> module. It justs scan pci devices for AHCI capable ones and remaps their
>> ABAR to try enclosure management support. For now, only my ICH9 PCI IDs
>> are in my try list. All AHCI EM-capable devices get their associated
>> proc interface - /proc/ahci_emX/leds*. This module actually works in
>> parallel with kernel ahci driver but I think it will be a conflict with
>> it once the kernel driver starts to support em by itself. I guess, the
>> best way would be to document some API for controlling the EM, then to
>> declare some kernel ahci flag that will indicate full EM presence in the
>> kernel. Then I can improve my ahci_em module to skip its installation
>> when similar functions are built into the kernel.
>>
>> My interface is quite simple. You just write a char to leds-controlling
>> proc file to set state of leds, for example:
>> echo r > /proc/ahci_em0/leds0 means you asked for REBUILD state
>> indicated in the bay of port 0.
>> I think that most of users would prefer additional module rather that
>> kernel udgrade, for the first time. Also, I am not very close to linux
>> kernel to provide a kernel patch.
>>     
>
> I don't think the design you described would fit into upstream kernel
> too well but if you have it working it's some place to start.  Just
> refresh in on top of the current devel kernel and let's see what can
> be done.
>   
Sorry, I am not so close to linux kernel to perform a jump from my 
current kernel
(2.6.25) to latest one. I am sending you the sources of kernel module 
which performs all LEDs EM functions.
The code is simple and relatively small. I have brushed it up to be more 
readable.

If you decide it useful and will change user API for this (eg, move proc 
interface to sys interface) then let me know.
I would like to design this software so that module could be used with 
older kernels and have the same behavior as newer kenels will have. this 
will help to spread this technology among machines where kernel cannot 
be upgraded for some reasons.

Usage notes:
1. Use 'make' to make driver module.
2. Use 'make reload' to (re)install driver into a system
3. Use 'echo X > /proc/ahci_em0/ledsN' to set state of leds for porn N 
(N is 0 to 5 for ICH9).
X is one of the:
'N' - normal state (leds off)
'L' - locate state (4Hz blinking)
'R' - rebuild state (1Hz blinking)
'F' - failure state (solid + beep)
'P' - predicted failure state (two 4Hz blinks in 1 second )
'H' - hot spare ( two 4Hz blinks in 4 seconds).
My enclosure has only one state LED (besides activity LED) so I 
developed blink patterns as described here:
http://en.wikipedia.org/wiki/IBPI


Best regards, Vladimir Dashevsky


--------------010403080006070704000108
Content-Type: application/gzip;
 name="ahci_em.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ahci_em.tar.gz"

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
SwBQAAA=
--------------010403080006070704000108--
