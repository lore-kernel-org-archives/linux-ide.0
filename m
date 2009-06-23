From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] cs5520: add missing IRQ setup for the second port
Date: Tue, 23 Jun 2009 11:59:01 +0200
Message-ID: <200906231159.01295.bzolnier@gmail.com>
References: <200906221348.02632.bzolnier@gmail.com> <200906230158.12805.elendil@planet.nl> <20090623094206.4d1f1b5b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:18201 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZFWJxF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 05:53:05 -0400
In-Reply-To: <20090623094206.4d1f1b5b@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Frans Pop <elendil@planet.nl>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 23 June 2009 10:42:06 Alan Cox wrote:
> On Tue, 23 Jun 2009 01:58:11 +0200
> Frans Pop <elendil@planet.nl> wrote:
> 
> > David Miller wrote:
> > > ide_pci_setup_ports() would loop over the available ports, one
> > > by one, recording IRQ numbers increasingly from the one passed
> > > in as "pciirq".
> > 
> > I looked at the commit and at the code and called functions several times 
> > (just out of curiosity), but have been completely unable to find where 
> > that increase of pciirq actually happened.
> > AFAICT ide_pci_setup_ports() just passed it on to ide_hw_configure() and 
> > all that did was 'hw->irq = irq', so AFAICT in the old case both ports 
> > would get the *same* IRQ, and not consecutive ones.
> 
> The cs5520 isn't a standard IDE controller in the first place and doesn't
> have two channels anyway. It's special as it uses non standard bar

Please note that both cs5520.c / pata_cs5520.c assume that the controller
has two ports (please verify whether they need some fixing, thanks)..
