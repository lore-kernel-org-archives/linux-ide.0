From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Mon, 04 Oct 2004 11:26:53 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096853212.12123.64.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <200410032254.16900.bzolnier@elka.pw.edu.pl>
	 <1096846969.9516.39.camel@gaston>
	 <200410040227.14513.bzolnier@elka.pw.edu.pl>
	 <1096851939.9516.53.camel@gaston>  <4160A6EE.1010804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:63427 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268304AbUJDBbe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2004 21:31:34 -0400
In-Reply-To: <4160A6EE.1010804@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, linux-ide@vger.kernel.org

On Mon, 2004-10-04 at 11:27, Jeff Garzik wrote:

> > We could have it either called by the chipset drivers themselves, or by
> > the generic code when the controller is in legacy mode.
> 
> How about a more generic, yet more specific pci_init_hwif()?

What would it do except from providing the interrupt  ?

I really don't want platforms to abuse that in the way the older
callbacks existed, that is to fully initialize an hwif.

Also, my proposal beeing sort-of "agnostic" to the IDE layer (only
pdev and channel arguments), it could be useable by libata too :)

Ben.


