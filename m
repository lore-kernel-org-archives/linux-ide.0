From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch 1/2] libata-scsi: don't start hotplug work queue if hotplug
 is disabled
Date: Thu, 31 Jul 2008 07:42:14 +0900
Message-ID: <4890EE46.10809@kernel.org>
References: <200807301932.m6UJWcBV012122@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41052 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbYG3WnQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jul 2008 18:43:16 -0400
In-Reply-To: <200807301932.m6UJWcBV012122@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, chunbo.luo@windriver.com

akpm@linux-foundation.org wrote:
> From: Chunbo Luo <chunbo.luo@windriver.com>
> 
> Previously, queue_delayed_work() was started unconditionally, but if
> ATA_PFLAG_SCSI_HOTPLUG is not set and we do this, the work queue may cause
> multiple messages like this:
> 
> ata3.00: WARNING: ATAPI is not supported with this driver, device ignored.
> 
> So now,it is only started when the hotplug flag is actually set.
> 
> Signed-off-by: Chunbo Luo <chunbo.luo@windriver.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Oops, I forgot to send the alternative patch (verified by Chunbo).  I'm
sending it to Jeff now and cc'ing you.  Please drop this one when the
patch hits -mm.

Thanks.

-- 
tejun
