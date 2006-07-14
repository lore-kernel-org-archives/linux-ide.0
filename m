From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA code issues / 2.6.17.3 (What is the next step?)
Date: Fri, 14 Jul 2006 14:18:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607141418240.4210@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <44AEB3CA.8080606@pobox.com>
  <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>  <200607091224.31451.liml@rtr.ca>
  <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>
 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>
 <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>
 <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>
 <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan>
 <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan>
 <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan>
 <1152545639.27368.137.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan>
 <Pine.LNX.4.64.0607110926150.858@p34.internal.lan> <44B7D168.2080304@rtr.ca>
 <Pine.LNX.4.64.0607141318040.1687@p34.internal.lan> <44B7D6CE.4030406@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([66.45.37.187]:26303 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1422671AbWGNSSe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jul 2006 14:18:34 -0400
In-Reply-To: <44B7D6CE.4030406@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>



On Fri, 14 Jul 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>> They are Western Digital 400* drives.
>> 
>> [4294678.049000]   Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
>> [4294678.050000]   Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
>> 
>> On a SiL controller, it also happens when they are on a promise controller 
>> too.
>> 
>> On Fri, 14 Jul 2006, Mark Lord wrote:
>> 
>>> Justin Piszcz wrote:
>>>> 
>>>> opcode=0x35 & opcode=0xca
>>> 
>>> Those are non-DMA WRITE opcodes.  Using PIO for I/O is pretty rare these 
>>> days,
>>> so I'm betting that this is not a hard disk device -- compactflash?
>
> Okay.  So why are we issuing PIO WRITE commands to drives that
> obviously should only be sent DMA commands by libata?
>
> Perhaps that's the bug.
>

Jeff/Alan -- ? Could this be it?
