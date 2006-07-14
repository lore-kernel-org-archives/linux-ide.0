From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Follow up? LibPATA code issues / 2.6.15.4 (found the opcode=0x35)!
Date: Fri, 14 Jul 2006 14:17:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607141417370.4210@p34.internal.lan>
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
 <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan> <44B7D0F7.6000302@rtr.ca>
 <Pine.LNX.4.64.0607141317300.1687@p34.internal.lan> <44B7D66E.3070804@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([66.45.37.187]:59319 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1422653AbWGNSRy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jul 2006 14:17:54 -0400
In-Reply-To: <44B7D66E.3070804@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>



On Fri, 14 Jul 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>> 
>> 
>> On Fri, 14 Jul 2006, Mark Lord wrote:
>> 
>>> So, the drive is rejecting an LBA48 WRITE operation, which should happen
>>> only if the drive does not have LBA48 support.  Now, I know you posted all
>>> of this nice info months ago, but let's see it again now, for the exact
>>> drive that is generating that specific message.  We need to see the output
>>> from "hdparm --Istdout /dev/sdX" for that drive.
>>> 
>>> Thanks
>>> 
>> 
>> Here it is:
>> 
>> They are identical disks (the WD 400KD), both show up as 373GB (formatted):
>
>
> Which *exact* unit generated the WRITE errors you posted about?
>

Both have generated the errors, they are identical drives and firmware.

