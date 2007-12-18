From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 13/15] libata: implement ATAPI drain buffer
Date: Tue, 18 Dec 2007 16:45:16 -0500
Message-ID: <47683F6C.1070003@garzik.org>
References: <11968405951262-git-send-email-htejun@gmail.com> <1196840598577-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48182 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbXLRVpS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:45:18 -0500
In-Reply-To: <1196840598577-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

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

ACK this patch and #14 (implement ATAPI per-command-type DMA horkages), 
but I am dropping both due to the need to be rediffed against latest 
#upstream (including recent #upstream-fixes changes).


