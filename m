From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream 2/2] libata: no need to speed down if already
 at PIO0
Date: Mon, 29 Oct 2007 08:35:41 +0000
Message-ID: <20071029083541.4fe47dae@the-village.bc.nu>
References: <20071029074109.GO11853@htj.dyndns.org>
	<20071029074505.GP11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52022 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752087AbXJ2Idn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 04:33:43 -0400
In-Reply-To: <20071029074505.GP11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, 29 Oct 2007 16:45:05 +0900
Tejun Heo <htejun@gmail.com> wrote:

> After reset, transfer mode is always PIO0 regardless of
> dev->xfer_mask.  Check dev->pio_mode before trying to slow down after
> configuration failure.  This prevents bogus speed down before device
> is actually configured.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <lan@lxorguk.ukuu.org.uk>

Both changesets

Acked-by: Alan Cox <alan@redhat.com>

