From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Mon, 16 Nov 2009 22:18:08 -0500
Message-ID: <4B0215F0.8050105@pobox.com>
References: <4AFCC0D4.9020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50955 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbZKQDSE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 22:18:04 -0500
In-Reply-To: <4AFCC0D4.9020708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>

On 11/12/2009 09:13 PM, Robert Hancock wrote:
> Remove the experimental tag on Parallel ATA drivers. Though some of the
> individual PATA drivers are still marked as experimental, as a group they can
> hardly be considered to be, given they've been used in various distros for some
> time.
>
> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index f2df6e2..33133c6 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -3,7 +3,7 @@
>   #
>
>   menuconfig ATA
> -	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
> +	tristate "Serial ATA and Parallel ATA drivers"
>   	depends on HAS_IOMEM
>   	depends on BLOCK

applied


