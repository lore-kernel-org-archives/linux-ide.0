From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Fri, 6 Feb 2009 10:30:11 +0100
Message-ID: <200902061030.11427.stf_xl@wp.pl>
References: <200902031147.22827.stf_xl@wp.pl> <498987E6.7040909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:42974 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbZBFJaW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Feb 2009 04:30:22 -0500
In-Reply-To: <498987E6.7040909@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Wednesday 04 February 2009 13:19:50 Sergei Shtylyov napisa=C5=82(a):
> [...]
> > +	host->ports[0]->extra_base =3D board->chipselect;
> >  =20
>=20
>    BTW, we have 2 fields in the struct hwif_s that fit this case bett=
er:=20
> config_data and select_data. It's a bit stange that you've selected=20
> extra_base...
config_data is in use by IDE core, I'll switch to select_data.

Stanislaw Gruszka
