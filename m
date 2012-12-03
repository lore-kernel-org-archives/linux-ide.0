From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix ata_dma_enabled
Date: Mon, 3 Dec 2012 01:22:25 +0000
Message-ID: <20121203012225.00e0c121@pyramind.ukuu.org.uk>
References: <50BBFA94.2070105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49730 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab2LCBRf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2012 20:17:35 -0500
In-Reply-To: <50BBFA94.2070105@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Borislav Petkov <bp@alien8.de>, Dutra Julio <dutra.julio@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, Tejun Heo <tj@kernel.org>, Szymon Janc <szymon@janc.net.pl>, Bernd Buschinski <b.buschinski@googlemail.com>, linux-ide@vger.kernel.org

On Mon, 03 Dec 2012 09:04:20 +0800
Aaron Lu <aaron.lu@intel.com> wrote:

> 
> ata_dma_enabled should check if device is either using multi word DMA
> or ultra DMA instead of checking 0xff, as dma_mode 0 is not a valid dma
> mode either.
> 
> This patch fixes the following bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=49151

NAK

dma_mode should *NEVER* be zero. If it's getting set to zero you have
another bug and that needs fixing instead

Alan
