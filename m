From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 3/3] libata: Add support for queued DSM TRIM
Date: Fri, 9 Aug 2013 10:08:40 -0400
Message-ID: <20130809140840.GC20515@mtj.dyndns.org>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
 <1376023752-3105-4-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:39780 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758045Ab3HIOIp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:08:45 -0400
Received: by mail-qa0-f45.google.com with SMTP id l18so901356qak.18
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:08:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376023752-3105-4-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com

Hello,

On Thu, Aug 08, 2013 at 09:49:12PM -0700, Marc C wrote:
> +	if (ata_ncq_enabled(dev) &&
> +	    (dev->ncq_send_recv_cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &
> +	     ATA_LOG_NCQ_SEND_RECV_DSM_TRIM)) {

Can you add a feature test macro for this?

> +		/* Newer devices support queued TRIM commands */
> +		tf->protocol = ATA_PROT_NCQ;
> +		tf->command = ATA_CMD_FPDMA_SEND;
> +		tf->hob_nsect = ATA_SUBCMD_FPDMA_SEND_DSM & 0x1f;
> +		tf->nsect = qc->tag << 3;
> +		tf->hob_feature = (size / 512) >> 8;
> +		tf->feature = size / 512;
> +
> +		qc->auxiliary = 1;
> +	} else {
> +		tf->protocol = ATA_PROT_DMA;
> +		tf->hob_feature = 0;
> +		tf->feature = ATA_DSM_TRIM;
> +		tf->hob_nsect = (size / 512) >> 8;
> +		tf->nsect = size / 512;
> +		tf->command = ATA_CMD_DSM;

So, there are controllers which actually look at the command code and
thus will choke on new commands and just looking at whether the device
supports the new commands is likely to be insufficient.  Have you
tested this?  If so, on which controllers / devices?  We're likely to
need whitelisting on controller side, I think.

Thanks.

-- 
tejun
