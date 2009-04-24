From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] Enable parallel scan on ata_piix
Date: Fri, 24 Apr 2009 12:41:02 +0100
Message-ID: <20090424124102.266d27c9@lxorguk.ukuu.org.uk>
References: <20090423214411.515310df@infradead.org>
	<49F19491.2030901@garzik.org>
	<20090424122822.64b143c7@lxorguk.ukuu.org.uk>
	<49F1A39A.3080606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46336 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751822AbZDXLlD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Apr 2009 07:41:03 -0400
In-Reply-To: <49F1A39A.3080606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org

On Fri, 24 Apr 2009 07:33:46 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> >>> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> >> I tend to doubt "safe", given the complicated and buggy silicon state 
> >> machine that recreates the legacy IDE interface on SATA...
> > 
> > The two channels on the ICH and PIIX are independant. There are other
> 
> Starting with ICH5, not true.  Think PATA/SATA combined mode...

The register sets as presented to us are independent, and there are no
interactions on our side. Wecould be extra paranoid about this but
testing says it works, code inspection says it works and there is nothing
in the chip docs or errata saying don't do it.

So at this point I don't think assuming the worst case is actually useful
because its only by trying this that we are going to find out if there
are any corner cases.

Alan
