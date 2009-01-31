From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 00/07] sata_mv: ATAPI patchset
Date: Fri, 30 Jan 2009 19:04:34 -0500
Message-ID: <49839592.6000308@rtr.ca>
References: <49839107.2040603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57488 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754414AbZAaAEf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 19:04:35 -0500
In-Reply-To: <49839107.2040603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> The following patchset adds ATAPI capability to sata_mv.
> These patches are all for #upstream.
> 
> 01_sata_mv_cleanup_flags.patch
> 02_sata_mv_edma_cfg.patch
> 03_sata_mv_qc_issue.patch
> 04_sata_mv_get_active_qc.patch
> 05_sata_mv_fill_sg.patch
> 06_sata_mv_atapi_dma.patch
> 07_sata_mv_optimize_edma_cfg_use.patch
..

As you can see, I decided to do a little more cleanup in the driver
prior to tacking on the actual ATAPI stuff.  :)

All of these are on top of the earlier submitted patch
which corrects the chipset IDs for the Highpoint RocketRAID 174x cards.

ATAPI DMA works for GEN_II chips, but not for GEN_IIE.
Marvell may eventually find a way to make it work for those, as well.

Patch 05 above could be a candidate for 2.6.29
as well as #upstream.

Cheers
