From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch v2 3/3] SATA: enable non-queueable flush flag
Date: Wed, 4 May 2011 10:53:23 +0200
Message-ID: <20110504085323.GB8007@htj.dyndns.org>
References: <20110504081725.946950281@sli10-conroe.sh.intel.com>
 <20110504082115.488846050@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40471 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab1EDIx2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2011 04:53:28 -0400
Content-Disposition: inline
In-Reply-To: <20110504082115.488846050@sli10-conroe.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shaohua.li@intel.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jaxboe@fusionio.com, jgarzik@pobox.com, hch@infradead.org, djwong@us.ibm.com

On Wed, May 04, 2011 at 04:17:28PM +0800, shaohua.li@intel.com wrote:
> Enable non-queueable flush flag for SATA.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/ata/libata-scsi.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux/drivers/ata/libata-scsi.c
> ===================================================================
> --- linux.orig/drivers/ata/libata-scsi.c	2011-05-04 14:20:41.000000000 +0800
> +++ linux/drivers/ata/libata-scsi.c	2011-05-04 14:28:28.000000000 +0800
> @@ -3424,7 +3424,9 @@ void ata_scsi_scan_host(struct ata_port
>  			sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
>  						 NULL);
>  			if (!IS_ERR(sdev)) {
> +				struct request_queue *q = sdev->request_queue;
>  				dev->sdev = sdev;
> +				blk_set_queue_flush_queueable(q, false);
>  				scsi_device_put(sdev);
>  			} else {
>  				dev->sdev = NULL;

Isn't ata_scsi_dev_config() better place for this?

Thakns.

-- 
tejun
