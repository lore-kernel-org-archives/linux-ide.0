From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add ATAPI module option
Date: Tue, 30 Aug 2005 19:54:48 -0400
Message-ID: <4314F1C8.8040706@rtr.ca>
References: <20050830215234.GA6991@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932288AbVH3Xy5@vger.kernel.org>
In-Reply-To: <20050830215234.GA6991@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
> -#ifndef ATA_ENABLE_ATAPI
> -	if (unlikely(dev->class == ATA_DEV_ATAPI))
> -		return NULL;
> -#endif
> +	if (atapi_enabled) {
> +		if (unlikely(dev->class == ATA_DEV_ATAPI))
> +			return NULL;
> +	}
..

Is that if-stmt the right way around?
At first glance, I'd expect it to read:

      if (!atapi_enabled) {
      ...

Cheers!
