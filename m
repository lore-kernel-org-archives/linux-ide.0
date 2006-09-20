From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: sil24 vs. noapic: what does this mean?
Date: Wed, 20 Sep 2006 22:48:11 +1000
Message-ID: <4511388B.2040504@eyal.emu.id.au>
References: <4D87F853B8020F4888896B1507DC0F09B19B3A@mail2.netezza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from customer-domains.icp-qv1-irony8.iinet.net.au ([203.59.1.133]:49758
	"EHLO customer-domains.icp-qv1-irony8.iinet.net.au")
	by vger.kernel.org with ESMTP id S1751217AbWITMtJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Sep 2006 08:49:09 -0400
Received: from [192.168.3.7] (e7.eyal.emu.id.au [192.168.3.7])
	by e4.eyal.emu.id.au (8.11.6/8.11.6) with ESMTP id k8KCmBP31390
	for <linux-ide@vger.kernel.org>; Wed, 20 Sep 2006 22:48:11 +1000
In-Reply-To: <4D87F853B8020F4888896B1507DC0F09B19B3A@mail2.netezza.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: list linux-ide <linux-ide@vger.kernel.org>

Mark Odell wrote:
>>-----Original Message-----
>>From: linux-ide-owner@vger.kernel.org 
>>[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Eyal Lebedinsky
>>Sent: Wednesday, September 20, 2006 5:31 AM
>>To: list linux-ide
>>Subject: sil24 vs. noapic: what does this mean?
>>
>>At the office we are testing a new mobo and initially used 
>>the onboard SATA controllers (an sata_nv and sil24).
>>
>>Disks are Seagate Barracuda ES 750GB on Asus P5N-SLI-SE-DELUXE mobo.
>>
>>We get regular failures on the sil24 attached disks. Changing 
>>power supply had no effect. We then booted with 'noapic' and 
>>not a single error today.
>>
>>The errors are of this type (sorry, no logs were kept)
>>	status=0x50 { DriveReady SeekComplete }
> 
> 
> Which of course is a "no error" status. The LSbit indicates an error
> which is not set here. Is it possible interrupts are not working
> correctly?

Of course. This is actually what I am asking here - is apic buggy
in Linux? On the mobo?

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
