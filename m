From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] hpt366: UltraDMA filter for SATA cards (take 2)
Date: Tue, 21 Aug 2007 22:36:10 +0200
Message-ID: <200708212236.10803.bzolnier@gmail.com>
References: <200708192300.35564.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:40889 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbXHUUkk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 16:40:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so970232nfb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 13:40:40 -0700 (PDT)
In-Reply-To: <200708192300.35564.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 19 August 2007, Sergei Shtylyov wrote:
> The Marvell bridge chips used on HighPoint SATA cards do not seem to support
> the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes, so the driver needs
> to account for this in the udma_filter() method.  In order to achieve that, do
> the following changes:
> 
> - install the method for all chips, not only HPT36x/370 and impove the code
>   formatting by killing the extra tabs while at it;

s/impove/improve/

> - add to the end of the 'switch' statement in the method cases for HPT372[AN]
>   and HPT374 chips upon which the known SATA cards are based;
> 
> - use hwif->ultra_mask as a default mask for the ide_dma_filter() method to
>   behave correctly;
> 
> - move the HPT370[A] cases below the HPT36x case for consistency.
> 
> While at it, replace the explicit UltraDMA mode masks with ATA_UDMA* constants
> all over the driver...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

> ---
> This is against the current Linus tree and unfortunately I was able to only
> compile test it since that tree gives MODPOST warning and dies early on bootup.

Is this still case?  Not an IDE problem but definitely needs fixing especially
given that we are already in -rc3...

> Will hopefully finish with the patch series next weekend...
