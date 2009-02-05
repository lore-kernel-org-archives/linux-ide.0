From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Thu, 5 Feb 2009 16:06:04 +0100
Message-ID: <200902051606.04181.stf_xl@wp.pl>
References: <200902031147.41822.stf_xl@wp.pl> <cd73a99e0902031227x678ebfa3h14207aeaf00a406c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:53568 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757285AbZBEPGX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2009 10:06:23 -0500
In-Reply-To: <cd73a99e0902031227x678ebfa3h14207aeaf00a406c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <avictor.za@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Tuesday 03 February 2009 21:27:04 Andrew Victor napisa=C5=82(a):
> hi Stanislaw,
>=20
> > +void __init at91_add_device_ide(struct at91_ide_data *data)
> > +{
>=20
> This platform initialization code is virtually identical to the
> at91_cf version submitted by Uros Bizjak, albeit for the SAM9260.
> Similarly the "at91_cf_data" and "at91_ide_data" structs.
Shouldn't be sam9_smc_config stuff be in board file not in cpu file,=20
in place where you know what is the clock frequency. Could you
assume cpu is clocked with some particular freqency?

Cheers
Stanislaw Gruszka
