From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata updates for 2.6.37
Date: Wed, 01 Dec 2010 12:17:52 +0100
Message-ID: <4CF62EE0.7040607@kernel.org>
References: <20101022012302.GA7487@havoc.gtf.org> <20101129180755.GK15818@bombadil.infradead.org> <4CF506A6.4020200@kernel.org> <20101130153839.GM15818@bombadil.infradead.org> <4CF52652.4030802@kernel.org> <20101130163150.GA25668@bombadil.infradead.org> <20101130175317.GB25668@bombadil.infradead.org> <20101130210938.GF25668@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45967 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab0LALRq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Dec 2010 06:17:46 -0500
In-Reply-To: <20101130210938.GF25668@bombadil.infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hello,

On 11/30/2010 10:09 PM, Kyle McMartin wrote:
>> Ok, running it, I haven't seen the issue across three suspends... Will
>> update when it inevitably happens.
> 
> [10273.011241] ata1.00: internal command failure: stat=0xef
> ehi_desc="irq_stat 0x00400001, PHY RDY changed"

Hmmm, so it's a timing problem.  For some reason, a PHY event is being
reported after reset is complete which unfortunately gets reported
while DIPM command is in progress.  Hmmm... what's broken is that the
PHY event happens after reset is complete.  Can you please attach the
output of "lspci -nn" and "hdparm -I /dev/sda"?  Looks a lot like a
timing issue.  Maybe we'll have to add a delay somewhere.  :-(

-- 
tejun
