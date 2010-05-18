From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 23/23] libata-sff: make BMDMA optional
Date: Mon, 17 May 2010 23:10:43 -0400
Message-ID: <4BF20533.4030301@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-24-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45942 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab0ERDKp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 23:10:45 -0400
Received: by gwaa20 with SMTP id a20so904589gwa.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 20:10:44 -0700 (PDT)
In-Reply-To: <1273520507-32459-24-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> Make BMDMA optional depending on new config variable CONFIG_ATA_BMDMA.
> In Kconfig, drivers are grouped into five groups - non-SFF native, SFF
> w/ custom DMA interface, SFF w/ BMDMA, PIO-only SFF, and generic
> fallback / legacy ones.  Kconfig and Makefile are reorganized
> according to the groups and ordered alphabetically inside each group.
>
> ata_ioports.bmdma_addr and ata_port.bmdma_prd[_dma] are put into
> CONFIG_ATA_BMDMA, as are all bmdma related ops, variables and
> functions.
>
> This increase the binary size slightly when BMDMA is enabled but on
> both native-only and PIO-only configurations the size is slightly
> reduced.  Either way, the size difference is insignificant.  This
> change is more meaningful to signify the separation between SFF and
> BMDMA and as a tool to verify the separation.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/Kconfig      |  511 ++++++++++++++++++++++++----------------------
>   drivers/ata/Makefile     |   83 ++++----
>   drivers/ata/libata-sff.c |   11 +
>   include/linux/libata.h   |   22 ++-
>   4 files changed, 341 insertions(+), 286 deletions(-)

ack remaining patches


