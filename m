From: Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PATCH] block,scsi,ide: unify sector and data_len, take#2
Date: Tue, 12 May 2009 09:49:39 +0900
Message-ID: <4A08C7A3.50201@kernel.org>
References: <1241423927-11871-1-git-send-email-tj@kernel.org> <4A0814A9.5040603@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33637 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587AbZELAxl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 20:53:41 -0400
In-Reply-To: <4A0814A9.5040603@panasas.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org, bzolnier@gmail.com, petkovbb@googlemail.com, sshtylyov@ru.mvista.com, mike.miller@hp.com, Eric.Moore@lsi.com, stern@rowland.harvard.edu, fujita.tomonori@lab.ntt.co.jp, zaitcev@redhat.com, Geert.Uytterhoeven@sonycom.com, sfr@canb.auug.org.au, grant.likely@secretlab.ca, paul.clements@steeleye.com, tim@cyberelk.net, jeremy@xensource.com, adrian@mcmen.demon.co.uk, oakad@yahoo.com, dwmw2@infradead.org, schwidefsky@de.ibm.com, ballabio_dario@emc.com, davem@davemloft.net, rusty@rustcorp.com.au, Markus.Lidel@shadowconnect.com

Hello, Boaz.

Boaz Harrosh wrote:
> I've inspected all scsi touching patches and refrained from comments
> on the simple rename bunch. They all look very good accept that one
> place. (which will effect 2 patches)
>
> There are few more places that can use blk_end_request_all() after
> these changes.
> 
> (The same internet outage on this reply)

The tree is now in Jens' tree, so it won't be rebased from this point
on.  Please go ahead and submit patches.

Thanks.

-- 
tejun
