From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Fri, 1 Oct 2004 16:11:16 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410011611.16859.bzolnier@elka.pw.edu.pl>
References: <1096602694.11460.29.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:49539 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S266878AbUJBAQP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Oct 2004 20:16:15 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:36195 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S50782AbUJBAQO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Oct 2004 02:16:14 +0200
Received: from [84.10.12.196] ([84.10.12.196]:61795 "EHLO [192.168.123.164]"
	ident: "TIMEDOUT" smtp-auth: "bzolnier" TLS-CIPHER: <none> TLS-PEER-CN1:
	<none>) by mion.elka.pw.edu.pl with ESMTP id S481461AbUJAOJu (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Fri, 1 Oct 2004 16:09:50 +0200
In-Reply-To: <1096602694.11460.29.camel@gaston>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Friday 01 October 2004 05:51, Benjamin Herrenschmidt wrote:
> Hi Bart !

Hi!
 
> I noticed that you are about to absolete the whole lot of IDE
> default stuff
> 
> # define ide_default_io_base(index)	(0)
> # define ide_default_irq(base)		(0)
> # define ide_init_default_irq(base)	(0)
> 
> and others...
> 
> So how do I do to "cleanly" tell the IDE layer that my PCI IDE
> controller that shows on the PCI bus and is in legacy mode is
> using some IRQs (14 & 15 typically) that are _not_ the PCI irq
> line for this device ?

->init_hwif() hook

i.e. piix.c is handling this with:

	if (!hwif->irq)
		hwif->irq = hwif->channel ? 15 : 14;

Bartlomiej
