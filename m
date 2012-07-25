From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [resend PATCH 5/5] libsas, ipr: cleanup ata_host flags initialization
 via ata_host_init
Date: Wed, 25 Jul 2012 15:01:27 -0500
Message-ID: <50105097.6040307@linux.vnet.ibm.com>
References: <20120710040434.26529.86552.stgit@dwillia2-linux.jf.intel.com> <20120710040608.26529.20117.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:42441 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab2GYUDa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jul 2012 16:03:30 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-ide@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Wed, 25 Jul 2012 16:01:49 -0400
In-Reply-To: <20120710040608.26529.20117.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: jgarzik@pobox.com, JBottomley@parallels.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On 07/09/2012 11:06 PM, Dan Williams wrote:
> libsas and ipr pass flags to ata_host_init that are meant for the port.
> 
> ata_host flags:
> 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
> 	ATA_HOST_STARTED	= (1 << 1),	/* Host started */
> 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
> 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
> 
> flags passed by libsas:
> 	ATA_FLAG_SATA		= (1 << 1),
> 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
> 	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
> 
> The only one that aliases is ATA_HOST_STARTED which is a 'don't care' in
> the libsas and ipr cases since ata_hosts from these sources are not
> registered with libata.
> 
> Cc: Brian King <brking@us.ibm.com>
> Reported-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/ata/libata-core.c     |   10 ++--------
>  drivers/scsi/ipr.c            |    3 +--
>  drivers/scsi/libsas/sas_ata.c |    5 +----
>  include/linux/libata.h        |    3 +--

Acked-by: Brian King <brking@linux.vnet.ibm.com>

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center




