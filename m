From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
 PowerMac/PowerBook IDE controller
Date: Wed, 02 Dec 2009 09:58:52 +1100
Message-ID: <1259708332.2076.1041.camel@pasglop>
References: <20091201070834.6A840B7B63@ozlabs.org>
	 <m2hbsazapo.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57497 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788AbZLAW7p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 17:59:45 -0500
In-Reply-To: <m2hbsazapo.fsf@igel.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org, tj@kernel.org

On Tue, 2009-12-01 at 21:43 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This is a libata driver for the "macio" IDE controller used on most Apple
> > PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
> 
> Tried it on my iBook G4 and I got an oops during probing, in
> pata_macio_common_init+0x378/0x614.

Bah, I know what it is ... a last minute cleanup that breaks the PCI
variants of the cell. I'll send a new patch later today along with
other fixes.

Cheers,
Ben.


