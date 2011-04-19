From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
 boot on parisc
Date: Tue, 19 Apr 2011 08:54:38 -0500
Message-ID: <1303221278.3171.9.camel@mulgrave.site>
References: <1303152147.7167.12.camel@mulgrave.site>
	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	 <1303159802.7167.30.camel@mulgrave.site>
	 <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
Sender: linux-parisc-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 2011-04-18 at 22:20 +0100, Alan Cox wrote:
> We can detect the Mobility electronics split bridges at least (and I
> suspect they are the only 'common' CMD64x hot plug device indeed possibly
> the only one) because the parent bridge of the CMD64x will have a PCI
> vendor id of 0x14f2 and a device id 0x0001, 0x0002, or 0x0120.

Trying to wire in a bridge blacklist looks a bit dicey ... unless you're
sure this is (and will always be) the only bridge?  How should this
wiring be done? most of the bridge checks just see if the bridge is in
the system rather than walking up the device tree; is that OK?

If not, what about just a legacy check on X86, so hedge with

if (legacy || !CONFIG_X86)

(or even just dump the legacy check, since you think everything is fine
on x86 today?)

James


