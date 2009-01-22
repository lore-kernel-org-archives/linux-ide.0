From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 12:19:19 +0100
Message-ID: <200901221219.19504.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <20090114135832.7718055f@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:16823 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbZAVLT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 06:19:28 -0500
In-Reply-To: <20090114135832.7718055f@hskinnemoen-d830>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org

Wednesday 14 January 2009 13:58:32 Haavard Skinnemoen napisa=C5=82(a):
> Stanislaw Gruszka wrote:
> > Some issues with driver:
> >=20
> > * Why not platform driver
> > Generic pata/ide_platform driver will not work with AT91 as we need=
 to=20
> > do special things before access Task File and Data Register (functi=
ons=20
> > set_8bit_mode() and set_16bit_mode()). Also extra things needs to b=
e
> > done when changing PIO mode.
>=20
> Why not use libata? There's already a pata_at32 driver there which
> should be usable on at91 with perhaps a few minor changes.

I will submit at91_ide for the mainline and not touch pata_at32  for re=
ason
listed below (some of them was already mentioned in this thread):

* there are difference in h/w attend=20
  - AT91 and AT32 static memory controller h/w is the same, but linux s=
oftware=20
    interface to programing SMC is diffrent (in this driver we need to =
program SMC)
  - AT91 have to switch between 8/16 bit data bus width, AT32 not
  - AT32 not need to have GPIO IRQ quirk
* libata have more overhead due to SCSI emulation
* ide maintainer is likely to accept at91_ide
* my company want to use it in production with older kernel

Cheers
Stanislaw Gruszka
