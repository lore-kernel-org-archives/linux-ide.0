From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Mon, 18 Apr 2011 20:52:03 +0100
Message-ID: <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
References: <1303152147.7167.12.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303152147.7167.12.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 18 Apr 2011 13:42:27 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> currently libata-sff is completely ignoring the enabled/disabled status
> of the interfaces. 

Yes - it makes some machines work rather better because the BIOSes
sometimes mess up the registers. It wad a *deliberate* decision not to
port it over and as a result stuff works that failed before. Windows
drivers clearly ignore the bits in many cases.

In addition
- Your patch seems to be applying the enable bits apply in native mode
  (they don't generally)
- You seem to be assuming either first or both ports enabled, secondly
  only is just as valid

This matters for CMD64x as several 64x devices are found on hotpluggable
'docking stations' using a PCI split bridge. Only doing the checks for
chips in legacy mode should avoid that problem. In native mode the PCI
bars are the only register bases used so the problem doesn't arise.

The patch seems to be broken for all these cases and also incredibly
invasive given you can just pass a dummy port in as one of
your struct ata_port_info * pointers to ata_pci_dma_init_one()

You shouldn't need to touch a single line of the core libata code,
although it might be the best way of doing it. Either way if you do the
number of ports needs to be a bitmask instead and you need to leave
native mode alone.

Alan
