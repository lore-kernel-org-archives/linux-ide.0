From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] ide: Fix cs5535 driver accessing beyond array boundary
Date: Thu, 18 Oct 2007 23:10:50 +0200
Message-ID: <200710182310.50315.bzolnier@gmail.com>
References: <20071018005624.DC749DDEAB@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:5764 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761476AbXJRWu3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 18:50:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so285712nfb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 15:50:27 -0700 (PDT)
In-Reply-To: <20071018005624.DC749DDEAB@ozlabs.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, stable@kernel.org

On Thursday 18 October 2007, Benjamin Herrenschmidt wrote:
> The cs5535 use an incorrect construct to access the other drive
> of a pair, causing it to access beyond an array boundary on non-0
> interfaces. This fixes it by using the new ide_get_paired_drive()
> hepler instead.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

applied with patch description fixes

> ---
> 
>  drivers/ide/pci/cs5535.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-work/drivers/ide/pci/cs5535.c
> ===================================================================
> --- linux-work.orig/drivers/ide/pci/cs5535.c	2007-10-18 10:43:39.000000000 +1000
> +++ linux-work/drivers/ide/pci/cs5535.c	2007-10-18 10:44:00.000000000 +1000
> @@ -84,7 +84,7 @@ static void cs5535_set_speed(ide_drive_t
>  
>  	/* Set the PIO timings */
>  	if ((speed & XFER_MODE) == XFER_PIO) {
> -		ide_drive_t *pair = &drive->hwif->drives[drive->dn ^ 1];
> +		ide_drive_t *pair = ide_get_paired_drive(drive);
>  		u8 cmd, pioa;
>  
>  		cmd = pioa = speed - XFER_PIO_0;
