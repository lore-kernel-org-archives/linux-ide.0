From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix n_sectors failure handling
 during revalidation
Date: Thu, 23 Aug 2007 05:25:59 -0400
Message-ID: <46CD52A7.4030901@garzik.org>
References: <20070815180222.GC21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39827 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758051AbXHWJ0B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 05:26:01 -0400
In-Reply-To: <20070815180222.GC21623@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> If revalidation fails because device has different n_sectors after
> configuration the original n_sectors should be restored before failing
> revalidation.  Without this fix, n_sectors difference will incorrectly
> and silently pass revalidation when revalidation is retried.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    4 ++++
>  1 file changed, 4 insertions(+)

applied


