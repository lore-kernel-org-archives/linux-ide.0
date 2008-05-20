From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 22/40] ide-floppy: start DMA engine in idefloppy_transfer_pc1()
Date: Tue, 20 May 2008 15:00:41 +0400
Message-ID: <4832AF59.1020808@ru.mvista.com>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain> <20080518185745.5636.55162.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:56519 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756822AbYETLBG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2008 07:01:06 -0400
In-Reply-To: <20080518185745.5636.55162.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Start DMA engine and set PC_FLAG_DMA_IN_PROGRESS flag in
> idefloppy_transfer_pc1() instead of idefloppy_issue_pc()

    Good. I have long ago noticed that DMA is started too early in ide-floppy 
which is known to cobfuse some chips (like PDC20246) and was going to do a 
patch at first but the lack of hardware (and time) stopped me...

> so the Status Register and the Interrupt Reason Register
> are checked first.

> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide-floppy.c
> ===================================================================
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
[...]
> @@ -568,6 +569,12 @@ static ide_startstop_t idefloppy_transfe
>  
>  	ide_set_handler(drive, &idefloppy_pc_intr, timeout, expiry);
>  
> +	/* Begin DMA, if necessary */
> +	if (pc->flags & PC_FLAG_DMA_OK) {
> +		pc->flags |= PC_FLAG_DMA_IN_PROGRESS;
> +		hwif->dma_ops->dma_start(drive);
> +	}
> +

    May be too early still... ide-cd does this after writing the command packet.

WBR, Sergei
