From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH -next] libata: fix kernel-doc warnings
Date: Mon, 02 Feb 2009 22:43:02 -0500
Message-ID: <4987BD46.5000906@pobox.com>
References: <20090120162859.022628c1.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34435 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbZBCDnH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 22:43:07 -0500
In-Reply-To: <20090120162859.022628c1.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix libata kernel-doc warnings:
> 
> Warning(linux-next-20090120//drivers/ata/libata-core.c:4720): Excess function parameter 'dev' description in 'ata_qc_new'
> Warning(linux-next-20090120//drivers/ata/libata-scsi.c:428): No description found for parameter 'ap'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/libata-core.c |    3 +--
>  drivers/ata/libata-scsi.c |    1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20090120.orig/drivers/ata/libata-core.c
> +++ linux-next-20090120/drivers/ata/libata-core.c
> @@ -4709,8 +4709,7 @@ void swap_buf_le16(u16 *buf, unsigned in
>  
>  /**
>   *	ata_qc_new - Request an available ATA command, for queueing
> - *	@ap: Port associated with device @dev
> - *	@dev: Device from whom we request an available command structure
> + *	@ap: target port
>   *
>   *	LOCKING:
>   *	None.
> --- linux-next-20090120.orig/drivers/ata/libata-scsi.c
> +++ linux-next-20090120/drivers/ata/libata-scsi.c
> @@ -414,6 +414,7 @@ int ata_std_bios_param(struct scsi_devic
>  
>  /**
>   *	ata_get_identity - Handler for HDIO_GET_IDENTITY ioctl
> + *	@ap: target port
>   *	@sdev: SCSI device to get identify data for
>   *	@arg: User buffer area for identify data

applied to -rc


