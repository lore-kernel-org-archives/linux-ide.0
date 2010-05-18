From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 10/23] libata-sff: clean up BMDMA initialization
Date: Mon, 17 May 2010 22:56:40 -0400
Message-ID: <4BF201E8.2070204@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-11-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56498 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab0ERC4m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 22:56:42 -0400
Received: by gyg13 with SMTP id 13so2570292gyg.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 19:56:41 -0700 (PDT)
In-Reply-To: <1273520507-32459-11-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> When BMDMA initialization failed or BMDMA was not available for
> whatever reason, bmdma_addr was left at zero and used as an indication
> that BMDMA shouldn't be used.  This leads to the following problems.
>
> p1. For BMDMA drivers which don't use traditional BMDMA register,
>      ata_bmdma_mode_filter() incorrectly inhibits DMA modes.  Those
>      drivers either have to inherit from ata_sff_port_ops or clear
>      ->mode_filter explicitly.
>
> p2. non-BMDMA drivers call into BMDMA PRD table allocation.  It
>      doesn't actually allocate PRD table if bmdma_addr is not
>      initialized but is still confusing.
>
> p3. For BMDMA drivers which don't use traditional BMDMA register, some
>      methods might not be invoked as expected (e.g. bmdma_stop from
>      ata_sff_post_internal_cmd()).
>
> p4. SFF drivers w/ custom DMA interface implement noop BMDMA ops
>      worrying libata core might call into one of them.
>
> These problems are caused by the muddy line between SFF and BMDMA and
> the assumption that all BMDMA controllers initialize bmdma_addr.
>
> This patch fixes p1 and p2 by removing the bmdma_addr assumption and
> moving prd allocation to BMDMA port start.  Later patches will fix the
> remaining issues.
>
> This patch improves BMDMA initialization such that
>
> * When BMDMA register initialization fails, falls back to PIO instead
>    of failing.  ata_pci_bmdma_init() never fails now.
>
> * When ata_pci_bmdma_init() falls back to PIO, it clears
>    ap->mwdma_mask and udma_mask instead of depending on
>    ata_bmdma_mode_filter().  This makes ata_bmdma_mode_filter()
>    unnecessary thus resolving p1.
>
> * ata_port_start() which actually is BMDMA specific is moved to
>    ata_bmdma_port_start().  ata_port_start() and ata_sff_port_start()
>    are killed.
>
> * ata_sff_port_start32() is moved and renamed to
>    ata_bmdma_port_start32().
>
> Drivers which no longer call into PRD table allocation are...
>
>    pdc_adma, sata_inic162x, sata_qstor, sata_sx4, pata_cmd640 and all
>    drivers which inherit from ata_sff_port_ops.
>
> pata_icside sets ->port_start to ATA_OP_NULL as it doesn't need PRD
> but is a BMDMA controller and doesn't have custom port_start like
> other such controllers.
>
> Note that with the previous patch which makes all and only BMDMA
> drivers inherit from ata_bmdma_port_ops, this change doesn't break
> drivers which need PRD table.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>

applied, with sata_mv portion removed (fallout from patch #9 edit)


