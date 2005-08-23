From: Wes Newell <w.newell@verizon.net>
Subject: Re: maintenence sata_sis
Date: Tue, 23 Aug 2005 16:14:41 -0500
Message-ID: <430B91C1.6040407@verizon.net>
References: <m31x4pkhjb.fsf@anduin.mandrakesoft.com>	<4309A268.8090203@gmx.net>
 <430AA69A.1030307@verizon.net>	<430AD885.4080001@gmx.net>
 <430B63D1.6080108@verizon.net> <m3fyt02y2t.fsf@anduin.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:3062 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932122AbVHWVNE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Aug 2005 17:13:04 -0400
Received: from [192.168.0.2] ([71.244.20.31])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0ILP003LV1LR5EW1@vms044.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Tue, 23 Aug 2005 16:13:04 -0500 (CDT)
In-reply-to: <m3fyt02y2t.fsf@anduin.mandrakesoft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>

Arnaud Patard wrote:

>Wes Newell <w.newell@verizon.net> writes:
>
>  
>
>>Uwe Koziolek wrote:
>>
>>    
>>
>>>Wes Newell wrote:
>>>
>>>      
>>>
>>>>I've got a Jetway S755MAX that also has a real SIS180 onboard and have
>>>>been trying to get PATA support for it without any luck for several
>>>>months now. The sata_sis driver from SIS just locks up the machine
>>>>when I attach a pata drive. With the help of a few here, I patched the
>>>>sis5513 driver, but it has lost interrupt problems. I basically gave
>>>>up on this ever working a couple of months ago. Do you think there's
>>>>any hope at all? I'm willing to try whatever some can point me
>>>>towards, but I'm not a C programmer. I can compile kernels though and
>>>>follow instructions.
>>>>
>>>>        
>>>>
>>>The SiS180 has disabled the interrupts by default. You must enable the
>>>interrupts in the PCI-config space.
>>>You can find a function pci_enable_intx() in the sata_sis.c.
>>>
>>>regards
>>>Uwe Koziolek
>>>
>>>      
>>>
>>Well, now you've really lost me. I wasn't using sata_sis when I got
>>the drive to work with lost interrupts. I was using a patched sis5513
>>ide driver. So maybe I should just forget that and say that the
>>    
>>
>
>the sis5513 driver is the ide driver and sata_sis for sata/pata.
>
>  
>
This much I know, but since the original sata_sis with 2.6.11 didn't see 
the drives at all and the SIS sata_sis locked up the machine with a pata 
drive atached, and I don't have any sata drives, I just tried patching 
it, and it at least saw the drives and I could read and write to them, 
but because of the lost interrrupts, it was realllll slow. I would much 
prefer to get both sata and pata portion of it working with sata_sis if 
possible.

>>machine locks up solid when I try and load sata_sis from
>>sis18x_2.6.10_1.00.00. So I really don't understand what you are
>>saying I need to do here. Remember, I'm not a C programmer  and only
>>came here some months back to see if someone could fix this. I'm
>>willing to help in any way I can testing, but if you want me to patch
>>something or enable something, you're going to have to lead me by the
>>    
>>
>
>Even if it was not perfect as concern the pata support, you may also
>test the patch I mailed. 
>
>  
>
What patch was this and for which sata_sis was it for and where do i get it.

