From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc7 1/3] libata: clean up horkage handling
Date: Thu, 5 Jul 2007 13:28:47 +0100
Message-ID: <20070705132847.3adebb7b@the-village.bc.nu>
References: <20070705043127.GX29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53178 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758658AbXGEMWc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 08:22:32 -0400
In-Reply-To: <20070705043127.GX29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, 5 Jul 2007 13:31:27 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Horkage handling had the following problems.
> 
> * dev->horkage was positioned after ATA_DEVICE_CLEAR_OFFSET, so it was
>   cleared before the device is configured.  This broke
>   HORKAGE_DIAGNOSTIC.
> 
> * Some used dev->horkage while others called ata_device_blacklisted()
>   directly.  This was at best confusing.
> 
> This patch moves dev->horkage right after dev->flags and set the field
> according to the blacklist during device configuration.  All users
> test against dev->horkage.  ata_device_blacklisted() now has only one
> user, make it static.  While at it, rename it to ata_dev_blacklisted()
> for consistency.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Nice clean up

Acked-by: Alan Cox <alan@redhat.com>
