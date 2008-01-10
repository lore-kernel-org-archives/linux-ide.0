From: Tejun Heo <htejun@gmail.com>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Thu, 10 Jan 2008 11:14:37 +0900
Message-ID: <47857F8D.9040209@gmail.com>
References: <4784FBC1.7070804@gmail.com> <478503FE.7040501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:10704 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816AbYAJCOo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 21:14:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so768924wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 18:14:44 -0800 (PST)
In-Reply-To: <478503FE.7040501@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello, Sergei.

Sergei Shtylyov wrote:
>    Heh, it works by accident: PIO4 timings correspond to MWDMA ones. The
> driver does *not* support MWDMA modes -- there's FIXME in
> ali_set_dma_mode().

Yeap, I saw that and lifted MWDMA programming from pata_ali.  That's how
I got the identical PCI configuration area but still no go.

>> with the IDE alim15x3 driver while any DMA data transfer on pata_ali
>> times out.
> 
>> At first I thought this was simple timing programming error, but no.
>> pata_ali's mode programming wasn't wrong although it was different in
>> how it programs empty slots.  Even after making pata_ali to program the
>> controller exactly the same as alim15x3 (identical lspci -xxx results),
>> MWDMA didn't work. (attached)
> 
>    I don't quite understand -- MWDMA mode programming is simply not
> there in the alim15x3 driver...

And PIO4 timing seems to be doing just fine for IDE.  Unfortunately, it
doesn't work for libata.

>>     Subsystem: Hewlett-Packard Company Pavilion ze4400 builtin IDE
>> [103c:0024]
>>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>     Latency: 32 (500ns min, 1000ns max)
>>     Interrupt: pin A routed to IRQ 0
> 
>    Interrupt not routed... well, we're in legacy mode anyway with native
> mode not supported, so why the device is requesting interrupt at all is
> not clear.

And it's the same story for IDE and libata.  Also, the UDMA hard drive
connected to the primary channel works just fine.  I watched how BMDMA
status and TF status changes after ATAPI DMA is initiated and it's not
IRQ problem.  DMA engine just doesn't sits there doing nothing even
after the device indicates DRQ!

>>     Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable)
>> [disabled] [size=8]
>>     Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)
>> [disabled] [size=1]
>>     Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable)
>> [disabled] [size=8]
>>     Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)
>> [disabled] [size=1]
> 
>    What?! The minimum PCI resource size is 4 bytes, not 1. And why those
> are seen as memory resources?

Those are from Alan's PCI resource fix up so that legacy and native
modes look alike.  It's weird that they show up as memory tho.  Okay,
that looks like a bug in lspci.  Here's dump of sysfs resource file.

ali:/sys/bus/pci/devices/0000:00:10.0 # cat resource
0x00000000000001f0 0x00000000000001f7 0x0000000000000110
0x00000000000003f6 0x00000000000003f6 0x0000000000000110
0x0000000000000170 0x0000000000000177 0x0000000000000110
0x0000000000000376 0x0000000000000376 0x0000000000000110
0x0000000000008080 0x000000000000808f 0x0000000000000101
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000

The last field is flags and 0x100 is IO alright.

-- 
tejun
