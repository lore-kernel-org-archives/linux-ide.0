From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Fri, 23 Oct 2009 10:50:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0910231031200.324@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
 <200910212139.24675.bzolnier@gmail.com> <20091021.174155.44894825.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbZJWOuJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Oct 2009 10:50:09 -0400
In-Reply-To: <20091021.174155.44894825.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, elendil@planet.nl

> Right, and see also:
> 
> commit 6b5cde3629701258004b94cde75dd1089b556b02
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Mon Dec 29 20:27:32 2008 +0100
> 
>     cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
> 
> Which is how we got there.
> 
> The most conservative thing to do is to set the flag as
> is done by mpatocka's patch but I'd like Frans to regression
> test that on his ultra5.
> 
> Frans can you do that?
> 
> Thanks.

I read the thread about wild interrupts that Frans was observing and that 
led to disabling the serialization.

The thing is tricky --- if we read status register on interrupt, we break 
the serialization principle and introduce potential data corruption.

If we don't read the status register, the wild interrupt kills the whole 
interrupt line.

I think the interrupt handler should read the BM-status register on both 
channels (it reflects the interrupt state even in PIO mode) to test if 
there is an unexpected interrupt on the inactive channel --- this should 
be much more safe than reading the status register. If there is an 
interrupt, then
--- read the status of the inactive channel? (potential data corruption, 
but it is reported to happen only on boot).
--- Or can the interrupt be acknowledged only in BM-status without 
touching the device? I believe yes, it shoud shut the PCI interrupt but it 
would leave the IDE interrupt line on (should be cleared on next command).

Mikulas
