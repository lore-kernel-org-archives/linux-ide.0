From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_it821x: (partially) fix DMA in RAID mode
Date: Wed, 20 Jun 2007 19:56:50 -0400
Message-ID: <4679BEC2.5040007@garzik.org>
References: <200706111140.08048.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45875 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756954AbXFTX4x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 19:56:53 -0400
In-Reply-To: <200706111140.08048.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Code intended to check DMA status was checking DMA command register.
> 
> Moreover firmware seems to "forget" to set DMA capable bit for the
> slave device (at least in RAID mode but without ITE RAID volumes) so
> check device ID for DMA capable bit when deciding whether to use DMA
> and remove DMA status check completely.
> 
> Thanks to Pavol Simo for the bugreport and testing the initial fix.
> 
> This change unfortunately still doesn't fix DMA in RAID mode (which
> works fine with IDE it821x) but Alan is working on the missing pieces
> (pata_it821x vs libata EH issues).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Acked-by: Alan Cox <alan@redhat.com>
> Cc: Tejun Heo <htejun@gmail.com>
> ---
> removed non-ASCII char from the patch description + added Alan's ACK
> 
>  drivers/ata/pata_it821x.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

applied


