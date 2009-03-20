From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Fri, 20 Mar 2009 13:38:42 +0000
Message-ID: <20090320133842.13c27906@lxorguk.ukuu.org.uk>
References: <49C1047D.4000008@rtr.ca>
	<49C11A0C.3070502@rtr.ca>
	<49C11ED4.2030307@rtr.ca>
	<49C19087.5000307@gmail.com>
	<49C190F1.7010202@kernel.org>
	<49C28133.8050401@rtr.ca>
	<49C281A5.5080404@rtr.ca>
	<49C2D642.90706@kernel.org>
	<49C39690.6090802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49374 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbZCTNiw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Mar 2009 09:38:52 -0400
In-Reply-To: <49C39690.6090802@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, 20 Mar 2009 09:13:52 -0400
Mark Lord <liml@rtr.ca> wrote:

> Tejun,
> 
> I need a way to limit the multi_count to a specific maximum
> value for sata_mv.  ISTR that some PATA chips may also have
> an upper hardware limit on multi_count.

Original ST412 depending on the amount of external SRAM, but not I think
anything much newer than that. Would be worth going over the old
drivers/ide code to double check though.
