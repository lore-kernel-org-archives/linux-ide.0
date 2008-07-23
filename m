From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Wed, 23 Jul 2008 20:13:49 +0100
Message-ID: <20080723201349.33226d58@lxorguk.ukuu.org.uk>
References: <20080723144226.807475493@fluff.org>
	<20080723144227.253944199@fluff.org>
	<20080723163216.7477be06@lxorguk.ukuu.org.uk>
	<20080723190433.GB26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41000 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752648AbYGWTbP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 15:31:15 -0400
In-Reply-To: <20080723190433.GB26938@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org

> Ok, however the drivers/ide/pci/alim15x3.c still works fine
> on this board, so there's something that something in the libata
> driver path not working properly. Possibly drivers/ata/pata_ali.c
> that is missing something

The old driver makes some rather iffy assumptions when dev->irq == 0 in
part because the old IDE code predates PCI quirks.
