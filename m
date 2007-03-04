From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][libata] pata_pdc202xx_old: fix data corruption and
 other problems
Date: Sun, 4 Mar 2007 22:00:46 +0000
Message-ID: <20070304220046.44ccd7b0@lxorguk.ukuu.org.uk>
References: <200703040158.43471.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46028 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750755AbXCDU4j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 15:56:39 -0500
In-Reply-To: <200703040158.43471.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 4 Mar 2007 01:58:43 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
> [PATCH] pata_pdc202xx_old: fix data corruption and other problems
> 
> Fix wrong "port" calculations in pdc202xx_configure_piomode()
> and pdc202xx_set_dmamode(), it was horribly broken which resulted
> in major havoc on all configurations except one (master device on
> primary channel, no other devices) as code was writing PIO/DMA
> timings and device settings to wrong registers (including
> reserved ones),

Thanks

Acked-by: Alan Cox <alan@redhat.com>

