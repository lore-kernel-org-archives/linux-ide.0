From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] ata: Enabling ATA Command Priorities
Date: Thu, 29 Sep 2016 10:45:29 +0200
Message-ID: <20160929084529.GC11087@mtj.duckdns.org>
References: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
 <1475000096-6148-3-git-send-email-adam.manzanares@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34728 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754916AbcI2Ipm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Sep 2016 04:45:42 -0400
Content-Disposition: inline
In-Reply-To: <1475000096-6148-3-git-send-email-adam.manzanares@hgst.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adam Manzanares <adam.manzanares@hgst.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On Tue, Sep 27, 2016 at 11:14:55AM -0700, Adam Manzanares wrote:
> +/**
> + *	ata_ncq_prio_enabled - Test whether NCQ prio is enabled
> + *	@dev: ATA device to test for
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host lock)
> + *
> + *	RETURNS:
> + *	1 if NCQ prio is enabled for @dev, 0 otherwise.
> + */
> +static inline int ata_ncq_prio_enabled(struct ata_device *dev)
> +{
> +	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
> +			      ATA_DFLAG_NCQ_PRIO)) == ATA_DFLAG_NCQ_PRIO;

I'm not sure this needs to test PIO and NCQ_OFF.  This functions
pretty much can assume that it'd be only called in NCQ context, no?

Thanks.

-- 
tejun
