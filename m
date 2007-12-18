From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix ATAPI draining
Date: Mon, 17 Dec 2007 20:43:52 -0500
Message-ID: <476725D8.5060504@garzik.org>
References: <475F51AE.1010305@gmail.com> <475F53D0.2040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38665 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937196AbXLRBnz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 20:43:55 -0500
In-Reply-To: <475F53D0.2040703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, will@trivescon.com.au, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> With ATAPI transfer chunk size properly programmed, libata PIO HSM
> should be able to handle full spurious data chunks.  Also, it's a good
> idea to suppress trailing data warning for misc ATAPI commands as
> there can be many of them per command - for example, if the chunk size
> is 16 and the drive tries to transfer 510 bytes, there can be 31
> trailing data messages.
> 
> This patch makes the following updates to libata ATAPI PIO HSM
> implementation.
> 
> * Make it drain full spurious chunks.
> 
> * Suppress trailing data warning message for misc commands.
> 
> * Put limit on how many bytes can be drained.
> 
> * If odd, round up consumed bytes and the number of bytes to be
>   drained.  This gets the number of bytes to drain right for drivers
>   which do 16bit PIO.
> 
> This patch is partial backport of improve-ATAPI-data-xfer patchset
> pending for #upstream.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This combined with the previous patch fixes bug 9346.
> 
>  drivers/ata/libata-core.c |   87 ++++++++++++++++++++++++++++++++++------------
>  include/linux/libata.h    |    2 +
>  2 files changed, 67 insertions(+), 22 deletions(-)
> 
> Index: work/drivers/ata/libata-core.c
> ===================================================================
> --- work.orig/drivers/ata/libata-core.c
> +++ work/drivers/ata/libata-core.c
> @@ -64,6 +64,7 @@
>  #include <linux/libata.h>
>  #include <asm/semaphore.h>
>  #include <asm/byteorder.h>
> +#include <linux/cdrom.h>
>  
>  #include "libata.h"
>  
> @@ -4649,6 +4650,43 @@ int ata_check_atapi_dma(struct ata_queue
>  }
>  
>  /**
> + *	atapi_qc_may_overflow - Check whether data transfer may overflow
> + *	@qc: ATA command in question
> + *
> + *	ATAPI commands which transfer variable length data to host
> + *	might overflow due to application error or hardare bug.  This
> + *	function checks whether overflow should be drained and ignored
> + *	for @qc.
> + *
> + *	LOCKING:
> + *	None.
> + *
> + *	RETURNS:
> + *	1 if @qc may overflow; otherwise, 0.
> + */
> +static int atapi_qc_may_overflow(struct ata_queued_cmd *qc)
> +{
> +	if (qc->tf.protocol != ATA_PROT_ATAPI &&
> +	    qc->tf.protocol != ATA_PROT_ATAPI_DMA)
> +		return 0;
> +
> +	if (qc->tf.flags & ATA_TFLAG_WRITE)
> +		return 0;
> +
> +	switch (qc->cdb[0]) {
> +	case READ_10:
> +	case READ_12:
> +	case WRITE_10:
> +	case WRITE_12:
> +	case GPCMD_READ_CD:
> +	case GPCMD_READ_CD_MSF:
> +		return 0;
> +	}
> +
> +	return 1;

applied, though I hope we can eventually find a better solution...


