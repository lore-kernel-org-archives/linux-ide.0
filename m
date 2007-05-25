From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 03/11] Optional LED trigger for libata
Date: Thu, 24 May 2007 23:26:16 -0400
Message-ID: <46565758.508@garzik.org>
References: <200705232126.l4NLQfXT032526@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50840 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbXEYD0V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 23:26:21 -0400
In-Reply-To: <200705232126.l4NLQfXT032526@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: chainsaw@gentoo.org, htejun@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>

akpm@linux-foundation.org wrote:
> From: Tony Vroon <chainsaw@gentoo.org>
> 
> This adds an optional wrapper around ata_ac_issue_prot that triggers the
> LED layer.  This is used for the PMU LED on G5 towers (IDE trigger).  My
> test platform is a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) with a K2
> (sata_svw) controller.  Now respun as a single patch, and the function name
> shortened as requested.
> 
> Signed-off-by: Tony Vroon <chainsaw@gentoo.org>
> Acked-by: Tejun Heo <htejun@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-core.c |   21 +++++++++++++++++++++
>  drivers/ata/sata_svw.c    |    2 +-
>  include/linux/libata.h    |    1 +
>  3 files changed, 23 insertions(+), 1 deletion(-)


After sitting on this for a time, I still cannot summon any interest in 
taking this patch.  It slows down the hot path for pretty lights.

