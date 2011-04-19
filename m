From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Tue, 19 Apr 2011 15:36:15 +0100
Message-ID: <20110419153615.07733111@lxorguk.ukuu.org.uk>
References: <1303152147.7167.12.camel@mulgrave.site>
	<20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	<1303159802.7167.30.camel@mulgrave.site>
	<20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
	<1303221278.3171.9.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303221278.3171.9.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> If not, what about just a legacy check on X86, so hedge with
> 
> if (legacy || !CONFIG_X86)
> 
> (or even just dump the legacy check, since you think everything is fine
> on x86 today?)

Well in theory you can plug a cardbus one into a non x86 assuming the
firmware doesn't explode in protest anyway !

I don't think the bridge walk is particularly tricky - it will always be
the direct parent bridge

So it's a matter of

	struct pci_dev *bridge = dev->bus->self;
	if (bridge && bridge->vendor == 0x14f2)

Alan

