From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/1] ide: memory overrun in ide_get_identity_ioctl() on big endian machines using ioctl HDIO_OBSOLETE_IDENTITY
Date: Mon, 22 Jun 2009 11:49:14 +0200
Message-ID: <200906221149.15575.bzolnier@gmail.com>
References: <20090619084105.4cdf78be@frequentis.com> <20090621000423.30c462d9@frequentis.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:43832 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbZFVLnN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 07:43:13 -0400
Received: by bwz9 with SMTP id 9so3050809bwz.37
        for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2009 04:43:15 -0700 (PDT)
In-Reply-To: <20090621000423.30c462d9@frequentis.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Engelmayer <christian.engelmayer@frequentis.com>, David Miller <davem@davemloft.net>
Cc: hancockrwd@gmail.com, linux-ide@vger.kernel.org

On Sunday 21 June 2009 00:04:23 Christian Engelmayer wrote:
> From: Christian Engelmayer <christian.engelmayer@frequentis.com>
> 
> This patch fixes a memory overrun in function ide_get_identity_ioctl() which
> chooses the size of a memory buffer depending on the ioctl command that led
> to the function call, however, passes that buffer to a function which needs the
> buffer size to be always chosen unconditionally.
> 
> Due to conditional compilation the memory overrun can only happen on big endian
> machines. The error can be triggered using ioctl HDIO_OBSOLETE_IDENTITY. Usage
> of ioctl HDIO_GET_IDENTITY is safe.
> 
> Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> --
> Proposed patch after comment by Robert Hancock who shares the view that buffer
> 'id' should be allocated unconditionally.
> 
> --- drivers/ide/ide-ioctls.c.orig	2009-06-20 23:22:45.000000000 +0200
> +++ drivers/ide/ide-ioctls.c	2009-06-20 23:30:21.000000000 +0200
> @@ -64,7 +64,8 @@ static int ide_get_identity_ioctl(ide_dr
>  		goto out;
>  	}
>  
> -	id = kmalloc(size, GFP_KERNEL);
> +	/* ata_id_to_hd_driveid() relies on 'id' to be fully allocated. */
> +	id = kmalloc(ATA_ID_WORDS * 2, GFP_KERNEL);
>  	if (id == NULL) {
>  		rc = -ENOMEM;
>  		goto out;
