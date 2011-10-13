From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: ata_timing_compute() fixup
Date: Thu, 13 Oct 2011 16:56:41 +0100
Message-ID: <20111013165641.0a151cb0@lxorguk.ukuu.org.uk>
References: <201110131517.33197.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55823 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754759Ab1JMP44 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 11:56:56 -0400
In-Reply-To: <201110131517.33197.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Oct 2011 15:17:32 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] libata: ata_timing_compute() fixup
> 
> XFER_SW_DMA_0 mode should be excluded from the extended cycle timing
> computations.

We don't support SWDMA but yes that is a bug

Acked-by: Alan Cox <alan@linux.intel.com>
