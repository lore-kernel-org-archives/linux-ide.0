From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Tue, 11 Nov 2008 20:20:37 -0500
Message-ID: <491A2F65.8030605@rtr.ca>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35435 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbYKLBTv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 20:19:51 -0500
In-Reply-To: <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guntsche Michael <mike@it-loops.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Guntsche Michael wrote:
> 
> On Nov 11, 2008, at 15:29, Mark Lord wrote:
>> .
>>
>> Yeah, that's the right one.  But if you are technically apt,
>> then perhaps you could try a brief experiment for us:
>>
>> Use drivers/ide instead, and see what it reports in the boot log.
>>
>> One simple way to do this, is to boot a Knoppix CD, say v5.01 or so
>> (but not the newest version, which probably uses libata instead).
>>
>> Then just grab the boot log with dmesg, and post it here.
> 
> Ok, recompiled the kernel with the old driver, here the relevant dmesg 
> output.
> 
> Uniform Multi-Platform E-IDE driver
> piix 0000:00:07.1: IDE controller (0x8086:0x7010 rev 0x00)
> piix 0000:00:07.1: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xe800-0xe807
>     ide1: BM-DMA at 0xe808-0xe80f
> Probing IDE interface ide0...
> hda: IC35L040AVER07-0, ATA DISK drive
> hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> hda: MWDMA2 mode selected
> Probing IDE interface ide1...
> hdc: SAMSUNG CD-R/RW SW-408B, ATAPI CD/DVD-ROM drive
> hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> hdc: MWDMA2 mode selected
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
..

Mmm.. no phantom device showing up there,
so I suppose what's left of my ancient device probing
is still mostly working (does any of it remain now?).

Tejun?
