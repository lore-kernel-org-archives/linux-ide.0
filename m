From: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: PMP and SEMB messages to SEP
Date: Fri, 14 Jan 2011 17:59:57 +0100
Message-ID: <20110114165957.GH16039@MAIL.13thfloor.at>
References: <20110113192558.GE16039@MAIL.13thfloor.at> <20110114142018.GA978@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:46747 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757177Ab1ANQ76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2011 11:59:58 -0500
Content-Disposition: inline
In-Reply-To: <20110114142018.GA978@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Fri, Jan 14, 2011 at 03:20:18PM +0100, Tejun Heo wrote:
> Hello,

> On Thu, Jan 13, 2011 at 08:25:58PM +0100, Herbert Poetzl wrote:
> > I had a quick read on the (S)ATA specification regarding
> > PMP and sending/retrieving messages from the SEMB, but at
> > the moment, I have no clue how to 'map' that to existing? 
> > code in the Linux kernel or how that should/could be exposed 
> > to userspace ...

> > Any hints/pointers/information would be greatly appreciated.

> Unfortunately, it hasn't been implemented yet.  

Okay, so any ideas/suggestions how to implement it?

> I didn't have access to any SEMB aware device and no one 
> else worked on it, so...

No problem there, AFAIK, any SiI3726 based PMP should have
everything required for a SEMB, but most PMP products do not
add the required header to actually connect it to a SEP
(at lest the SiI3726 specification says so :)

I have no problem digging into it and doing the testing, but
of course, all input on how to address this is quite welcome

Thanks in advance,
Herbert

> -- 
> tejun
