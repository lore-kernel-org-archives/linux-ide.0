From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch for 2.6.29? 3/4] pata_legacy: for VLB 32bit PIO don't
 try tricks with slop
Date: Wed, 25 Feb 2009 15:31:58 -0500
Message-ID: <49A5AABE.1050600@garzik.org>
References: <200902112108.n1BL8go1005308@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53163 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758782AbZBYUcD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 15:32:03 -0500
In-Reply-To: <200902112108.n1BL8go1005308@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> These devices are generally used with ATA anyway and it seems that some
> ATAPI will need us to issue the right number of words.  Therefore as we
> can't switch mid burst on VLB devices we should only use 32bit I/O for
> suitable block sizes.
> 
> 
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_legacy.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

applied

These two haven't much testing, but I can't in good conscience let them 
slip to 2.6.30 either...  Let's get them in.

	Jeff




