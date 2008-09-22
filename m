From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
Date: Mon, 22 Sep 2008 19:01:57 +0400
Message-ID: <48D7B365.6070305@ru.mvista.com>
References: <20080918.001358.08318211.anemo@mba.ocn.ne.jp>	<48D51B48.2090400@ru.mvista.com> <20080922.235608.106262139.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:12877 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752687AbYIVPBA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 11:01:00 -0400
In-Reply-To: <20080922.235608.106262139.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

>>>Add a helper routine to register tx4939ide driver and use it on
>>>RBTX4939 board.

>>  BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?

> Yes, next plan.  It should be much simpler than the tx4939ide driver.

    I suspect {ide|pata}_platform could be able to cover it... though I got 
muddled in the timing diagrams for the TX4938 external bus...

> ---
> Atsushi Nemoto

WBR, Sergei
