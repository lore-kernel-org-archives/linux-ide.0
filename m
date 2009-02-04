From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Wed, 4 Feb 2009 10:36:30 +0100
Message-ID: <200902041036.30785.stf_xl@wp.pl>
References: <200902031147.41822.stf_xl@wp.pl> <cd73a99e0902031227x678ebfa3h14207aeaf00a406c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:22942 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbZBDJgo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Feb 2009 04:36:44 -0500
In-Reply-To: <cd73a99e0902031227x678ebfa3h14207aeaf00a406c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <avictor.za@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Tuesday 03 February 2009 21:27:04 Andrew Victor napisa=C5=82(a):
> hi Stanislaw,
Hi.

> > +void __init at91_add_device_ide(struct at91_ide_data *data)
> > +{
>=20
> This platform initialization code is virtually identical to the
> at91_cf version submitted by Uros Bizjak, albeit for the SAM9260.
> Similarly the "at91_cf_data" and "at91_ide_data" structs.
>=20
> Wouldn't it be better to have a single CF initialization function, an=
d
> you specify whether you want "plain CF" mode or True-IDE mode?
> You could even pass the same platform-resources structure (ie,
> base-address of CF region), and have at91_ide setup the location of
> the task-file and control registers from that base address.
Yes, this can be merged together. Ronetix already did a SAM9263 board
and linux patch with "full" CF device.

http://download.ronetix.info/sk-eb926x/linux/kernel/2.6.28/003_linux-2.=
6.28-at91-ronetix-12012009.patch

There are some difference, but I think CF stuff can have one initializa=
tion
function. Could this be a separate patch in later date? I would like ma=
rge
at91_ide into mainline without changes if there will be no objections.

Cheers
Stanislaw Gruszka
