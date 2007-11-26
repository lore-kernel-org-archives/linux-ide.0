From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: bump transfer chunk size if it's
 odd
Date: Mon, 26 Nov 2007 11:04:29 -0500
Message-ID: <474AEE8D.8060500@garzik.org>
References: <20071126115802.GC9232@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44462 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbXKZQEd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Nov 2007 11:04:33 -0500
In-Reply-To: <20071126115802.GC9232@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> None of the drives I have follows what the standard says about
> transfer chunk size.  Of the four SATA and six PATA ATAPI devices
> tested, four ignore transfer chunk size completely and the ones which
> honor it don't behave according to the spec when it's odd.
> 
> According to the spec, transfer chunk size can be odd if the amount of
> data to transfer equals or is smaller than the chunk size and the
> device can indicate the same odd number and transfer the whole thing
> at one go with a pad byte appended.  However, in reality, none of the
> drives I have does that.  They all indicate and transfer even number
> of bytes one byte shorter than the chunk size first; then indicate and
> transfer two bytes, which is clearly out of spec.
> 
> In addition to unnecessary second PIO data phase, this also creates a
> weird problem when combined with SATA controllers which perform PIO
> via DMA.  Some of these controllers use actualy number of bytes
> received to update DMA pointer so chunks which are sized 4n + 2 makes
> DMA pointer off by two bytes.  This causes data corruption and buffer
> overruns.
> 
> This patch rounds nbytes up to the nearest even number such that ATAPI
> devices don't split data transfer for the last odd byte.  This
> shouldn't confuse controllers which depend on transfer chunk size as
> devices will report the rounded-up number, actually transfer that much
> and padding buffer is there to receive them.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


