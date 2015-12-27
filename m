From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 0/3] IDE-ACPI: Fine-tuning for a function
Date: Sun, 27 Dec 2015 07:08:44 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1512270707320.2038@localhost6.localdomain6>
References: <566ABCD9.1060404@users.sourceforge.net>  <567E6799.5070802@users.sourceforge.net>  <20151226.131257.1589698540013987354.davem@davemloft.net> <1451173382.12498.10.camel@perches.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:23237 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750807AbbL0GIu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Dec 2015 01:08:50 -0500
In-Reply-To: <1451173382.12498.10.camel@perches.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: David Miller <davem@davemloft.net>, elfring@users.sourceforge.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org



On Sat, 26 Dec 2015, Joe Perches wrote:

> On Sat, 2015-12-26 at 13:12 -0500, David Miller wrote:
> > IDE is in deep freeze maintainence mode.
> > 
> > Therefore patches that perform simplications and cleanups will
> > not be accepted.
> 
> Maybe there should be something like a README
> in drivers/ide that says that.
> 
> Maybe the MAINTAINERS entry for "IDE SUBSYSTEM"
> should be something like:
> 
> S:	Frozen - critical fixes only

This could be a good idea.  Sometimes I hold off on sending patches for 
things becuse I have the impression that the subsystem doesn't want minor 
fixes, but I could be wrong, and if one could have a deterministic way to 
know, it could be better for everyone.

julia
