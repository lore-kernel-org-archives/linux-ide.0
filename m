From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Tue, 19 Apr 2011 22:19:00 +0100
Message-ID: <20110419221900.67528a07@lxorguk.ukuu.org.uk>
References: <1303152147.7167.12.camel@mulgrave.site>
	<20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	<1303159802.7167.30.camel@mulgrave.site>
	<20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
	<4DADF798.6010705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <4DADF798.6010705@ru.mvista.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> > We can detect the Mobility electronics split bridges at least (and I
> > suspect they are the only 'common' CMD64x hot plug device indeed possibly
> > the only one) because the parent bridge of the CMD64x will have a PCI
> > vendor id of 0x14f2 and a device id 0x0001, 0x0002, or 0x0120.
> 
>     What's the issue with these brodges anyway? Why the enable bits are not 
> valid for them?

Good question. I'd assumed because they are hotplugged and so no firmware
gets to set the bits properly ?
