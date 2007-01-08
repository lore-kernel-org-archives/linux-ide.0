From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.20-rc3-mm1 1/2] libata: SiS 180 pata/sata support
Date: Mon, 8 Jan 2007 10:26:05 +0000
Message-ID: <20070108102605.3404df8f@localhost.localdomain>
References: <200701080017.l080H7xq000764@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43491 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161210AbXAHKPp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2007 05:15:45 -0500
In-Reply-To: <200701080017.l080H7xq000764@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Sven Ladegast <sven@linux4geeks.de>

On Mon, 8 Jan 2007 02:01:28 +0100
Uwe Koziolek <uwe.koziolek@gmx.net> wrote:

> the SiS180 is a combined PATA/SATA controller. The SiS 180 is handled
> by the sata_sis driver. The PATA support for this controller is exported
> by pata_sis and imported by sata_sis.
> 
> the pata133 sis controllers does not support a drive present status
> in the pci configspace like the older sis controllers, check removed.
> 
> unnecessary zero record in pci_bits removed.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

Acked-by: Alan Cox <alan@redhat.com>
