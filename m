From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH libata: add SSD detection hueristic; move SSD setup to
 ata_dev_configure (was Re: [GIT PULL] Ext3 latency fixes)
Date: Thu, 09 Apr 2009 11:21:50 -0700
Message-ID: <49DE3CBE.8030607@kernel.org>
References: <alpine.LFD.2.00.0904031150190.4015@localhost.localdomain> <alpine.LFD.2.00.0904031329410.7007@localhost.localdomain> <20090404135719.GA9812@mit.edu> <20090404151649.GE5178@kernel.dk> <alpine.LFD.2.00.0904040854470.3915@localhost.localdomain> <20090404173412.GF5178@kernel.dk> <alpine.LFD.2.00.0904041039230.3915@localhost.localdomain> <20090404180108.GH5178@kernel.dk> <20090404232222.GA7480@mit.edu> <20090404163349.20df1208@infradead.org> <20090405001005.GA7553@mit.edu> <alpine.LFD.2.00.0904050927580.4023@localhost.localdomain> <49D8E71F.6000703@rtr.ca> <49D91B31.90300@garzik.org> <20090405164831.7ad01c20@infradead.org> <49D99775.9030104@garzik.org> <alpine.LFD.2.00.0904071107500.27889@localhost.localdomain> <49DBAC42.4040003@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57560 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756636AbZDISXW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 14:23:22 -0400
In-Reply-To: <49DBAC42.4040003@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>, Theodore Tso <tytso@mit.edu>, Jens Axboe <jens.axboe@oracle.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, George Spelvin <linux@horizon.com>

Jeff Garzik wrote:
> ata_id_string() or ata_id_c_string() is what you want.
> 
> But yeah, we see what you're trying to illustrate.
> 
> For internal reasons, it is better to detect and set up SSD details in
> ata_dev_configure(), where we detect and configure other ATA details.
> 
> I've attached an example patch, compiled-tested only.
> 
> If we wanted to get more fancy, we could extend the strn_pattern_cmp()
> function in libata to accept wildcard '*' prefixes, as well as suffixes.
>  That would make it easy to auto-configure future ATA devices based on
> the product id (such as "G.SKILL 128GB SSD").

There was an shell globbing patch floating around which would be
pretty nice to have for pattern matchings like this.  cc'ing the patch
author.  George, what happened to the patch?

Thanks.

-- 
tejun
