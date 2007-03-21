From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] libata hpa support
Date: Wed, 21 Mar 2007 19:17:14 +0000
Message-ID: <20070321191714.2b24809e@lxorguk.ukuu.org.uk>
References: <20070223170625.GA29931@athena.road.mcmartin.ca>
	<20070321130140.GA4328@athena.road.mcmartin.ca>
	<20070321183455.00f4732b@lxorguk.ukuu.org.uk>
	<46016E58.5010509@garzik.org>
	<20070321185024.31673dd3@lxorguk.ukuu.org.uk>
	<46017383.2000107@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60005 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933287AbXCUSNq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Mar 2007 14:13:46 -0400
In-Reply-To: <46017383.2000107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kyle McMartin <kyle@canonical.com>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

> > Paranoid people get PCI boot roms that lock their disks.
> 
> Certainly.
> 
> But I argue that doing it late is better than not doing it at all.

And distributions (smart ones anyway) already do it in the initrd which
is the correct place for this.
