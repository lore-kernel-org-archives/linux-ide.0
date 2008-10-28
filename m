From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: add missing kernel-doc
Date: Mon, 27 Oct 2008 23:57:51 -0400
Message-ID: <49068DBF.8080407@pobox.com>
References: <20081026201932.d012e8dc.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54361 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbYJ1D55 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 23:57:57 -0400
In-Reply-To: <20081026201932.d012e8dc.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix libata missing kernel-doc:
> 
> Warning(lin2628-rc2//drivers/ata/libata-core.c:4562): No description found for parameter 'tag'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lin2628-rc2.orig/drivers/ata/libata-core.c
> +++ lin2628-rc2/drivers/ata/libata-core.c
> @@ -4553,6 +4553,7 @@ void swap_buf_le16(u16 *buf, unsigned in
>  /**
>   *	ata_qc_new_init - Request an available ATA command, and initialize it
>   *	@dev: Device from whom we request an available command structure
> + *	@tag: command tag
>   *
>   *	LOCKING:

applied


