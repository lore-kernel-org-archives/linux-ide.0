From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: More ATA corner cases
Date: Thu, 17 Aug 2006 01:38:38 +0100
Message-ID: <1155775118.15195.14.camel@localhost.localdomain>
References: <1155731962.24077.346.camel@localhost.localdomain>
	 <44E3A13D.20102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12251 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932151AbWHQAS6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 20:18:58 -0400
In-Reply-To: <44E3A13D.20102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Ar Mer, 2006-08-16 am 18:50 -0400, ysgrifennodd Mark Lord:
> Alan Cox wrote:
> > Any objection to me adding a new cable type for "40 wire ATA66 capable"
> > to indicate the laptop vendor has been sneaky and we should do full UDMA
> > ranges regardless of drive or other controller reporting.
> 
> Good.  I'll need that feature for a little mini-ITX box here as well.
> It uses a *really short* 40W cable for UDMA4 operation.

Can you send me the dmidecode output and the lspci -vxxx for it so I can
find something to autodetect this.

