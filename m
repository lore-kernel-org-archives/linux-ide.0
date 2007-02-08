From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Problems (and confusions) with Intel ICH7 SATA controller
Date: Thu, 08 Feb 2007 10:55:30 +0100
Message-ID: <1170928530.31971.1.camel@lapnavab35.informatik.tu-muenchen.de>
References: <1170536373.7892.5.camel@localhost>  <45C956CA.80709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from charlie109.server4you.de ([85.25.2.70]:35902 "EHLO
	butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423154AbXBHJ4D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Feb 2007 04:56:03 -0500
In-Reply-To: <45C956CA.80709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

> > I have an Acer Aspire 5550 laptop with Core Solo processor and the Intel
> > ICH7 Chipset. Most of the hardware works fine, with the exception of
> > suspend-to-ram. 

> > I have a strong suspicion that the SATA controller is to blame for that,
> > as I have tried every possible combination of s2ram parameters and still
> > the display stays black upon resume, only the hard disk LED lights up
> > and stays that way.
> > 
> > I have seen suggestions to try the ahci driver instead of the ata_piix
> > driver, however, as far as I understand this would need switching the
> > controller mode in BIOS. The BIOS is, unfortunately, utterly crippled
> > and gives almost no options to change anything beyond the system clock.
> > 
> > Is this a known problem with ICH7? Can anybody give me some additional
> > hints?
> Which version of kernel are you using?

That would be 2.6.18. I've also tried 2.6.19, but it had the same
problems and the ipw3945 wireless driver didn't work there, so I kept
2.6.18 for the time being.

Yours, Florian

