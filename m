From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 23:36:51 +0300
Message-ID: <456C9DE3.6060800@ru.mvista.com>
References: <20061114150454.GA11900@havoc.gtf.org>	 <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>	 <456C73D8.3050803@rtr.ca> <456C77F8.5020608@ru.mvista.com> <311601c90611281212o28ca3c1u417c366e4a2d0d0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:36998 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1752629AbWK1Uf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 15:35:26 -0500
In-Reply-To: <311601c90611281212o28ca3c1u417c366e4a2d0d0e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hello.

Eric D. Mudama wrote:
>> > Bit #4, when actually implemented, is a rotational seek indicator,
>> > which can be used for timing purposes.

>>     Hm, I thought it was DSC (drive seek complete) set by the SEEK 
>> command
>> completion, and it's always implemented. Didn't you mean IDX (bit 1, 
>> IIRC)?

> 0x50 is the standard, non queueing "device is ready" status.  It used
> to have those special meanings, but they're pretty obsolete today as I
> understand it.

    Erm, some status bits maybe obsolete but I've never heard that the status 
*values* were specified to mean anything special anywhere...

> 0x40 is used for queueing, because bit 4 was the service bit for PATA TCQ.

   I know. This meaning (SERVICE) actualy came from ATAPI

>> > But when BUSY (bit #7) is set, the rest are generally nonsense.

>>     Indeed...

>> WBR, Sergei

> Typically, 0x80 as the busy state indicates the device is in POR
> reset.  Once the firmware is up and running in the device, it often
> switches from 0x80 to 0xD0 during POR.

    Oh, I guess it's completely up to the disk makers what other status to 
show with BSY=1.

> 0xD0 is the busy state you'd get to if you were 0x50 and received a
> command, so this is reported typically after the device is up and
> running.

> 0x7F usually is hardware indicating nothing is attached to the port,
> and isn't supposed to infer a non-busy state.

    Ha, *never* seen that one. It's has always been 0xFF since PC people 
didn't ever bother themselves with silly pulldowns. :-)

> You're right, while not meaningful according to spec, you can derive
> some information from the reported status even when you're only
> supposed to look at one bit.

   Well, to some extent...

WBR, Sergei
