From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: 07 Mar 2008 12:47:27 +0100
Message-ID: <878x0ug3hs.fsf@basil.nowhere.org>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com>
	<47D02642.8040907@rtr.ca> <47D029BF.8040000@pobox.com>
	<47D02BB2.9000609@rtr.ca> <47D03080.8070405@pobox.com>
	<47D035D6.1060604@rtr.ca> <47D036DF.1050200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out03.alice-dsl.net ([88.44.63.5]:18067 "EHLO
	smtp-out03.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYCGMEX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 07:04:23 -0500
In-Reply-To: <47D036DF.1050200@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik <jgarzik@pobox.com> writes:

> Mark Lord wrote:
> > The big difference here, is that a single SATA controller in a system
> > can have up to eight quasi-independent ports.  So when we lock, we block
> > activity on all 8 interfaces, rather than just the one we care about.
> 
>   ...hence the mention of multi-port NICs.

Multi port nics typically have one spinlock per port though, don't they?

-Andi
