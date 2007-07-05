From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc7 2/3] libata: implement HORKAGE_SETXFER
Date: Thu, 5 Jul 2007 13:38:23 +0100
Message-ID: <20070705133823.14c2e00c@the-village.bc.nu>
References: <20070705043127.GX29122@htj.dyndns.org>
	<20070705043501.GY29122@htj.dyndns.org>
	<20070705132706.743d18d8@the-village.bc.nu>
	<468CE294.2080705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44482 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757080AbXGEMcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 08:32:05 -0400
In-Reply-To: <468CE294.2080705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, 05 Jul 2007 21:22:44 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Alan Cox wrote:
> > On Thu, 5 Jul 2007 13:35:01 +0900
> > Tejun Heo <htejun@gmail.com> wrote:
> > 
> >> Make CFA SETXFER failure handling into HORKAGE.  This will be used to
> >> allow other cases to ignore SETXFER failure.
> > 
> > NAK
> > 
> >> +			/* Old CFA may refuse SETFEATURES_XFER, which
> >> +			 * is just fine
> >> +			 */
> >> +			if (!(xfer_mask & ~ATA_MASK_PIO))
> >> +				dev->horkage |= ATA_HORKAGE_SETXFER;
> >> +		} else
> > 
> > This is specifically done for PIO. An XFER failure for non PIO modes is a
> > serious failure and happens in the real world sometimes.
> 
> Hmmm... That's what "if (!(xfer_mask & ~ATA_MASK_PIO))" test was for.
> Or is it not enough?

Actually you are correct the test is sufficient because we can't end up
adding modes later.

Un-NAK ;)

Alan
