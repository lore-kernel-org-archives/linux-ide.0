From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 31/64] cmd64x: fix PIO and MWDMA timings calculations
Date: Tue, 19 Jan 2010 01:26:02 -0800 (PST)
Message-ID: <20100119.012602.119364853.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171826.14623.15282.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46307
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755911Ab0ASJZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 04:25:52 -0500
In-Reply-To: <20100118171826.14623.15282.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:18:26 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] cmd64x: fix PIO and MWDMA timings calculations
> 
> Just use the standard ide_timing_compute() helper to calculate
> PIO and MWDMA timings.  This fixes some issues with the open-coded
> version like allowing faster MWDMA timings than the ones required
> by the current PIO mode or not accounting for the enhanced MWDMA
> cycle time specified by the device.
> 
> Based on libata pata_cmd64x host driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
