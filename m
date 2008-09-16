From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Wed, 17 Sep 2008 01:15:55 +0400
Message-ID: <48D0220B.4090601@ru.mvista.com>
References: <48CA8BEE.1090305@ru.mvista.com>	<20080913.005904.07457691.anemo@mba.ocn.ne.jp>	<48CAA498.9090804@ru.mvista.com> <20080913.213226.106262199.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25637 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751417AbYIPVQC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Sep 2008 17:16:02 -0400
In-Reply-To: <20080913.213226.106262199.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

>>> Well, let me explain a bit.  The datasheed say I should wait _both_
>>> XFERINT and HOST interrupt.  So, if only one of them was asserted, =
I
>>> mask it and wait another one.  But on the error case, only HOST was
>>> asserted and XFERINT was never asserted.  Then I could not exit fro=
m
>>> "waiting another one" state, until timeout.
>>>      =20
>>     Hmm, I got it: you decide whether it's worth waiting more for XF=
EREND=20
>> interrupt based on whether ERR is set or not. I suppose IDE_INT does=
n't get=20
>> set in case the command gets endede with ERR set?
>>    =20
>
> IIRC, yes.  And anyway, the interrupt signal from this controller to
>  =20

Thats wrong -- According t the spec. the bit should be set following an=
y=20
assertion of INTRQ on IDE bus (possibly not at once though -- after=20
flushing FIFO). Well, no wonder with such description of the bits as:


INT_IDE (RWC) [Interrupt]
Is =931=94 when data transfer completes. This bit is cleared by writing=
 =931=94=20
to it.
When this bit is set to =911=92, the following bits of the ATA Interrup=
t=20
Controller Register will be
reset: bits [15:8] (Mask Address Error INT, Mask Reach Multiple INT,=20
Mask DEV
Timing Error, Mask Ultra DMA DEV Terminate, Mask Timer INT, Mask Bus=20
Error, Mask
Data Transfer End, Mask Host INT), and bits [1:0] (Data Transfer End,=20
Host INT).

> CPU is not asserted because HOSTINT was masked by int_ctl register to
> wait for XFERINT interrupt.
>
> So, regardless of IDE_INT was set or not, no more interrupt raised to
> CPU.
>  =20

Ah, it gets purposedly masked out...

> Many of strangeness of interrupt handling in this driver is based on
> the fact that the IDE_INT bit in DMA status register does not refrect
> the controllers interrupt status directly.

It also seems to reflect the wrong status, i.e. that of the XFEREND=20
interrupt...

> And the implementation of
> the IDE_INT bit is actually broken.  Claring the IDE_INT bit also
> clears all mask bits in int_ctl registers.  Usually this sort of
> behaviour is called "bug". ;)
>  =20

Hm, I thought that was done on purpose to "accelerate" interrupt=20
handling or something... it can help indeed if you're not masking those=
=20
interrupts.

> ---
> Atsushi Nemoto
>  =20

MBR, Sergei


