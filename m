From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] libata: Read buffer overflow
Date: Mon, 03 Aug 2009 09:37:14 -0500
Message-ID: <1249310234.3943.13.camel@mulgrave.site>
References: <4A76CA64.60802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56784 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932138AbZHCOhS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2009 10:37:18 -0400
In-Reply-To: <4A76CA64.60802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Mon, 2009-08-03 at 13:30 +0200, Roel Kluin wrote:
> Check whether index is within bounds before grabbing the element.

This isn't a correct description or analysis.

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 2bc2dbe..f88c2ff 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -294,10 +294,11 @@ mpc52xx_ata_compute_mdma_timings(struct mpc52xx_ata_priv *priv, int dev,
>  				 int speed)
>  {
>  	struct mpc52xx_ata_timings *t = &priv->timings[dev];
> -	const struct mdmaspec *s = &priv->mdmaspec[speed];

This is a *pointer* to the element, *not* a dereference.  It's
irrelevant whether the pointer is off the end of the array or not

> +	const struct mdmaspec *s;
>  
>  	if (speed < 0 || speed > 2)
>  		return -EINVAL;

And since the check is immediately after, the pointer is never
dereferenced.

> +	s = &priv->mdmaspec[speed];

James


