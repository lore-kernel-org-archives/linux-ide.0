From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Wed, 18 Jan 2006 00:18:57 -0500
Message-ID: <43CDCFC1.2000008@pobox.com>
References: <20060118021530.GA23108@havoc.gtf.org> <20060117183318.1031c0d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36018 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030240AbWARFTE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2006 00:19:04 -0500
In-Reply-To: <20060117183318.1031c0d2.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Reuben Farrelly <reuben-lkml@reub.net>

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> 
> I worry that whatever it is which has busted Reuben's machine will leak
> into mainline.  This patch probably isn't it.

Nothing at all in this push is remotely controversial...


> I guess if we can feed libata and acpi into mainline in little bits and
> pieces like this, that'll help us work out the cause.
> 
> Reuben has spent ages bisecting lots of patches, but the bug is quite
> intermittent, which makes the process quite maddeningly error-prone and
> slow.
> 
> Then again, perhaps merging it up is the best way of fixing it: someone out
> there will hit the thing more repeatably and will have a better shot at
> finding the cause.

Well, I haven't even looked at ACPI yet, and the Jens/Tejun stuff didn't 
get much testing at all.  There's a lot of unfamiliar stuff in the mix.

	Jeff


