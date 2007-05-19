From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sil: Greatly improve DMA support
Date: Sat, 19 May 2007 17:27:13 -0400
Message-ID: <464F6BB1.9050609@garzik.org>
References: <fa.SqfRJHzGgf3m6sdJPwJTwHDPSuw@ifi.uio.no> <464F2D83.6000506@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58223 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749AbXESV1Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 May 2007 17:27:16 -0400
In-Reply-To: <464F2D83.6000506@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> Jeff Garzik wrote:
>> Since Alan expressed a desire to see Large Block Transfer (LBT) support
>> in pata_sil680, I though I would re-post my patch for adding LBT support
>> to sata_sil.
>>
>> Silicon Image's Large Block Transfer (LBT) support is a vendor-specific
>> DMA scatter/gather engine, which enables 64-bit DMA addresses (where
>> supported by platform) and eliminates the annoying 64k DMA boundary
>> found in legacy PCI IDE BMDMA engines.
> 
> Looks like it doesn't allow 64-bit DMA addresses, it only gets rid of 
> the 64K boundary limitation.

rotfl.  Boy am I dumb.  I -thought- my patch, written months ago, 
included that bit.  But obviously it does not.  Let's add that...

	Jeff



