From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Should sata_mv work with Highpoint RocketRAID 2300?
Date: Tue, 14 Aug 2007 18:43:01 +0100
Message-ID: <20070814184301.3201d162@the-village.bc.nu>
References: <46C1DCBB.9020308@double-you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54882 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752381AbXHNRfW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 13:35:22 -0400
In-Reply-To: <46C1DCBB.9020308@double-you.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karim 'Kasi Mir' Senoucci <ks@double-you.de>
Cc: linux-ide@vger.kernel.org

On Tue, 14 Aug 2007 18:47:55 +0200
"Karim 'Kasi Mir' Senoucci" <ks@double-you.de> wrote:

> Hello all,
> sorry if this it too dumb a question, but since I haven't gotten any 
> results with the sata_mv driver (kernel 2.6.22.2), I was wondering if 
> the Highpoint RocketRaid 2300 controller - which features a Marvell chip 
> - is even supposed to work with sata_mv.

It should but the vendor issued the chip with different PCI identifiers
to a normal Marvell chip. Add it to the sata_mv driver and it should work.

