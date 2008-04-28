From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH #upstream-fixes 2/2] libata-scsi: improve rbuf handling
 for simulated commands
Date: Mon, 28 Apr 2008 17:37:35 +0900
Message-ID: <20080428173834Z.tomof@acm.org>
References: <481587F4.6090006@gmail.com>
	<48158826.8070209@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:57758 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763573AbYD1Ihq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 04:37:46 -0400
In-Reply-To: <48158826.8070209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, petr@vmware.com

On Mon, 28 Apr 2008 17:17:42 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Buffer length handling in simulated commands is error-prone and full
> of bugs.  There are a number of places where necessary length checks
> are missing and if the output buffer is passed in as sglist, nothing
> works.
> 
> This patch adds a static buffer ata_scsi_rbuf which is sufficiently
> large to handle the larges output from simulated commands (4k
> currently), let all simulte functions write to the buffer and removes
> all length checks as we know that there always is enough buffer space.
> Copying in (for ATAPI inquiry fix up) and out are handled by
> ata_scsi_copy_rbuf() behind ata_scsi_rbuf_get/put() interface and
> sglist is handled properly.
> 
> This patch is inspired from buffer length check fix patch from Petr
> Vandrovec.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Petr Vandrovec <petr@vmware.com>
> ---
>  drivers/ata/libata-scsi.c |  471 +++++++++++++++++-----------------------------
>  1 file changed, 180 insertions(+), 291 deletions(-)
> 
> Index: work/drivers/ata/libata-scsi.c
> ===================================================================
> --- work.orig/drivers/ata/libata-scsi.c
> +++ work/drivers/ata/libata-scsi.c
> @@ -49,7 +49,11 @@
>  
>  #include "libata.h"
>  
> -#define SECTOR_SIZE	512
> +#define SECTOR_SIZE		512
> +#define ATA_SCSI_RBUF_SIZE	4096
> +
> +static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
> +static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
>  
>  typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc);
>  
> @@ -1637,55 +1641,75 @@ defer:
>  		return SCSI_MLQUEUE_HOST_BUSY;
>  }
>  
> +static void ata_scsi_copy_rbuf(struct scsi_cmnd *cmd, bool out)
> +{
> +	char *data = ata_scsi_rbuf;
> +	unsigned int left = ATA_SCSI_RBUF_SIZE;
> +	struct scatterlist *sg;
> +	unsigned int si;
> +
> +	for_each_sg(scsi_sglist(cmd), sg, scsi_sg_count(cmd), si) {
> +		unsigned int len = min_t(unsigned int, sg->length, left);
> +		char *page;
> +
> +		page = kmap_atomic(sg_page(sg), KM_IRQ0);
> +
> +		if (out)
> +			memcpy(page + sg->offset, data, len);
> +		else
> +			memcpy(data, page + sg->offset, len);
> +		data += len;
> +		left -= len;
> +
> +		kunmap_atomic(page, KM_IRQ0);
> +
> +		if (!left)
> +			break;
> +	}
> +}

How about using sg_copy_from_buffer and sg_copy_to_buffer in
lib/scatterlist.c?
