From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Mon, 04 Oct 2004 11:33:56 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096853636.23141.68.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <200410032254.16900.bzolnier@elka.pw.edu.pl>
	 <1096846969.9516.39.camel@gaston>
	 <200410040227.14513.bzolnier@elka.pw.edu.pl>
	 <1096851939.9516.53.camel@gaston> <4160A6EE.1010804@pobox.com>
	 <1096853212.12123.64.camel@gaston>  <20041004013305.GA29791@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:1476 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268306AbUJDBil (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2004 21:38:41 -0400
In-Reply-To: <20041004013305.GA29791@havoc.gtf.org>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, linux-ide@vger.kernel.org

On Mon, 2004-10-04 at 11:33, Jeff Garzik wrote:
> On Mon, Oct 04, 2004 at 11:26:53AM +1000, Benjamin Herrenschmidt wrote:
> > Also, my proposal beeing sort-of "agnostic" to the IDE layer (only
> > pdev and channel arguments), it could be useable by libata too :)
> 
> Will, given that perspective, I wouldn't mind a pci_get_ide_irq()
> in the PCI layer...  platforms that do not provide can easily return an
> error code unconditionally.

Yup. Good idea.

I'd still call it pci_get_ide_legacy_irq() though as it's really
specific to controllers that are left in "legacy" mode. Controllers
in "fully native" mode use the normal PCI irq routing.

An negative error code vs. a positive irq number looks good ? Or can
irq numbers be legally negative on some platforms ? I'd rather have
it return NO_IRQ in fact if the platform can't help ;) Actually, in
80% of the cases, those numbers will be 14 and 15, so it could even
have a default implementation returning those....

I'll do a patch proposal either later today or tomorrow.
 
Ben.


