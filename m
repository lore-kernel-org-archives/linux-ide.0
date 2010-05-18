From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 09/23] libata-sff: clean up inheritance in several drivers
Date: Mon, 17 May 2010 22:52:01 -0400
Message-ID: <4BF200D1.6030600@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-10-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60021 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0ERCwD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 22:52:03 -0400
Received: by gwaa20 with SMTP id a20so898468gwa.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 19:52:02 -0700 (PDT)
In-Reply-To: <1273520507-32459-10-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> 1. pata_cmd640 is PIO only.  Inherit from sff.
>
> 2. pata_macio is BMDMA.  Inherit from bmdma and drop explicit
>     bmdma_mode_filter() setting.
>
> 3. bf54x and icside are quasi-BMDMA controllers which don't use the
>     standard BMDMA registers so they don't initialize bmdma_addr and
>     inherit from sff to avoid the default mode_filter which disables
>     DMA modes if bmdma_addr is not initialized.
>
> For 2 and 3, this patch makes the drivers explicitly specify
> ->mode_filter to ATA_OP_NULL while inheriting from ata_bmdma_port_ops.
> These will be removed by the next patch.
>
> This patch makes all and only BMDMA drivers inherit from
> ata_bmdma_port_ops to ease further SFF/BMDMA separation.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>

applied, sans the sata_mv (mistakenly labelled as pata_marvell) patch

sata_mv is not standard BMDMA, unless I am confused about something?


