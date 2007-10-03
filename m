From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 3 Oct 2007 15:18:56 -0600
Message-ID: <20071003211856.GB2916@cosmic.amd.com>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
 <20071003203118.GA2916@cosmic.amd.com>
 <20071003215937.123c95ee@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:21591 "EHLO
	outbound3-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754184AbXJCVSi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 17:18:38 -0400
In-Reply-To: <20071003215937.123c95ee@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <mkp@mkp.net>, linux-ide@vger.kernel.org, info-linux@geode.amd.com

On 03/10/07 21:59 +0100, Alan Cox wrote:
> > I have to discourage this patch just on principle, because I don't like
> > the idea of working around the VSA.  That said, it seems that Alan is 
> > willing to take on the extra code, and there isn't anything technically
> > deficient here, so I'm fine with this going in.
> 
> I'd prefer to go via the PCI virtualisation(but with the timings fixed)
> but there are boxes out there where this doesn't work.
> 
> Ideally what I'd like would be a suggestion of how to tell if the VSA is
> active on this so that we can use VSA if present.

int geode_has_vsa() {
	outw(0xFC53, 0xAC1C);
	outw(0x0003, 0xAC1C);

	rev = inw(0xAC1E);
	return (rev == 0x4132) ? 1 : 0;
}

That should work on any AMD VSA derivatives.  There are some who may have
rolled their own, and they don't support the same virtual registers.  in
that case, you can check if SMIs are enabled - that would be a reasonable
indication that there is something VSAish out there.

But you bring up another point - I'm not sure that Martin _doesn't_ have
VSA.  He is initializing this as a PCI driver, so he has something out
there listening to CF8/CFC, or he's emulating the OLPC spoof mechanism [1].
If its the former, and it doesn't handle the 5536 IDE config space, then
thats something that should be fixed by the BIOS vendor just on general
principle (other OSes aren't as lucky as we are working around the PCI
space).  If its the OLPC method, then I could argue that fudging the
registers belongs in that code, and not in the driver.

Jordan

[1] - http://dev.laptop.org/git?p=olpc-2.6;a=blob;f=arch/i386/pci/olpc.c;h=1518d254c5e3a58a27a396afa3f27d06785fc337;hb=HEAD

(I refer this only as an example, and not something to be emulated by other
platforms.  This works great for OLPC, but it would be a nightmare for
arbitrary platforms).

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


