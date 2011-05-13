From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
 boot on parisc
Date: Fri, 13 May 2011 12:01:58 -0500
Message-ID: <1305306118.2611.62.camel@mulgrave.site>
References: <1303673315.5231.9.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44580 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754255Ab1EMRCB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 May 2011 13:02:01 -0400
In-Reply-To: <1303673315.5231.9.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>

On Sun, 2011-04-24 at 14:28 -0500, James Bottomley wrote:
> currently libata-sff is completely ignoring the enabled/disabled status
> of the interfaces.  This is a real problem on parisc because if you
> touch a non responding memory area (i.e. a disabled interface) you crash
> the box.
> 
> Fix by checking the CNTRL bits to see if the port is enabled before
> trying to poke it.

Ping on this.

Since 1/2 is an essential fix to prevent a boot panic on parisc, I can
just take them through the parisc tree.

James


> James
> 
> ---
> 
> James Bottomley (2):
>   pata_cm64x: fix boot crash on parisc
>   libata-sff: prevent irq descriptions for dummy ports
> 
>  drivers/ata/libata-sff.c  |    9 +++++++--
>  drivers/ata/pata_cmd64x.c |   42 ++++++++++++++++++++++++++++++++++++++----
>  include/linux/pci_ids.h   |    2 ++
>  3 files changed, 47 insertions(+), 6 deletions(-)
> 


