From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] libata: introduce ata_host_set_queue_depth()
Date: Mon, 7 Jul 2014 09:49:45 -0400
Message-ID: <20140707134945.GA18550@htj.dyndns.org>
References: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
 <1404628121-8158-2-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:51757 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaGGNts (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2014 09:49:48 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so3463471qae.33
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2014 06:49:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1404628121-8158-2-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

Hello,

On Sun, Jul 06, 2014 at 02:28:40PM +0800, Kevin Hao wrote:
> +int ata_host_set_queue_depth(struct ata_host *host, unsigned int queue_depth)

Hmmm... is there a reason we're doing this separately when the same
information is available from scsi_host_template->can_queue from
ata_host_register()?

> @@ -5731,6 +5752,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
>  	mutex_init(&host->eh_mutex);
>  	host->dev = dev;
>  	host->n_ports = max_ports;
> +	host->queue_depth = ATA_MAX_QUEUE;

And shouldn't this be one for !NCQ controllers?

Thanks.

-- 
tejun
