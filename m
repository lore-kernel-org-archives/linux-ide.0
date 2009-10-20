From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: sata_via: SError: { UnrecovData Proto TrStaTrns }
Date: Tue, 20 Oct 2009 18:00:40 +0200
Message-ID: <m33a5e5a3b.fsf@intrepid.localdomain>
References: <m3my46yo5g.fsf@intrepid.localdomain>
	<19147.28614.505296.752363@pilspetsen.it.uu.se>
	<m3vdii51d8.fsf@intrepid.localdomain>
	<19157.6679.939371.469696@pilspetsen.it.uu.se>
	<20091014125344.7d0b2597@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:38654 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbZJTQAi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Oct 2009 12:00:38 -0400
In-Reply-To: <20091014125344.7d0b2597@lxorguk.ukuu.org.uk> (Alan Cox's message
	of "Wed, 14 Oct 2009 12:53:44 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>

Update: I've connected Kingston SSD instead of Transcend's. The same
errors appear, but now there is a lot of them (> 30 instead of maybe 5
per my test with Transcend).

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> These two may be worth playing with, especially latency. Forcing the
> latency on the problem board would be interesting given that it is a DMA
> transfer that is failing.

Changing the latency byte doesn't seem to change anything. OTOH the
VT6421A mini-PCI card is the only PCI device in system (not counting the
on-CPU AHB-PCI bridge). The problem is also present (to a lesser extent)
when I plug it into x86-64 machine (using mini-PCI adapter). The SSD
works fine if connected to motherboard's NVidia MCP55 SATA controller.

I have read the datasheet and tried some changes to PCI registers but it
doesn't fix it.

I'm going to test x86-64 + VT6421A + Kingston SSD combination soon.

Unfortunately I don't have a (mini) PCI analyser... I will look at
REQ/GNT and similar signals on PCI, though.
-- 
Krzysztof Halasa
