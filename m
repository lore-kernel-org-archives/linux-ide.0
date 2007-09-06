From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 5/13] ide: add IDE_HFLAG_ERROR_STOPS_FIFO host flag
Date: Thu, 6 Sep 2007 04:13:56 -0400
Message-ID: <20070906081356.GA20007@havoc.gtf.org>
References: <200709052352.57848.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:46358 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161AbXIFIN5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Sep 2007 04:13:57 -0400
Content-Disposition: inline
In-Reply-To: <200709052352.57848.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, Sep 05, 2007 at 11:52:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Add IDE_HFLAG_ERROR_STOPS_FIFO host flag and use it instead
> of hwif->err_stops_fifo.  As a side-effect this change fixes
> hwif->err_stops_fifo not being restored by ide_hwif_restore().
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-io.c           |    3 ++-
>  drivers/ide/pci/pdc202xx_new.c |    3 +--
>  drivers/ide/pci/pdc202xx_old.c |    8 ++++----
>  include/linux/ide.h            |    3 ++-
>  4 files changed, 9 insertions(+), 8 deletions(-)

Hum, I wonder if libata needs something like this.

	Jeff



