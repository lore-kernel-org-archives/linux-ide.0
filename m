From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_via: pcim_iomap_regions() conversion missed BAR5
Date: Thu, 17 May 2007 15:49:49 +0200
Message-ID: <464C5D7D.1080402@gmail.com>
References: <464C29DC.80901@deadlyninja.com> <464C3E68.30608@gmail.com> <464C5B47.1080106@deadlyninja.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:59986 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbXEQNuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 09:50:18 -0400
Received: by wr-out-0506.google.com with SMTP id 76so614855wra
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 06:50:17 -0700 (PDT)
In-Reply-To: <464C5B47.1080106@deadlyninja.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Valenzuela <tim@deadlyninja.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tim Valenzuela wrote:
> Good news: This patch does correct the IO access errors.
> Bad news: The sata driver now performs exactly like previous kernels, my
> sata3 works, sata4 has IDENTIFY errors.

The patch doesn't do anything about that problem, so it's expected.

> [   26.927349] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   26.961636] ata4.00: ata_hpa_resize 1: sectors = 625142448,
> hpa_sectors = 625142448
> [   26.961754] ata4.00: ATA-7: WDC WD3200AAKS-00SBA0, 12.01B01, max
> UDMA/133
> [   26.961843] ata4.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [   26.979289] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
> [   26.979376] ata4.00: revalidation failed (errno=-5)
> [   26.979458] ata4: failed to recover some devices, retrying in 5 secs
> [   32.451247] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   32.475231] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
> [   32.475317] ata4.00: revalidation failed (errno=-5)
> [   32.475401] ata4.00: limiting speed to UDMA/133:PIO3
> [   32.475483] ata4: failed to recover some devices, retrying in 5 secs
> [   37.947188] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   37.971173] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
> [   37.971259] ata4.00: revalidation failed (errno=-5)
> [   37.971341] ata4.00: disabled

Can you swap the two disks and see what happens?  It seems the second
IDENTIFY after configuring transfer mode fails.  I'm curious whether
that's caused by the disk or the controller.

-- 
tejun
