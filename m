From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: give another shot at clearing all
 bits in irq_stat
Date: Sun, 06 Jul 2008 09:45:56 -0400
Message-ID: <4870CC94.8090504@garzik.org>
References: <20080704131005.GA30768@havoc.gtf.org> <alpine.LFD.1.10.0807040955100.2815@woody.linux-foundation.org> <486EE6CA.2040908@kernel.org> <486EE804.6020202@kernel.org> <486EF44A.20400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36289 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865AbYGFNqe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Jul 2008 09:46:34 -0400
In-Reply-To: <486EF44A.20400@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> Commit ea0c62f7cf70f13a67830471b613337bd0c9a62e tried to clear all
> bits in irq_stat but it didn't actually achieve that as irq_stat was
> anded with port_map right after read.  This patch makes ahci driver
> always use the unmasked value to clear irq_status.
> 
> While at it, add explanation on the peculiarities of ahci IRQ
> clearing.
> 
> This was spotted by Linus Torvalds.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> The original report requires further investigation regarding why the
> bogus change fixed the problem but this change is the correct thing to
> do regardless.
> 
> Thanks.

Belated post-holiday ACK (since it's already in).

Thanks for taking care of this, and good catch too.

