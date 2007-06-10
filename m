From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/6] libata: update protocol numbers
Date: Sat, 09 Jun 2007 22:46:14 -0400
Message-ID: <466B65F6.40708@garzik.org>
References: <4667B767.5060601@tw.ibm.com> <4667B801.3060603@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35910 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbXFJCqQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 22:46:16 -0400
In-Reply-To: <4667B801.3060603@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Albert Lee wrote:
> Patch 1/6:
>  Update the ATA passthru protocol numbers according to the new spec.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> diff -Nrup 00_libata-dev/drivers/ata/libata-scsi.c 01_protocol_update/drivers/ata/libata-scsi.c
> --- 00_libata-dev/drivers/ata/libata-scsi.c	2007-06-01 12:08:21.000000000 +0800
> +++ 01_protocol_update/drivers/ata/libata-scsi.c	2007-06-07 11:38:50.000000000 +0800
> @@ -2512,16 +2512,15 @@ ata_scsi_map_proto(u8 byte1)
>  		case 5:		/* PIO Data-out */
>  			return ATA_PROT_PIO;
>  
> -		case 10:	/* Device Reset */
>  		case 0:		/* Hard Reset */
>  		case 1:		/* SRST */
> -		case 2:		/* Bus Idle */
> -		case 7:		/* Packet */
> -		case 8:		/* DMA Queued */
> -		case 9:		/* Device Diagnostic */
> -		case 11:	/* UDMA Data-in */
> -		case 12:	/* UDMA Data-Out */
> -		case 13:	/* FPDMA */
> +		case 8:		/* Device Diagnostic */
> +		case 9:		/* Device Reset */
> +		case 7:		/* DMA Queued */
> +		case 10:	/* UDMA Data-in */
> +		case 11:	/* UDMA Data-Out */
> +		case 12:	/* FPDMA */
> +		case 15:	/* Return Response Info */
>  		default:	/* Reserved */

Ugh.  Those idiots.  YOUR patch is fine.  But this is clearly an 
incompatible change in the spec.  If we had actually deployed code based 
the spec, we would be up shit creek :/

	Jeff



