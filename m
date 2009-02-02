From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Mon, 2 Feb 2009 13:35:31 +0100
Message-ID: <200902021335.31465.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <200901301005.44858.stf_xl@wp.pl> <200902011813.18192.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:41415 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbZBBMfo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 07:35:44 -0500
In-Reply-To: <200902011813.18192.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Sunday 01 February 2009 18:13:17 Bartlomiej Zolnierkiewicz napisa=C5=82=
(a):
> > I have some doubts about things pointed out by Alan  - atomic acces=
s. =20
> > Due to flipping 8/16 bit in this driver, all functions accessing ta=
sk file=20
> > and data register should do things atomically. If for example
> > tp_ops->input_data() will be braked by interrupt and any other func=
tion
> > accessing task file will be called very bad things can happen.
>=20
> All taskfile / data access is atomic, the only exception is [Alt]Stat=
us
> register read if shared IRQs are used (which doesn't seem to be the c=
ase
> with AT91) or if the hardware is flaky and unexpected IRQs can happen=
=2E..
>=20
> If 8/16-bit flipping is really an issue then AT91 IRQ handler may nee=
d
> to save info about current mode on entry, switch to 8-bit (if in 16-b=
it
> mode), restore the saved mode on exit (if it was 16-bit mode).
I think we don't need it because we don't use shared interrupts.
Moreover hardware allow to Altarnate Status register be accessed
in both 8 and 16 bit modes.

> > If I use IDE_HFLAG_UNMASK_IRQS IDE layer will assure atomic
> > access to ATA registers ?
>=20
> IDE_HFLAG_UNMASK_IRQS allows other IRQs to be serviced while IDE IRQ
> is being serviced so really no problem here (unless some other driver=
s
> also mess with 8/16-bit flipping but if so then the current code need=
s
> fixing too).
We have exclusive access to Static Memory Controller registers as long
as there are no bug in board specific code. So no problem here either.

Stanislaw Gruszka

