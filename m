From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.20-rc4-mm1
Date: Mon, 15 Jan 2007 09:22:20 +0100
Message-ID: <20070115082219.GA9062@elte.hu>
References: <20070111222627.66bb75ab.akpm@osdl.org> <1168768104.2941.53.camel@localhost.localdomain> <1168771617.2941.59.camel@localhost.localdomain> <1168785616.2941.67.camel@localhost.localdomain> <20070114220515.GG5860@kernel.dk> <1168813901.2941.85.camel@localhost.localdomain> <20070114223019.GP5860@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:40273 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbXAOIdv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 03:33:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim)
	id 1H6NHj-00047l-Mh
	from <mingo@elte.hu>
	for <linux-ide@vger.kernel.org>; Mon, 15 Jan 2007 09:33:44 +0100
Content-Disposition: inline
In-Reply-To: <20070114223019.GP5860@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org


* Jens Axboe <jens.axboe@oracle.com> wrote:

> > In a previous write invoked by: fsck.ext3(1896): WRITE block 8552 on 
> > sdb1 end_buffer_async_write() is invoked.
> > 
> > sdb1 is not a part of a raid device.
> 
> When I briefly tested this before I left (and found it broken), doing 
> a cat /proc/mdstat got things going again. Hard if that's your rootfs, 
> it's just a hint :-)

hm, so you knew it's broken, still you let Andrew pick it up, or am i 
misunderstanding something?

	Ingo
