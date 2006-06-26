From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 14:42:59 +0800
Message-ID: <1151304179.7132.169.camel@forrest26.sh.intel.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60943 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751186AbWFZGzl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 02:55:41 -0400
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Sat, 2006-06-24 at 20:30 +0900, Tejun Heo wrote:
> Hello, all.
> 
> This is the second take of new-power-management patchset.  Changes
> from the last take[1] are...
> 
> * Per-dev PM is now supported.  Now generic device PM layer drives
>   whole PM sequence and libata port-wide PM does much less.
> 

Hello, Tejun

It seems that port-level PM callbacks are removed in this patch set :(
So if the author of other types of SATA controllers need to do port-
level PM operations, they need to first add the callbacks by themselves,
right?
Does it make sense to add port-wide PM callbacks in this patch set?

Thanks,
Forrest
