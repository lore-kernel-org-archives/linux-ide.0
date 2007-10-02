From: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [PATCH] blacklist NCQ on Seagate Barracuda ST380817AS
Date: Tue, 2 Oct 2007 17:40:23 +0200
Message-ID: <20071002174023.0a70a93e@localhost>
References: <20070930160548.235be972@localhost>
	<20070930152908.1f58d39d@the-village.bc.nu>
	<20070930164610.20818867@localhost>
	<46FFBB2D.6060004@garzik.org>
	<46FFDC5A.7070509@rtr.ca>
	<46FFDCE5.4060900@gmail.com>
	<46FFE047.7030102@rtr.ca>
	<46FFE218.5000607@gmail.com>
	<46FFF0F4.7040809@rtr.ca>
	<46FFF290.2090005@rtr.ca>
	<47020D12.5090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:36581 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbXJBNoh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 09:44:37 -0400
In-Reply-To: <47020D12.5090402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tue, 02 Oct 2007 18:19:14 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Yeah, "World's first" is a pretty good clue indicating "broken".
> Blacklisting it seems like a good idea after all.

OT: I cannot test anything NCQ related for a while because the Intel
Mobo departed yesterday, so I'm on a different board without NCQ
support  ;)

-- 
	Paolo Ornati
	Linux 2.6.23-rc8generic-ga64314e6 on x86_64
