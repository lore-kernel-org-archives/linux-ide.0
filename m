From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM REMAINS: [sata_nv ADMA breaks ATAPI] Crash	on	accessing
 DVD-RAM
Date: Sun, 13 Jan 2008 16:29:59 +0000
Message-ID: <20080113162959.01d519db@lxorguk.ukuu.org.uk>
References: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no>
	<478702C7.80401@shaw.ca>
	<47887982.6050805@mail.ru>
	<47891426.1020604@shaw.ca>
	<1200170117.3656.66.camel@localhost.localdomain>
	<47894785.2050508@shaw.ca>
	<1200180440.3656.76.camel@localhost.localdomain>
	<47896BA8.4030609@shaw.ca>
	<20080113133317.50ad4bda@lxorguk.ukuu.org.uk>
	<1200238725.3179.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43526 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752232AbYAMQcs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 11:32:48 -0500
In-Reply-To: <1200238725.3179.16.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Alexander <aledin@mail.ru>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

> Yes, I concur for the short term.  The other two possible courses of
> action either involve long discussions (the different device one) or
> you'll never quite be sure you got all the paths (the GFP_DMA32 one).
> At least with this one, you know everything will work.

The different device one is tricky because the PCI layer is involved in
mapping on some systems so you can't just magic up a platform device for
it. Putting a mask on the block queue might perhaps work as a model
which avoids breaking stuff by suprise, with the device left at 32bit
masking.
