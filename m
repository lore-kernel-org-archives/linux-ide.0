From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/3] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Fri, 9 Aug 2013 10:05:06 -0400
Message-ID: <20130809140506.GB20515@mtj.dyndns.org>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
 <1376023752-3105-3-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:48525 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758018Ab3HIOFL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:05:11 -0400
Received: by mail-qa0-f53.google.com with SMTP id hu14so918750qab.12
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:05:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376023752-3105-3-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com

On Thu, Aug 08, 2013 at 09:49:11PM -0700, Marc C wrote:
> @@ -2131,6 +2131,7 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>  	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
>  	unsigned int err_mask;
>  	char *aa_desc = "";
> +	u8 sata_setting[ATA_SECT_SIZE];

Nope.  Please don't do this.  Can't you use ap->sector_buf?

-- 
tejun
