From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: skip 0xff polling for PATA
 controllers
Date: Thu, 8 Nov 2007 10:53:43 +0000
Message-ID: <20071108105343.3edfd36c@the-village.bc.nu>
References: <47327262.9020004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46909 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758467AbXKHKxa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 05:53:30 -0500
In-Reply-To: <47327262.9020004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Luca Tettamanti <kronos.it@gmail.com>

On Thu, 08 Nov 2007 11:20:18 +0900
Tejun Heo <htejun@gmail.com> wrote:

> In a presentation of true workmanship, pata_ali asserts IRQ
> permanantly if the TF status register is read more than once when
> there's no device attached to the port.
> 
> Avoid waiting polling for !0xff if it's PATA.  It's needed only for
> some rare SATA devices anyway.
> 
> This problem is reported by Luca Tettamanti in bugzilla bug 9298.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Tested-By: Luca Tettamanti <kronos.it@gmail.com>
> ---
>  drivers/ata/libata-core.c |   16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Bletch.. 8)

Acked-by: Alan Cox <alan@redhat.com>

