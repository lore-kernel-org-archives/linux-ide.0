From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Prevent IDE boot ops on NUMA system in mainline
Date: Mon, 11 Feb 2008 20:26:26 +0100
Message-ID: <200802112026.27677.bzolnier@gmail.com>
References: <20080211003520.GA32082@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:57884 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709AbYBKTWY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 14:22:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so354314ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 11:22:21 -0800 (PST)
In-Reply-To: <20080211003520.GA32082@basil.nowhere.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 11 February 2008, Andi Kleen wrote:
> 
> Without this patch a Opteron test system here oopses at boot with currentg git. 
> 
> Calling to_pci_dev() on a NULL pointer gives a negative value so the following NULL 
> pointer check never triggers and then an illegal address is referenced. Check the 
> unadjusted original device pointer for NULL instead.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>

Thanks Andi!

This may explain+resolve ide_generic OOPS-es reported by Pavel/Kamalesh/Nish.

[ I also see that Linus has already merged the patch and you've followed
  up on pcibus_to_node() issue so there is nothing left for me to do...

  I really love when things turn out like this... ;) ]

> Index: linux/include/linux/ide.h
> ===================================================================
> --- linux.orig/include/linux/ide.h
> +++ linux/include/linux/ide.h
> @@ -1294,7 +1294,7 @@ static inline void ide_dump_identify(u8 
>  static inline int hwif_to_node(ide_hwif_t *hwif)
>  {
>  	struct pci_dev *dev = to_pci_dev(hwif->dev);
> -	return dev ? pcibus_to_node(dev->bus) : -1;
> +	return hwif->dev ? pcibus_to_node(dev->bus) : -1;
>  }
>  
>  static inline ide_drive_t *ide_get_paired_drive(ide_drive_t *drive)
