From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_cmd64x: fix overclocking of UDMA0-2 modes
Date: Sun, 20 Dec 2009 15:46:01 -0500
Message-ID: <4B2E8D09.4060705@garzik.org>
References: <200912201922.33210.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:53449 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbZLTUqI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2009 15:46:08 -0500
In-Reply-To: <200912201922.33210.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

On 12/20/2009 01:22 PM, Bartlomiej Zolnierkiewicz wrote:
>
> adev->dma_mode stores the transfer mode value not UDMA mode number
> so the condition in cmd64x_set_dmamode() is always true and the higher
> UDMA clock is always selected.  This can potentially result in data
> corruption when UDMA33 device is used, when 40-wire cable is used or
> when the error recovery code decides to lower the device speed down.
>
> The issue was introduced in the commit 6a40da0 ("libata cmd64x: whack
> into a shape that looks like the documentation") which goes back to
> kernel 2.6.20.
>
> Cc: stable@kernel.org
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
> it is patch #116 in my local working queue but I thought it would
> be nice to get it upstream ahead of other patches..
>
>   drivers/ata/pata_cmd64x.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied


