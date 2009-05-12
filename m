From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Tue, 12 May 2009 09:06:02 +0100
Message-ID: <20090512090602.65722342@lxorguk.ukuu.org.uk>
References: <20090511222702.352192505@arndb.de>
	<200905112238.55404.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42668 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752934AbZELIFS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 04:05:18 -0400
In-Reply-To: <200905112238.55404.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, 11 May 2009 22:38:55 +0000
Arnd Bergmann <arnd@arndb.de> wrote:

> libata uses the DMA mapping API, so it cannot be built
> on architectures that don't have DMA support.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nakked-by: Alan Cox <alan@linux.intel.com>

Almost every PATA adapter can fall back to PIO, many are PIO only. We
need a rather cleaner way to sort this.
