From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] libata: support the ata host which implements a queue
 depth less than 32
Date: Fri, 11 Jul 2014 10:51:05 -0400
Message-ID: <20140711145105.GC27706@htj.dyndns.org>
References: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:37843 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbaGKOvI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 10:51:08 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so973367qac.35
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 07:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Fri, Jul 11, 2014 at 02:10:26PM +0800, Kevin Hao wrote:
>  static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
>  {
>  	struct ata_queued_cmd *qc = NULL;
> -	unsigned int i, tag;
> +	unsigned int i, tag, max_queue;
> +
> +	max_queue = ap->scsi_host->can_queue;
> +	WARN_ON_ONCE(max_queue > ATA_MAX_QUEUE);

Let's move the WARN_ON_ONCE() to ata_host_register().  Also, let's
please update the function comment explaining why we're allocating
tags the way we do.

Other than that, it looks good to me.

Thanks.

-- 
tejun
