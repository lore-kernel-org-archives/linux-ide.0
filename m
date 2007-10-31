From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Wed, 31 Oct 2007 16:29:22 +0000
Message-ID: <20071031162922.0f9f74f2@the-village.bc.nu>
References: <47274A5F.6070409@gentoo.org>
	<20071030153417.59b9182c@the-village.bc.nu>
	<47276DCA.1000808@gentoo.org>
	<20071030190153.373c9347@the-village.bc.nu>
	<47278439.4030801@gentoo.org>
	<20071031114958.210bd7cc@the-village.bc.nu>
	<20071031115754.GK5059@kernel.dk>
	<472872F6.70802@garzik.org>
	<20071031122639.GN5059@kernel.dk>
	<4728A7D4.8050008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760373AbXJaQ2r@vger.kernel.org>
In-Reply-To: <4728A7D4.8050008@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Daniel Drake <dsd@gentoo.org>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> If this is NOT a privileged app, we must update the command validation 
> to ensure that invalid commands are not transported to the hardware.

We allow only a subset of standard commands to be issued by unprivileged
applications. We don't strictly enforce transfer sizes and its arguable
on SCSI transports this doesn't matter one iota. On ATA it perhaps
matters a bit more.

Note btw - the reset sequence cased by excess data off these drives is
something we jump up and down and trigger. For PIO draining the bits is
fine, for DMA pretty much all controllers will clean up happily enough.

Its also nothing like the problem you might think as most drives told
"send me 150 bytes, oh and the transfer length is 40" will in fact send
40. 

Alan
