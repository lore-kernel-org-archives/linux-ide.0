From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM REMAINS: [sata_nv ADMA breaks ATAPI] Crash	on	accessing
 DVD-RAM
Date: Sun, 13 Jan 2008 13:33:17 +0000
Message-ID: <20080113133317.50ad4bda@lxorguk.ukuu.org.uk>
References: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no>
	<478702C7.80401@shaw.ca>
	<47887982.6050805@mail.ru>
	<47891426.1020604@shaw.ca>
	<1200170117.3656.66.camel@localhost.localdomain>
	<47894785.2050508@shaw.ca>
	<1200180440.3656.76.camel@localhost.localdomain>
	<47896BA8.4030609@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58162 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751144AbYAMNgE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 08:36:04 -0500
In-Reply-To: <47896BA8.4030609@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Alexander <aledin@mail.ru>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

> Other than that, I guess the solutions would be to just set a 32-bit 
> mask on the device if either port has an ATAPI device connected (which 
> is fairly ugly, considering that you could do things like hotplug an 
> ATAPI device when the other port was in use, for example), or do 
> something to prevent requests from reaching this point with >4GB 
> addresses in the first place..

With 2.6.24 almost released I think that is a must do for the moment and
since we also have hotplugging fo devices it might be easier for .24 to
just set a 32bit DMA mask and be done with it, then fix it later.

