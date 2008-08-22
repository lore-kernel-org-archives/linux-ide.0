From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Driver for Promise PDC42819 SATA/SAS controller
Date: Sat, 23 Aug 2008 00:01:34 +0200
Message-ID: <18607.14142.979717.852078@harpo.it.uu.se>
References: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
	<18597.25642.934859.944853@harpo.it.uu.se>
	<65a6ef750808210557o1cf07c5fj9d273413003037f8@mail.gmail.com>
	<18605.27969.933718.902876@harpo.it.uu.se>
	<65a6ef750808211710k4f1e18b5y74b8d51e30c5900@mail.gmail.com>
	<18606.60604.356878.363677@harpo.it.uu.se>
	<48AF282B.4090904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:33931 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbYHVWCR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 18:02:17 -0400
In-Reply-To: <48AF282B.4090904@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Mark Nelson <mdnelson8@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > Mark Nelson writes:
 > >  > > But without docs or a reference driver I cannot really say what it
 > >  > > would take to support it, sorry.
 > >  > 
 > >  > Yeah, I figured as much after reading that hardware docs
 > >  > are only available under NDA... I do have Promise's "partial
 > >  > open source driver" all working with the controller; but I
 > >  > don't think that's what you meant by reference driver, is it?
 > > 
 > > No. Promise's partial-source drivers sometimes contain some useful
 > > information, like register definitions, but the only useful info
 > > in the TX4650 driver is the PCI ID list for the T3 chip family.
 > 
 > FWIW there's always the chance it belongs to drivers/scsi/stex.c...

True, but unfortunately I doubt it as the PCI IDs in the tx4650
(partial) sources bear no resemblance to the ones in stex.c.

The tx4650 driver lists 35xx for octopusII, 630x for napa_fpga, 377x/3Fxx
for T3 (the chip in question), and 662x for SX4, whereas stex.c lists
x350/4302 for shasta, 7250 for vsc (vitesse?), and 8650 for yosemite.
