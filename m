From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Fri, 12 Sep 2008 20:44:36 +0400
Message-ID: <48CA9C74.1080004@ru.mvista.com>
References: <48C851ED.4090607@ru.mvista.com>	<20080912.005243.48535230.anemo@mba.ocn.ne.jp>	<48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3937 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751241AbYILQnz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2008 12:43:55 -0400
In-Reply-To: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Hello.

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

    Since this is SFF-8038i compatible, you should first check if the spec'ed
interrupt status bit (called IDE_INT here) is set. If it isn't [always] get
set when it should, you may check for other interrupt bits (XFEREND/HOST/etc.)
and take the necessary measures if you detect interrupt on them.

> mask it and wait another one.  But on the error case, only HOST was
> asserted and XFERINT was never asserted.

    And I suspect that IDE_INT also doesn't get set, right? The check for 
ERR=1 however is not needed. If the drive does assert its interrupt signal 
(INTRQ), it knows better why.

> Then I could not exit from "waiting another one" state, until timeout.

    Well, at least most of the other [PCI] drivers will wait for timeout in 
the case of the DMA status register bit 2 (IDE_INT here) not set -- despite 
some IDE chips do have bits indicating the INTRQ status from IDE bus. But 
usually, INTRQ still comes thru to this bit even if a command ends in error... 
This isn't the case here?

MBR, Sergei
