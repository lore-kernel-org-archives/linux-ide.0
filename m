From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Fri, 12 Sep 2008 21:19:20 +0400
Message-ID: <48CAA498.9090804@ru.mvista.com>
References: <48C851ED.4090607@ru.mvista.com>	<20080912.005243.48535230.anemo@mba.ocn.ne.jp>	<48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4545 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751717AbYILRSl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2008 13:18:41 -0400
In-Reply-To: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Atsushi Nemoto wrote:

>>>>>+		/*
>>>>>+		 * If only one of XFERINT and HOST was asserted, mask
>>>>>+		 * this interrupt and wait for an another one.  Note

>>>>  This comment somewhat contradicts the code which returns 1 if only 
>>>>HOST interupt is asserted if ERR is set.

>>    Which is not its business to test. I think you should remove that above 
>>check -- if there's INTRQ asserted, then it's asserted. I wonder if BMIDE 
>>interrupt bit gets set in that case (suspecting it's not)...

> Well, let me explain a bit.  The datasheed say I should wait _both_
> XFERINT and HOST interrupt.  So, if only one of them was asserted, I
> mask it and wait another one.  But on the error case, only HOST was
> asserted and XFERINT was never asserted.  Then I could not exit from
> "waiting another one" state, until timeout.

    Hmm, I got it: you decide whether it's worth waiting more for XFEREND 
interrupt based on whether ERR is set or not. I suppose IDE_INT doesn't get 
set in case the command gets endede with ERR set?

MBR, Sergei
