From: Andrew Morton <akpm@osdl.org>
Subject: Re: [git patches] 2.6.x libata updates
Date: Tue, 17 Jan 2006 18:33:18 -0800
Message-ID: <20060117183318.1031c0d2.akpm@osdl.org>
References: <20060118021530.GA23108@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:30398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964852AbWARCmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 21:42:15 -0500
In-Reply-To: <20060118021530.GA23108@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Reuben Farrelly <reuben-lkml@reub.net>

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  Please pull from 'upstream-linus' branch of
>  master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

I worry that whatever it is which has busted Reuben's machine will leak
into mainline.  This patch probably isn't it.

I guess if we can feed libata and acpi into mainline in little bits and
pieces like this, that'll help us work out the cause.

Reuben has spent ages bisecting lots of patches, but the bug is quite
intermittent, which makes the process quite maddeningly error-prone and
slow.

Then again, perhaps merging it up is the best way of fixing it: someone out
there will hit the thing more repeatably and will have a better shot at
finding the cause.


