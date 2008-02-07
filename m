From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/4] libata: implement ATAPI drain buffer
Date: Wed, 06 Feb 2008 19:14:20 -0500
Message-ID: <47AA4D5C.7010807@garzik.org>
References: <11992723701811-git-send-email-htejun@gmail.com> <11992723711076-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47031 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933163AbYBGAOW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 19:14:22 -0500
In-Reply-To: <11992723711076-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Misc ATAPI commands may try to transfer more bytes than requested.
> For PIO which is performed by libata HSM, this is worked around by
> draining extra bytes from __atapi_pio_bytes().
> 
> This patch implements drain buffer to perform draining for DMA and
> PIO-over-DMA cases.  One page is allocated w/ GFP_DMA32 during libata
> core layer initialization.  On host registration, this drain page is
> DMA mapped and ATAPI_MAX_DRAIN_PAGES sg entries are reserved.
> 
> ata_sg_setup_extra() uses these extra sg entries to map the drain page
> ATAPI_MAX_DRAIN_PAGES times, extending sg list by ATAPI_MAX_DRAIN
> bytes.  This allows both DMA and PIO-over-DMA misc ATAPI commands to
> overflow by ATAPI_MAX_DRAIN bytes just like PIO commands.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |  116 ++++++++++++++++++++++++++++++++++++++++-----
>  drivers/ata/libata-scsi.c |   14 ++++--
>  include/linux/libata.h    |    4 +-
>  3 files changed, 116 insertions(+), 18 deletions(-)


(updating status on an old patch)

dropped, due to your current work


