From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/14] sata_mv Use hqtag instead of ioid
Date: Fri, 25 Jan 2008 23:19:31 -0500
Message-ID: <479AB4D3.6010805@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FC87.3080102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39457 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbYAZETd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:19:33 -0500
In-Reply-To: <4798FC87.3080102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv Use hqtag instead of ioid.
> 
> Simplify tag handling by using the cid/hqtag field instead of ioid,
> as recommended by Marvell.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2008-01-24 12:07:16.000000000 -0500
> +++ new/drivers/ata/sata_mv.c    2008-01-24 12:35:14.000000000 -0500
> @@ -132,15 +132,12 @@
> 
>     CRQB_FLAG_READ        = (1 << 0),
>     CRQB_TAG_SHIFT        = 1,
> -    CRQB_IOID_SHIFT        = 6,    /* CRQB Gen-II/IIE IO Id shift */
>     CRQB_HOSTQ_SHIFT    = 17,    /* CRQB Gen-II/IIE HostQueTag shift */
>     CRQB_CMD_ADDR_SHIFT    = 8,
>     CRQB_CMD_CS        = (0x2 << 11),
>     CRQB_CMD_LAST        = (1 << 15),
> 
>     CRPB_FLAG_STATUS_SHIFT    = 8,
> -    CRPB_IOID_SHIFT_6    = 5,    /* CRPB Gen-II IO Id shift */
> -    CRPB_IOID_SHIFT_7    = 7,    /* CRPB Gen-IIE IO Id shift */
> 
>     EPRD_FLAG_END_OF_TBL    = (1 << 31),
> 

don't delete details of otherwise undocumented [publicly] hardware

everything else OK


