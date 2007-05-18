From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 17 May 2007 21:00:14 -0400
Message-ID: <464CFA9E.40004@garzik.org>
References: <20070516002204.B4AF6DDEC2@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43762 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757892AbXERBAQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 May 2007 21:00:16 -0400
In-Reply-To: <20070516002204.B4AF6DDEC2@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

Benjamin Herrenschmidt wrote:
> This patch adds MMIO support to the pata_sil680 for taskfile IOs,
> based on what the old siimage does.
> 
> I haven't bothered changing the chip setup stuff from PCI config
> cycles to MMIO though (siimage does it), I don't think it matters,
> I've only adapted it to use MMIO for taskfile accesses.
> 
> I've tested it on a Cell blade and it seems to work fine.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This version uses a better name "use_ioports" for the fallback
> label in the probe code.
> 
>  drivers/ata/pata_sil680.c |   70 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 62 insertions(+), 8 deletions(-)

applied to #upstream (queued for 2.6.23)


