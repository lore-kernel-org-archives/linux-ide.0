From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch for 2.6.29? 2/4] pata_amd: program FIFO
Date: Wed, 25 Feb 2009 15:31:17 -0500
Message-ID: <49A5AA95.2060407@garzik.org>
References: <200902112108.n1BL8gT6005295@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53150 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758517AbZBYUbX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 15:31:23 -0500
In-Reply-To: <200902112108.n1BL8gT6005295@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> With 32bit PIO we can use the posted write buffers, but only for 32bit I/O
> cycles.  This means we must disable the FIFO for ATAPI where a final 16bit
> cycle may occur.
> 
> Rework the FIFO logic so that we disable the FIFO then selectively
> re-enable it when we set the timings on AMD devices.  Also fix a case
> where we scribbled on PCI config 0x41 of Nvidia chips when we shouldn't.
> 
> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_amd.c |   76 ++++++++++++++++++++++++++++++---------
>  1 file changed, 59 insertions(+), 17 deletions(-)

applied


