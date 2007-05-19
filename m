From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_sil: Greatly improve DMA support
Date: Sat, 19 May 2007 11:01:55 -0600
Message-ID: <464F2D83.6000506@shaw.ca>
References: <fa.SqfRJHzGgf3m6sdJPwJTwHDPSuw@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51268 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbXESRCG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2007 13:02:06 -0400
In-reply-to: <fa.SqfRJHzGgf3m6sdJPwJTwHDPSuw@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Since Alan expressed a desire to see Large Block Transfer (LBT) support
> in pata_sil680, I though I would re-post my patch for adding LBT support
> to sata_sil.
> 
> Silicon Image's Large Block Transfer (LBT) support is a vendor-specific
> DMA scatter/gather engine, which enables 64-bit DMA addresses (where
> supported by platform) and eliminates the annoying 64k DMA boundary
> found in legacy PCI IDE BMDMA engines.

Looks like it doesn't allow 64-bit DMA addresses, it only gets rid of 
the 64K boundary limitation.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

