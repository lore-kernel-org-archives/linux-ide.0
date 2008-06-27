From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata and DMA quirks
Date: Fri, 27 Jun 2008 19:29:43 +1000
Message-ID: <1214558983.8011.542.camel@pasglop>
References: <1214548895.8011.526.camel@pasglop>
	 <20080627095454.665b7229@lxorguk.ukuu.org.uk>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40274 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbYF0Ja1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 05:30:27 -0400
In-Reply-To: <20080627095454.665b7229@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

On Fri, 2008-06-27 at 09:54 +0100, Alan Cox wrote:
> > a) =EF=BB=BFFor any ATAPI DMA, If the transfer size is not a multip=
le of 16
> > bytes, switch to PIO for this command.
>=20
> Old IDE does this internally. Tejun has done a lot of this stuff for =
the
> ATAPI layer in libata. See the check_atapi_dma method (example at
> it821x_check_atapi_dma with a size rule)

 .../...

Thanks Alan. I'll look at those various examples and sort things
out.

Cheers,
Ben.


