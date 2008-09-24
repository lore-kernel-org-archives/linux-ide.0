From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-core.c
Date: Wed, 24 Sep 2008 23:24:49 +0100
Message-ID: <20080924232449.299b5158@lxorguk.ukuu.org.uk>
References: <679aeaf0809241511yf6cd812oa1ed5f3a1a37cfba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47799 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752047AbYIXWZT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 18:25:19 -0400
In-Reply-To: <679aeaf0809241511yf6cd812oa1ed5f3a1a37cfba@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kiran vedere <vederekiran@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> 1. Is this library generic for all platforms or is it specific to PC
> because it seems to reference PCI in some places. If I have my host
> controller driver, is the current pata_pcmcia.c (and libata helper
> libraries) sufficient to use the Compact Flash in True-IDE mode or
> something additional is needed.

libata is generic.

> 2. The CF TrueIDE mode supports Multiword DMA and Ultra DMA modes of
> data transfer. Your libata-core.c seems to have support for these
> modes. However I assume I will need to provide the DMA Buffer to
> facilitate this. Do I need to provide call back functions to do this
> or I need to implement a seperate Client Driver to support these
> modes? I assume the pata_pcmcia.c uses PIO mode by default? Correct me
> if I am wrong.

If you are in trueide mode the device behaves as an IDE disk, so you will
need a driver for whatever ATA controller is being used.

If you are in PCMCIA mode then you only get PIO0 and the pata_pcmcia
driver drives the CF card with the CF card acting as a PCMCIA ATA
controller

Alan
