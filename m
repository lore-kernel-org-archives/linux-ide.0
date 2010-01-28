From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: fixed section mismatch warning in cmd640.c
Date: Thu, 28 Jan 2010 06:06:12 -0800 (PST)
Message-ID: <20100128.060612.147277319.davem@davemloft.net>
References: <20100126221056.GA19192@foursquare.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39345
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753027Ab0A1OGA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2010 09:06:00 -0500
In-Reply-To: <20100126221056.GA19192@foursquare.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cdfrey@foursquare.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Chris Frey <cdfrey@foursquare.net>
Date: Tue, 26 Jan 2010 17:10:56 -0500

> Signed-off-by: Chris Frey <cdfrey@foursquare.net>

Applied.

In the future please CC: linux-ide@vger.kernel.org on all IDE
patches.

Thanks.

> ---
>  drivers/ide/cmd640.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/cmd640.c b/drivers/ide/cmd640.c
> index 1a32d62..cb11938 100644
> --- a/drivers/ide/cmd640.c
> +++ b/drivers/ide/cmd640.c
> @@ -605,7 +605,7 @@ static void cmd640_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  }
>  #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
>  
> -static void cmd640_init_dev(ide_drive_t *drive)
> +static void __init cmd640_init_dev(ide_drive_t *drive)
>  {
>  	unsigned int i = drive->hwif->channel * 2 + (drive->dn & 1);
>  
> -- 
> 1.6.2.5
> 
