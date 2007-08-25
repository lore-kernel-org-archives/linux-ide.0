From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] Ata: pata_marvell, use ioread* for iomap-ped memory
Date: Sat, 25 Aug 2007 11:02:44 +0100
Message-ID: <20070825110244.794c8fd6@the-village.bc.nu>
References: <14077223792606026025@pripojeni.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59275 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765493AbXHYJyv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Aug 2007 05:54:51 -0400
In-Reply-To: <14077223792606026025@pripojeni.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Sat, 25 Aug 2007 08:54:27 +0100
Jiri Slaby <jirislaby@gmail.com> wrote:

> pata_marvell, use ioread* for iomap-ped memory
> 
> read* on pci_iomapped memory is incorrect, fix it
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

Acked-by: Alan Cox <alan@redhat.com>
