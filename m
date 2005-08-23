From: Wes Newell <w.newell@verizon.net>
Subject: Re: maintenence sata_sis
Date: Mon, 22 Aug 2005 23:31:22 -0500
Message-ID: <430AA69A.1030307@verizon.net>
References: <m31x4pkhjb.fsf@anduin.mandrakesoft.com> <4309A268.8090203@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:31958 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932069AbVHWE35 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Aug 2005 00:29:57 -0400
Received: from [192.168.0.2] ([71.244.20.31])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0ILN003AUR5WNPH2@vms042.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 22 Aug 2005 23:29:56 -0500 (CDT)
In-reply-to: <4309A268.8090203@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>

Uwe Koziolek wrote:

>Hello Jeff,
>
>currently it exists 3 variants to support the SiS182 Chipset
>- use SiS182 with the code from SiS180, only add the PCI-ID to the driver
>- the source code from OSDL
>- the source code from www.sis.com
>Actually i have no SiS board available. So i have no chance to maintain
>the driver.
>
>regards
>Uwe Koziolek
>
>
>
>Arnaud Patard wrote:
>
>  
>
>>Hi,
>>
>>
>>I got recently a motherboard shipped with the SATA SIS 182 chipset. This
>>chipset is not supported by the kernel. I tried to just add the PCI IDS
>>in the supported chipset list as suggested on some mails in this
>>list but it didn't work for the hard drive connected on the second sata port.
>>
>>I found that this has been reported on
>>http://bugme.osdl.org/show_bug.cgi?id=4192. Unfortunately the patch
>>didn't apply to the recents kernel. So, I've written a new minimal patch that
>>add support for this chipset. 
>>
>>It works well on the machine I have with a 2.6.12.5 kernel but I was not
>>able to test it on SIS 180/181 chipset (I don't have the hardware). 
>>
>>imho having support for this chipset in the kernel could be usefull, so
>>any feedback/comments are welcome. 
>>
>>Regards,
>>Arnaud Patard
>>
>>    
>>
I've got a Jetway S755MAX that also has a real SIS180 onboard and have 
been trying to get PATA support for it without any luck for several 
months now. The sata_sis driver from SIS just locks up the machine when 
I attach a pata drive. With the help of a few here, I patched the 
sis5513 driver, but it has lost interrupt problems. I basically gave up 
on this ever working a couple of months ago. Do you think there's any 
hope at all? I'm willing to try whatever some can point me towards, but 
I'm not a C programmer. I can compile kernels though and follow 
instructions.
