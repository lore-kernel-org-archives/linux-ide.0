From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: maintenence sata_sis
Date: Tue, 23 Aug 2005 22:32:58 +0200
Message-ID: <m3fyt02y2t.fsf@anduin.mandrakesoft.com>
References: <m31x4pkhjb.fsf@anduin.mandrakesoft.com>
	<4309A268.8090203@gmx.net> <430AA69A.1030307@verizon.net>
	<430AD885.4080001@gmx.net> <430B63D1.6080108@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:7173 "EHLO
	anduin.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S932379AbVHWU3q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Aug 2005 16:29:46 -0400
In-Reply-To: <430B63D1.6080108@verizon.net> (Wes Newell's message of "Tue,
 23 Aug 2005 12:58:41 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wes Newell <w.newell@verizon.net>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>

Wes Newell <w.newell@verizon.net> writes:

> Uwe Koziolek wrote:
>
>>Wes Newell wrote:
>>
>>
>>
>>>I've got a Jetway S755MAX that also has a real SIS180 onboard and have
>>>been trying to get PATA support for it without any luck for several
>>>months now. The sata_sis driver from SIS just locks up the machine
>>>when I attach a pata drive. With the help of a few here, I patched the
>>>sis5513 driver, but it has lost interrupt problems. I basically gave
>>>up on this ever working a couple of months ago. Do you think there's
>>>any hope at all? I'm willing to try whatever some can point me
>>>towards, but I'm not a C programmer. I can compile kernels though and
>>>follow instructions.
>>>
>>>
>>>
>>The SiS180 has disabled the interrupts by default. You must enable the
>>interrupts in the PCI-config space.
>>You can find a function pci_enable_intx() in the sata_sis.c.
>>
>>regards
>>Uwe Koziolek
>>
>>
>>
> Well, now you've really lost me. I wasn't using sata_sis when I got
> the drive to work with lost interrupts. I was using a patched sis5513
> ide driver. So maybe I should just forget that and say that the

the sis5513 driver is the ide driver and sata_sis for sata/pata.

> machine locks up solid when I try and load sata_sis from
> sis18x_2.6.10_1.00.00. So I really don't understand what you are
> saying I need to do here. Remember, I'm not a C programmer  and only
> came here some months back to see if someone could fix this. I'm
> willing to help in any way I can testing, but if you want me to patch
> something or enable something, you're going to have to lead me by the

Even if it was not perfect as concern the pata support, you may also
test the patch I mailed. 

> hand and show me what code, and exactly where to put within the base
> code. I can find function pci_enable_intx in sata_sis.c, but I don't
> have a clue as to what to do with it and since I wasn't using
> sata_sis, but the sis5513 driver when i could finally see the drives,
> I'm totally lost.

(FYI pci_enable_intx function will disappear. It'll be replaced by pci_intx)

>
> -- 
> KT133 MB, CPU @2400MHz (24x100): SIS755 MB CPU @2330MHz (10x233)
> Need good help? Provide all system info with question.
> My server http://wesnewell.no-ip.com/cpu.php
> Verizon server http://mysite.verizon.net/res0exft/cpu.htm
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

