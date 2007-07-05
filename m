From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc7 2/3] libata: implement HORKAGE_SETXFER
Date: Thu, 5 Jul 2007 13:27:06 +0100
Message-ID: <20070705132706.743d18d8@the-village.bc.nu>
References: <20070705043127.GX29122@htj.dyndns.org>
	<20070705043501.GY29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53174 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754304AbXGEMUz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 08:20:55 -0400
In-Reply-To: <20070705043501.GY29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, 5 Jul 2007 13:35:01 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Make CFA SETXFER failure handling into HORKAGE.  This will be used to
> allow other cases to ignore SETXFER failure.

NAK

> +			/* Old CFA may refuse SETFEATURES_XFER, which
> +			 * is just fine
> +			 */
> +			if (!(xfer_mask & ~ATA_MASK_PIO))
> +				dev->horkage |= ATA_HORKAGE_SETXFER;
> +		} else

This is specifically done for PIO. An XFER failure for non PIO modes is a
serious failure and happens in the real world sometimes.

> -	/* Old CFA may refuse this command, which is just fine */
> -	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
> +
> +	if (dev->horkage & ATA_HORKAGE_SETXFER)
>          	err_mask &= ~AC_ERR_DEV;

