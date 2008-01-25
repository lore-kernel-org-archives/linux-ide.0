From: Jay Estabrook <Jay.Estabrook@hp.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Fri, 25 Jan 2008 13:16:39 -0500
Message-ID: <479A2787.5000106@hp.com>
References: <4794459C.3090200@gmail.com> <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com>	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>	 <4797F8D0.6060302@gmail.com>	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>	 <47980B71.3000408@gmail.com>	 <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>	 <4798AA88.5080107@gmail.com> <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com> <4798C617.10601@gmail.com> <4798CA71.20707@gmail.com> <4798CC90.4040707@gmail.com> <4798CCDF.9070305@gmail.com> <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com> <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com> <479939E3.4020307@gmail.com> <47997BD3.2060100@gmail.com> <479A1C48.1
 070209@gmail.com> <479A2374.6080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:50739 "EHLO
	ccerelbas01.cce.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667AbYAYSfV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 13:35:21 -0500
In-Reply-To: <479A2374.6080100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Thomas Evans wrote:
> Saw something that caught my attention might be nothing ...
> 
> When initialized, the port address is a 64 bit address:
> sil24_init_one init_one: port:FFFFFD00:09AA0000
> sil24_init_one init_one: port:FFFFFD00:09AA2000
> sil24_init_one init_one: port:FFFFFD00:09AA4000
> sil24_init_one init_one: port:FFFFFD00:09AA6000

These are KSEG addresses used for getting at the memory/registers
on the card, and were created by doing ioremap(physaddr).

> When the description from ata_port_pbar_desc comes out, it shows:
> ata13: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
> ata14: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
> ata15: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
> ata16: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31

These are the physical addresses of the memory/registers of the card
on the PCI bus.

> I don't think the output is being truncated?

Nope, not truncated, just diff between physical and KSEG

> Is there some issue with the address?

Don't think so, at this time.

> ...tom
> 
> 
> Thomas Evans wrote:
>> added some more printk's based on what I saw -
>> maybe some issue with the dma port?
>>
>> ...tom
>>
> 

