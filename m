From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Patch: slight shrink of vt6421_init_addrs()
Date: Fri, 23 Feb 2007 05:30:03 -0500
Message-ID: <45DEC22B.3010005@pobox.com>
References: <20070216194656.A4375@freya>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44873 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbXBWKab (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 05:30:31 -0500
In-Reply-To: <20070216194656.A4375@freya>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Adam J. Richter wrote:
> Hi Tejun and Jeff,
> 
> 	The discussion about the vt6421 problems caused me to glance
> at the code and try a very minor clean-up to vt6421_init_addrs().
> Please note that I don't have a vt6421, so this patch is UNTESTED.
> The patch does two things:
> 
> 	1. Elminate the bmdma_addr variable, which was only used once,
> 	   in an assignment to a field also named bmdma_addr.  So having
> 	   a separate variable served no documentary purpose.  This change
> 	   causes the value to be computed a little later, so please make
> 	   sure that that is OK.  The effect is just to make the source
> 	   code one line smaller.  The binary size is unchanged by this
> 	   modification, at least on my x86 configuration, which has
> 	   SMP and lots of debugging options activated.
> 
> 	2. Add a variable ata_ports, to replace the six times the
> 	   same value appeared to be computed.  I assume the compiler
> 	   was smart enough to avoid most of the recomputation, but
> 	   this change shrinks the .text by 7 bytes in my configuration,
> 	   makes the routine more readable and reduces opportunities for
> 	   typos.
> 
> 	If it looks OK to everyone, please forward it upstream as
> appropriate.
> 
> Adam Richter

Patch seems OK in theory, except for two procedural stumbling blocks:

1) always always always include a signed-off-by line in your kernel 
patches.  see http://linux.yyz.us/patch-format.html or 
Documentation/SubmittingPatches in the kernel tree.

2) this was stirred a bit more by recent changes, so a rediff + resend 
would be appreciated


