From: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: AHCI problem with hotplug
Date: Tue, 20 Jan 2009 17:56:27 -0500
Message-ID: <4976569B.9040206@cybernetics.com>
References: <494178E3.6030305@cybernetics.com> <49588784.4020808@kernel.org> <4958E3DC.7080009@cybernetics.com> <49591710.7040102@shaw.ca> <49596D9E.3040904@kernel.org> <495D8606.5070807@kernel.org> <4964CCBF.5030408@cybernetics.com> <49655FBA.3060005@kernel.org> <49660B9F.4010408@cybernetics.com> <496696B2.7010006@shaw.ca> <49677B8D.7060807@cybernetics.com> <496D8735.4030005@kernel.org> <496E5B6C.2020602@cybernetics.com> <496E91E9.4050403@kernel.org> <496EBE98.4040103@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host64.cybernetics.com ([98.174.209.230]:2422 "EHLO
	mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbZATW43 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jan 2009 17:56:29 -0500
In-Reply-To: <496EBE98.4040103@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> Tejun Heo wrote:
>   
>> Hello,
>>
>> Tony Battersby wrote:
>>     
>>> No luck.  After "setpci -s 1f.2 92.b=7f" with the disk unplugged, lspci
>>> shows register 0x92 = 0x0f.  After plugging in the disk, this changes to
>>> 0x92 = 0x1f, but still no interrupt, and still no hotplug event.
>>>       
>> Aieee... I've run out of ideas then.  :-(
>>
>>     
>
> Tried reloading the ahci module after making that change? Maybe it needs 
> an AHCI reset before it takes effect or something..
>
>   
Still no luck.

boot with no drive attached
plug in drive
modprobe ahci
setpci
modprobe -r ahci
modprobe ahci

I get the following messages:

ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ahci 0000:00:1f.2: setting latency timer to 64
scsi12 : ahci
scsi13 : ahci
scsi14 : ahci
scsi15 : ahci
ata13: SATA max UDMA/133 abar m1024@0xea000400 port 0xea000500 irq 506
ata14: SATA max UDMA/133 abar m1024@0xea000400 port 0xea000580 irq 506
ata15: SATA max UDMA/133 abar m1024@0xea000400 port 0xea000600 irq 506
ata16: SATA max UDMA/133 abar m1024@0xea000400 port 0xea000680 irq 506
ata13: SATA link down (SStatus 0 SControl 0)
ata14: SATA link down (SStatus 0 SControl 0)
ata15: SATA link down (SStatus 0 SControl 0)
ata16: SATA link down (SStatus 0 SControl 0)

Tony


