From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Tue, 26 Jun 2007 17:57:56 +0400
Message-ID: <46811B64.4080406@ru.mvista.com>
References: <200706212154.47398.sshtylyov@ru.mvista.com> <20070622151359.GD8840@austin.ibm.com> <467BEB9C.1070407@ru.mvista.com> <20070622163646.GG8840@austin.ibm.com> <467D621A.80406@ru.mvista.com> <20070625214434.GA4482@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:38763 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754352AbXFZN4M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 09:56:12 -0400
In-Reply-To: <20070625214434.GA4482@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-ide@vger.kernel.org

Hello.

Linas Vepstas wrote:

>>   Now I'm confused too -- did you get any DMA timeouts this time?

> No. And yes, this is confusing, as the initial hang that I was seeing 
> was preceeded by DMA timeout messages on the screen (as posted in the
> initial email). Now, with the patched kernel, I'm not seeing any
> DMA timeouts; and, instead, I'm seeing lots of hdc: task_out_intr:
> status=0x50 { DriveReady SeekComplete } I don't know why.

    Looks like the state machine reset didn't do it much good... but wait -- 
you're saing that it didn't even occur. :-)

> However, I have now learned how to make all of my problems go
> away: lower the UDMA level.  So its seems that this has been
> a humbling experience in (re-)learning about bus glitches.

    Also, this is not just glitches... normally, UDMA errors introduced by 
cabling should manifest themselves as CRC errors.

> I'm currently doing an /sbin/hdparm -X 67 /dev/hdc to drop
> the udma mode to mode3 == 44 MHz (-X udma_mode + 64) from
> the default of mode4 for this controller (the hard drive itself is
> supposedly udma100 capable, according to the box).  This has cured 
> all of the ide driver problems.

> The disk that caused all the problems was: 
> Device Model:     MAXTOR STM3320620A

    Good, time to prepare a patch then...

> A quick look through ide-dma.c shows that there is no way to
> blacklist a drive to the "highest suported" level; the blacklist
> is UDMA on or UDMA off.

    Actually, there are DMA white/black lists to force all DMA on/off.
    But hpt366.c has its own UltraDMA specific blacklists. :-)

> ===============
> I have not yet tried playing any udma mode games with libata yet,
> to see if I could get that working.
> ===============

> I'd like to propose that, for a system is seeing a fair number of 
> drive errors, that, perhaps it should automatically lower the mode, 
> in the hope of clearing up the problem. 

    It already does so for UDMA CRC errors. Maybe it's worth considering to do 
this for DMA timeouts as well...

> --linas

MBR, Sergei
