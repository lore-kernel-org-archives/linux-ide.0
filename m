From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 08/15] libata: improve ATAPI draining
Date: Tue, 18 Dec 2007 16:41:18 -0500
Message-ID: <47683E7E.4030102@garzik.org>
References: <11968405951262-git-send-email-htejun@gmail.com> <11968405973998-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57879 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbXLRVlV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:41:21 -0500
In-Reply-To: <11968405973998-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Albert Lee <albertcc@tw.ibm.com>

Tejun Heo wrote:
> For misc ATAPI commands which transfer variable length data to the
> host, overflow can occur due to application or hardware bug.  Such
> overflows can be ignored safely as long as overflow data is properly
> drained.  libata HSM implementation has this implemented in
> __atapi_pio_bytes() but it isn't enough.  Improve drain logic such
> that...
> 
> * Multiple PIO data phases are allowed.  Not allowing this used to be
>   okay when transfer chunk size was set to 8k unconditionally but with
>   transfer hcunk size set to allocation size, treating extra PIO data
>   phases as HSM violations cause a lot of trouble.
> 
> * Limit the amount of draining to ATAPI_MAX_DRAIN (16k currently).
> 
> * Don't whine if overflow is allowed and safe.  When unexpected
>   overflow occurs, trigger HSM violation and report the problem using
>   ehi error description.
> 
> * Properly calculate the number of bytes to be drained considering
>   actual number of consumed bytes for partial draining.
> 
> * Add and use ata_drain_page for draining.  This change fixes the
>   problem where LLDs which do 32bit IOs consumes 4 bytes on each 2
>   byte draining resulting in draining twice more data than requested.
> 
> This patch fixes ATAPI regressions introduced by setting transfer
> chunk size to allocation size.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Albert Lee <albertcc@tw.ibm.com>

I'm dropping this one, since a good portion of it is already upstream 
as140b5e59119a172a91b5fa13d54ca4f79bbefee1

	Jeff



