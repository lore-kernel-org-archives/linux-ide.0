From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 3/3] libata: Add support for queued DSM TRIM
Date: Fri, 23 Aug 2013 12:07:19 -0400
Message-ID: <20130823160719.GI3277@htj.dyndns.org>
References: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
 <1377250847-24132-4-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:48938 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab3HWQHX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Aug 2013 12:07:23 -0400
Received: by mail-qc0-f169.google.com with SMTP id m15so436545qcq.28
        for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2013 09:07:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377250847-24132-4-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, Aug 23, 2013 at 02:40:47AM -0700, Marc C wrote:
> +static inline int ata_fpdma_dsm_supported(struct ata_device *dev)

bool?

> +{
> +	if ((dev->flags & ATA_DFLAG_NCQ_SEND_RECV) &&
> +	    (dev->ncq_send_recv_cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &
> +	     ATA_LOG_NCQ_SEND_RECV_DSM_TRIM)) {
> +		return 1;
> +	} else {
> +		return 0;
> +	}

And again, you can just use a return statement.

-- 
tejun
