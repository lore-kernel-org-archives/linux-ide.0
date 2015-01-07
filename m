From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 4/4] sata_dwc_460ex: fix most of the sparse warnings
Date: Wed, 7 Jan 2015 10:36:32 -0500
Message-ID: <20150107153632.GD4395@htj.dyndns.org>
References: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1420637062-15450-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:51382 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbbAGPgg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2015 10:36:36 -0500
Received: by mail-qg0-f53.google.com with SMTP id l89so996002qgf.26
        for <linux-ide@vger.kernel.org>; Wed, 07 Jan 2015 07:36:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420637062-15450-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Miesfeld <mmiesfeld@amcc.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org

On Wed, Jan 07, 2015 at 03:24:22PM +0200, Andy Shevchenko wrote:
> There are a lot sparse warnings. Most of them related to __iomem keyword which
> sometimes absent when it's needed and vise versa.
> 
> The patch fixes most of the warnings.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied 1-4 to libata/for-3.19-fixes.  One nit below.

> @@ -1630,7 +1629,7 @@ static struct scsi_host_template sata_dwc_sht = {
>  	 * max of 1. This will get fixed in in a future release.
>  	 */
>  	.sg_tablesize		= LIBATA_MAX_PRD,
> -	.can_queue		= ATA_DEF_QUEUE,	/* ATA_MAX_QUEUE */
> +	/* .can_queue		= ATA_MAX_QUEUE, */

This part isn't explained by the patch description.  I added it while
applying but please make sure that the patch descriptions are
comprehensive.

Thanks!

-- 
tejun
