From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Mon, 2 Mar 2009 15:50:45 +0100
Message-ID: <200903021550.45608.bzolnier@gmail.com>
References: <49ABEAC0.40407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:40652 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbZCBO4r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 09:56:47 -0500
Received: by fg-out-1718.google.com with SMTP id 16so952212fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2009 06:56:44 -0800 (PST)
In-Reply-To: <49ABEAC0.40407@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday 02 March 2009, Roel Kluin wrote:
> vi drivers/ide/ide-io.c +906 and note:
> 
> void ide_timer_expiry (unsigned long data)
> {
> 	ide_expiry_t *expiry = hwif->expiry;
> 	...
> 	unsigned long   wait = -1;
> 		...
> 		if (expiry) {
> 			...
> 			wait = expiry(drive);
> 			if (wait > 0) { /* continue */
> 
> also note that in include/linux/ide.h:883:
> 
> typedef int (ide_expiry_t)(ide_drive_t *);
> 
> doesn't this mean that expiry returns int, and wait therefore should
> be int as well?

It does... and it seems like it could cause insanely long timeouts for:

* ATA_DMA_ERR error in dma_timer_expiry()

* commands without ->expiry in tc86c001_timer_expiry()
  (TC86C001 IDE controller only)

This is 2.6.29 material, care to make a patch?

Thanks,
Bart
