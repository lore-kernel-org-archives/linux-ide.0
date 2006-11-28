From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 13:12:33 -0700
Message-ID: <311601c90611281212o28ca3c1u417c366e4a2d0d0e@mail.gmail.com>
References: <20061114150454.GA11900@havoc.gtf.org>
	 <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>
	 <456C73D8.3050803@rtr.ca> <456C77F8.5020608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:11905 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S936088AbWK1UMg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 15:12:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1583631uga
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 12:12:34 -0800 (PST)
In-Reply-To: <456C77F8.5020608@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On 11/28/06, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Mark Lord wrote:
>
> > Bit #4, when actually implemented, is a rotational seek indicator,
> > which can be used for timing purposes.
>
>     Hm, I thought it was DSC (drive seek complete) set by the SEEK command
> completion, and it's always implemented. Didn't you mean IDX (bit 1, IIRC)?

0x50 is the standard, non queueing "device is ready" status.  It used
to have those special meanings, but they're pretty obsolete today as I
understand it.

0x40 is used for queueing, because bit 4 was the service bit for PATA TCQ.

> > But when BUSY (bit #7) is set, the rest are generally nonsense.
>
>     Indeed...
>
> WBR, Sergei

Typically, 0x80 as the busy state indicates the device is in POR
reset.  Once the firmware is up and running in the device, it often
switches from 0x80 to 0xD0 during POR.

0xD0 is the busy state you'd get to if you were 0x50 and received a
command, so this is reported typically after the device is up and
running.

0x7F usually is hardware indicating nothing is attached to the port,
and isn't supposed to infer a non-busy state.

You're right, while not meaningful according to spec, you can derive
some information from the reported status even when you're only
supposed to look at one bit.
