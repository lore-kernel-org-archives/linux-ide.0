From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git-patches] EH, irq-pio merge and NCQ patches
Date: Mon, 15 May 2006 21:11:13 +0900
Message-ID: <44686FE1.5020804@gmail.com>
References: <20060515120808.GA23124@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:2867 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751214AbWEOMLT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 08:11:19 -0400
Received: by wr-out-0506.google.com with SMTP id i28so808041wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 05:11:18 -0700 (PDT)
In-Reply-To: <20060515120808.GA23124@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Jeff.
> 
> This is the updated git-patches of previously posted five
> patchsets[1].  Changes are
> 
> * SCSI-implement-host_eh_scheduled patch updated as discussed.
> 
> * A new patch, which renames ata_down_sata_spd_limit() and friends to
>   sata_*(), is added to prep patchset.
> 
> * ata_scr_*() renamed to sata_scr_*()
> 
> * ehc->flags has been moved to ehi->flags so that it can also be used
>   to pass flags from IRQ handler to EH.
> 
> * Spurious ata_dev_init() prototype killed from ering patch.
> 
> * ata_ering is changed to include #ATA_ERING_SIZE predefined ering
>   entries.  As this makes add-dev-ering patch trivial, the patch is
>   collapsed into implement-ering.
> 
> * sata_sil EH now directly calls ata_bmdma_irq_clear() instead of
>   calling ops->irq_clear().

I forgot one.

* AHCI now has proper IRQ-mask manipulating freeze/thaw().

-- 
tejun
