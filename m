From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
 boot on parisc
Date: Tue, 19 Apr 2011 10:02:55 -0500
Message-ID: <1303225375.3171.13.camel@mulgrave.site>
References: <1303152147.7167.12.camel@mulgrave.site>
	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	 <1303159802.7167.30.camel@mulgrave.site>
	 <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
	 <1303221278.3171.9.camel@mulgrave.site>
	 <20110419153615.07733111@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33503 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869Ab1DSPDA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 11:03:00 -0400
In-Reply-To: <20110419153615.07733111@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>

On Tue, 2011-04-19 at 15:36 +0100, Alan Cox wrote:
> > If not, what about just a legacy check on X86, so hedge with
> > 
> > if (legacy || !CONFIG_X86)
> > 
> > (or even just dump the legacy check, since you think everything is fine
> > on x86 today?)
> 
> Well in theory you can plug a cardbus one into a non x86 assuming the
> firmware doesn't explode in protest anyway !
> 
> I don't think the bridge walk is particularly tricky - it will always be
> the direct parent bridge

OK, that's what I was looking for.  Most of the other bridge checks just
see if the bridge is present in the system.

> So it's a matter of
> 
> 	struct pci_dev *bridge = dev->bus->self;
> 	if (bridge && bridge->vendor == 0x14f2)

Which vendor is 0x14f2?  It probably should have a PCI_VENDOR_ID_...
define.

James


