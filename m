From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Mon, 4 Oct 2004 23:21:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410042321.54530.bzolnier@elka.pw.edu.pl>
References: <1096602694.11460.29.camel@gaston> <20041004013305.GA29791@havoc.gtf.org> <1096853636.23141.68.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:13744 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268588AbUJDVV0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2004 17:21:26 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:40799 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S50562AbUJDVVY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2004 23:21:24 +0200
Received: from chello062179088136.chello.pl ([62.179.88.136]:65019 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S57807AbUJDVTo (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 2 others);
	Mon, 4 Oct 2004 23:19:44 +0200
In-Reply-To: <1096853636.23141.68.camel@gaston>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Monday 04 October 2004 03:33, Benjamin Herrenschmidt wrote:
> On Mon, 2004-10-04 at 11:33, Jeff Garzik wrote:
> > On Mon, Oct 04, 2004 at 11:26:53AM +1000, Benjamin Herrenschmidt wrote:
> > > Also, my proposal beeing sort-of "agnostic" to the IDE layer (only
> > > pdev and channel arguments), it could be useable by libata too :)
> > 
> > Will, given that perspective, I wouldn't mind a pci_get_ide_irq()
> > in the PCI layer...  platforms that do not provide can easily return an
> > error code unconditionally.
> 
> Yup. Good idea.
> 
> I'd still call it pci_get_ide_legacy_irq() though as it's really
> specific to controllers that are left in "legacy" mode. Controllers
> in "fully native" mode use the normal PCI irq routing.

What about controllers in "half native" mode
(legacy IRQs but native addressing)?

> An negative error code vs. a positive irq number looks good ? Or can
> irq numbers be legally negative on some platforms ? I'd rather have
> it return NO_IRQ in fact if the platform can't help ;) Actually, in
> 80% of the cases, those numbers will be 14 and 15, so it could even
> have a default implementation returning those....

Your proposal sounds fine but I worry that instead of crappy #ifdefs
it will end up having crappy switch (dev->device) statements.

> I'll do a patch proposal either later today or tomorrow.

OK.
