From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: PATA failure with piix, works with libata
Date: Mon, 6 Mar 2006 15:12:52 +0000
Message-ID: <20060306151251.GA11678@srcf.ucam.org>
References: <20060303183937.GA30840@srcf.ucam.org> <1141481507.10341.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:15778 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751423AbWCFPM5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Mar 2006 10:12:57 -0500
Content-Disposition: inline
In-Reply-To: <1141481507.10341.1.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 02:11:46PM +0000, Alan Cox wrote:

> Make sure the IRQ is setup properly. Legacy mode IRQs are level
> triggered which might fit this description.

It's a shared PCI interrupt, so yeah, it's level. As I mentioned to 
Jeff, explicitly writing back the DMA status register while 
acknowledging interrupts works (and is what ata_piix does in PATA mode)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
