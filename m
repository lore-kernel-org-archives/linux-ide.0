From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Driver for Promise PDC42819 SATA/SAS controller
Date: Sat, 23 Aug 2008 13:59:52 +0200
Message-ID: <18607.64440.810334.137910@harpo.it.uu.se>
References: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
	<18597.25642.934859.944853@harpo.it.uu.se>
	<65a6ef750808210557o1cf07c5fj9d273413003037f8@mail.gmail.com>
	<18605.27969.933718.902876@harpo.it.uu.se>
	<65a6ef750808211710k4f1e18b5y74b8d51e30c5900@mail.gmail.com>
	<18606.60604.356878.363677@harpo.it.uu.se>
	<48AF282B.4090904@garzik.org>
	<18607.14142.979717.852078@harpo.it.uu.se>
	<65a6ef750808230223t6da2560fx1799dbf271e95959@mail.gmail.com>
	<18607.58441.367432.715909@harpo.it.uu.se>
	<65a6ef750808230340s1d44cb0ajfba8092d9f62f8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:41126 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643AbYHWMAi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Aug 2008 08:00:38 -0400
In-Reply-To: <65a6ef750808230340s1d44cb0ajfba8092d9f62f8e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Mark Nelson writes:
 > >  > Forgive my ignorance, but does the fact that the T3 controller can also
 > >  > use SAS disks mean we should be looking for a SCSI driver?
 > >
 > > Promise lists only this one partial-source driver for the tx4650,
 > > and it /is/ a Linux scsi driver.
 > >
 > 
 > Oh sorry, I meant to ask should we be looking at an in-kernel
 > (or fully open source driver) that is a SCSI driver that we could make
 > work with the T3? So maybe my question is actually: does the
 > fact that this controller supports SAS disks mean that the
 > driver for it should be a scsi driver (rather than an ATA driver)?

The candidate Linux drivers would be ata/sata_promise, ata/sata_sx4,
block/sx8, and scsi/stex. You tried sata_promise, and from looking
at the PCI IDs I doubt the others are likely to drive the T3.

If you can find an open-source T3 driver in some other operating
system, like OpenSolaris, Darwin, or some *BSD, then that would be
great.
