From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: sata_nv + ADMA + Samsung disk problem
Date: Wed, 02 Jan 2008 18:21:45 -0600
Message-ID: <477C2A99.9010208@shaw.ca>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu>
 <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com>
 <477B0CFD.1030603@shaw.ca>
 <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com>
 <477BDEA5.8040701@garzik.org>
 <F72FA20C31DD4F4C997B91C5B3690A0950557D@hqemmail07.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:62359 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbYACAWb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 19:22:31 -0500
In-reply-to: <F72FA20C31DD4F4C997B91C5B3690A0950557D@hqemmail07.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Allen Martin <AMartin@nvidia.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

Allen Martin wrote:
>> The software definitely provides that guarantee for all NCQ-capable 
>> controllers.
>>
> 
> Well if that's not it, it must be some problem entering ADMA legacy
> mode.  Here's what the Windows driver does:
> 
> 
> ADMACtrl.aGO = 0
> ADMACtrl.aEIEN = 0
> poll {
>   until ADMAStatus.aLGCY = 1 || timeout
> }

What we're doing to enter legacy mode is essentially:

-wait until ADMA status indicates IDLE bit set (max wait of 1 microsecond)
-clear GO bit in control register
-wait until status indicates LEGACY bit set (max wait of 1 microsecond)

and to enter ADMA mode:

-set GO bit in control register
-wait until status indicates LEGACY bit cleared and IDLE bit set (max 
wait of 1 microsecond)

The 1 microsecond timeout is pretty aggressive admittedly, but it 
apparently isn't being broken (the only timeouts when switching modes 
I've seen are during error handling after a command timeout has already 
occurred). What timeout value is the Windows driver using?

Also, I see you are clearing the AEIN bit when in register mode, while 
we're not. Is that important/necessary?

Aside from all this though, in the case of NCQ writes followed by a 
cache flush, that sequence of commands won't put us into legacy mode at 
all since the cache flush is a no-data command which we should be able 
to handle in ADMA mode, from my understanding (correct me if I'm wrong). 
So I don't imagine legacy/ADMA mode switch could be the cause of this 
problem.

I also saw in my previous investigation that a flush immediately 
followed by a write could cause the write to time out as well.

 From some of the traces I took previously (posted on LKML as "sata_nv 
ADMA controller lockup investigation" way back in Feb 07), what seems to 
occur is that when the second command is issued very rapidly (within 
less than 20 microseconds, or potentially longer) after the previous 
command's completion, the ADMA status changes from 0x500 (STOPPED and 
IDLE) to 0x400 (just IDLE) as it typically does, but then it sticks 
there, no interrupt is ever raised, and CPB response flags remain at 0.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


