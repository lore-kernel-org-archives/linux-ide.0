From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
Date: Mon, 22 Sep 2008 19:27:10 +0400
Message-ID: <48D7B94E.2050007@ru.mvista.com>
References: <48D51B48.2090400@ru.mvista.com>	<20080922.235608.106262139.anemo@mba.ocn.ne.jp>	<48D7B365.6070305@ru.mvista.com> <20080923.001602.51867636.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13482 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753567AbYIVP0M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 11:26:12 -0400
In-Reply-To: <20080923.001602.51867636.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Atsushi Nemoto wrote:

>>>> BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?

>>>Yes, next plan.  It should be much simpler than the tx4939ide driver.

>>    I suspect {ide|pata}_platform could be able to cover it... though I got 
>>muddled in the timing diagrams for the TX4938 external bus...

> We need .set_pio_mode routine to get best PIO speed, but current

    Hm, didn't realize this is porogrammable on TX4938... 2.6.10 driver we 
have doesn't have tuneproc() method too.

WBR, Sergei
