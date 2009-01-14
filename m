From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Wed, 14 Jan 2009 14:21:22 +0100
Message-ID: <200901141421.22309.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <20090114135832.7718055f@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:35513 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757996AbZANNVZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 08:21:25 -0500
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
Because I didn't know about this driver. I searched someting for AT91
and missed that one. Surly in mainline AT91 support should be added
for pata_at32 driver. In my company case we want to go into production
with 2.6.27 kernel, PATA is marked as experimental even in 2.6.28.=20
I don't know if better to use PATA or IDE stack for our case.

Stanislaw Gruszka


