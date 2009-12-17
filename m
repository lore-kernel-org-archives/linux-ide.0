From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata: use the WRITE_SAME_16 define
Date: Thu, 17 Dec 2009 01:03:19 -0500
Message-ID: <4B29C9A7.6000009@pobox.com>
References: <20091210093601.GA30917@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:44510 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbZLQGDX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:03:23 -0500
Received: by ywh12 with SMTP id 12so1984917ywh.21
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:03:21 -0800 (PST)
In-Reply-To: <20091210093601.GA30917@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

On 12/10/2009 04:36 AM, Christoph Hellwig wrote:
> Now that the scsi tree has hit mainline we can use the newly added WRITE_SAME_16
> define.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
>
> Index: linux-2.6/drivers/ata/libata-scsi.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/libata-scsi.c	2009-12-10 10:21:05.735254334 +0100
> +++ linux-2.6/drivers/ata/libata-scsi.c	2009-12-10 10:21:29.562255983 +0100
> @@ -3022,7 +3022,7 @@ static inline ata_xlat_func_t ata_get_xl
>   	case WRITE_16:
>   		return ata_scsi_rw_xlat;
>
> -	case 0x93 /*WRITE_SAME_16*/:
> +	case WRITE_SAME_16:
>   		return ata_scsi_write_same_xlat;

applied


