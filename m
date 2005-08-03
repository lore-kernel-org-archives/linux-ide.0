From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: ahci, SActive flag, and the HD activity LED
Date: Wed, 3 Aug 2005 09:41:55 +0300
Message-ID: <20050803064155.GH2106@edu.joroinen.fi>
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from edu.joroinen.fi ([194.89.68.130]:16310 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S261462AbVHCGl4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2005 02:41:56 -0400
Content-Disposition: inline
In-Reply-To: <42F05359.7030006@fujitsu-siemens.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>

On Wed, Aug 03, 2005 at 07:17:13AM +0200, Martin Wilck wrote:
> Jens Axboe wrote:
>=20
> >>If I am reading the specs correctly, that'd mean the ahci driver is=
=20
> >>wrong in setting the SActive bit.
> >
> >I completely agree, that was my reading of the spec as well and henc=
e my
> >original posts about this in the NCQ thread.
>=20
> Have you (or has anybody else) also seen the wrong behavior of the=20
> activity LED?
>

I have a box with ICH6R and AHCI in use with Linux 2.6.11, using seagat=
e NCQ
sata drives. the HD activity LED is on all the time..

- Pasi K=E4rkk=E4inen
      =20
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
