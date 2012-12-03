From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: set dma_mode to 0xff in reset
Date: Mon, 3 Dec 2012 09:43:40 +0000
Message-ID: <20121203094340.649e29ef@pyramind.ukuu.org.uk>
References: <50BBFA94.2070105@intel.com>
	<50BC1DE6.7080008@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50061 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab2LCJiv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 04:38:51 -0500
In-Reply-To: <50BC1DE6.7080008@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Borislav Petkov <bp@alien8.de>, Dutra Julio <dutra.julio@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, Tejun Heo <tj@kernel.org>, Szymon Janc <szymon@janc.net.pl>, Bernd Buschinski <b.buschinski@googlemail.com>, linux-ide@vger.kernel.org

On Mon, 03 Dec 2012 11:35:02 +0800
Aaron Lu <aaron.lu@intel.com> wrote:

> 
> ata_device->dma_mode's initial value is zero, which is not a valid dma
> mode, but ata_dma_enabled will return true for this value. This patch
> sets dma_mode to 0xff in reset function, so that ata_dma_enabled will
> not return true for this case, or it will cause problem for pata_acpi.
> 
> The corrsponding bugzilla page is at:
> https://bugzilla.kernel.org/show_bug.cgi?id=49151
> 
> Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Acked-by: Alan Cox <alan@linux.intel.com>
