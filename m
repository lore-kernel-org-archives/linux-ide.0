From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: RE: [PATCH 6/7] sata_mv: endian fix
Date: Mon, 22 May 2006 11:51:24 +0800
Message-ID: <9FCDBA58F226D911B202000BDBAD467306382A72@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:52216 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751162AbWEVDv3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 May 2006 23:51:29 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k4M47de8015279
	for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 21:07:39 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net [10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4M3pQuT018059
	for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 22:51:27 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> This fixes a byte-swap issue on PPC, found by Zang Roy-r61911
> on the powerpc platform.  His original patch also had some other
> platform-specific changes in #ifdef's, but I'm not sure yet how to
> incorporate them.  Look for another patch for those (soon).
> 
> Signed-off-by: Mark Lord <liml@rtr.ca>
> 
> ---
> --- linux/drivers/scsi/sata_mv.c	2006-05-19 
> 15:44:11.000000000 -0400
> +++ linux/drivers/scsi/sata_mv.c	2006-05-19 
> 15:58:21.000000000 -0400
> @@ -1030,8 +1030,9 @@
>  
>  static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 
> addr, unsigned last)
>  {
> -	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
> +	u16 tmp = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>  		(last ? CRQB_CMD_LAST : 0);
> +	*cmdw = cpu_to_le16(tmp);
>  }
>  
>  /**
> 


Does this patch will affect other platform except powerpc?

Roy
