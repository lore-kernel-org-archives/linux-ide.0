From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 7/8] ide: add struct ide_port_info instances to legacy
 host drivers
Date: Mon, 11 Feb 2008 01:07:29 +0900 (JST)
Message-ID: <20080211.010729.115910395.anemo@mba.ocn.ne.jp>
References: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
	<20080106170310.6861.14522.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:56096 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbYBJQ3p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Feb 2008 11:29:45 -0500
In-Reply-To: <20080106170310.6861.14522.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 06 Jan 2008 18:03:10 +0100, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> +	/* reset DMA masks only for SFF-style DMA controllers */
> +	if ((d->host_flags && IDE_HFLAG_NO_DMA) == 0 && hwif->dma_base == 0)
> +		hwif->swdma_mask = hwif->mwdma_mask = hwif->ultra_mask = 0;

It might be too late, but "host_flags && IDE_HFLAGS_NO_DMA" seems
wrong for me.

---
Atsushi Nemoto
