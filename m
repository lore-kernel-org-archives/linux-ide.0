From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/15] ATA : vortex86 : fix vortex86dx/sx hardware CRC
 bug.
Date: Thu, 3 Nov 2011 23:19:04 +0000
Message-ID: <20111103231904.11767480@lxorguk.ukuu.org.uk>
References: <1319602564-19162-1-git-send-email-paul.s.schilling@gmail.com>
	<20111027084310.2b7da753@pyx>
	<CAC=G6sz=PkDoODYh4beT_eRhkm+ZhUxtLnrBXPPuFJW3n+6Vcg@mail.gmail.com>
	<20111101010242.003738e9@lxorguk.ukuu.org.uk>
	<CAC=G6sxZ10ben3R5X2aKGi6q3a68+c0CO+mG=+kUeUvKoRbOJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56029 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598Ab1KCXSZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Nov 2011 19:18:25 -0400
In-Reply-To: <CAC=G6sxZ10ben3R5X2aKGi6q3a68+c0CO+mG=+kUeUvKoRbOJg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Schilling <paul.s.schilling@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

> [   33.822836] ata2: lost interrupt (Status 0x58)
> [   33.824367] ata2: drained 2048 bytes to clear DRQ

So you have a different problem - your IRQ delivery appears to be broken.

