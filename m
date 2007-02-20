From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: disable pdev on all suspend events
Date: Tue, 20 Feb 2007 11:02:41 -0500
Message-ID: <45DB1BA1.4010802@garzik.org>
References: <20070216213153.f6704ff5.akpm@linux-foundation.org> <45D6FE5A.1080603@gmail.com> <45DABC08.9030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44213 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965210AbXBTQCq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 11:02:46 -0500
In-Reply-To: <45DABC08.9030607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pavel@suse.cz

Tejun Heo wrote:
> libata used disable pdev only on PM_EVENT_SUSPEND while re-enable pdev
> unconditionally.  This was okay before ref-counted pdev enable update
> but it now makes the pdev pinned after swsusp cycle (enabled twice but
> disabled only once) and devres sanity check whines about it.
> 
> Fix it by unconditionally disabling pdev on all suspend events.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Pavel, I took your advice and chose to disable unconditionally rather
> than recording the status separately, but I still think it would be
> nice if we can tell the status we're waking from from either the mesg
> itself (say, PM_EVENT_THAW) or recorded prev state.
> 
> Both STM and STD are tested.  Please apply.  Thanks.

applied


