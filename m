From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Fri, 6 Feb 2009 11:47:58 +0100
Message-ID: <200902061147.59196.stf_xl@wp.pl>
References: <200902031147.22827.stf_xl@wp.pl> <200902061030.11427.stf_xl@wp.pl> <498C12BC.9080200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:34887 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbZBFKsI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Feb 2009 05:48:08 -0500
In-Reply-To: <498C12BC.9080200@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

=46riday 06 February 2009 11:36:44 Sergei Shtylyov napisa=C5=82(a):
> >>> +	host->ports[0]->extra_base =3D board->chipselect;
> >>>  =20
> >>>      =20
> >>    BTW, we have 2 fields in the struct hwif_s that fit this case b=
etter:=20
> >> config_data and select_data. It's a bit stange that you've selecte=
d=20
> >> extra_base...
> >>    =20
> > config_data is in use by IDE core,
>=20
>    Hm, it shouldn't be. These fields are exclusively for drivers' use=
=2E
Right, it is just overwritten in ide_init_port_hw() and should be
setup by hw->config.

Stanislaw Gruszka

