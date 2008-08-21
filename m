From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch 1/3] libata-scsi: don't start hotplug work queue if hotplug
 is disabled
Date: Thu, 21 Aug 2008 11:38:37 +0900
Message-ID: <48ACD52D.8090703@kernel.org>
References: <200808202348.m7KNmXHq005814@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38007 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753757AbYHUCju (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Aug 2008 22:39:50 -0400
In-Reply-To: <200808202348.m7KNmXHq005814@imap1.linux-foundation.org>
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

Andrew, this problem is solved by another patch and already went upstream.

  http://article.gmane.org/gmane.linux.ide/33261

Can you please drop this one?

Thanks.

-- 
tejun
