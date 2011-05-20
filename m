From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA PMP support
Date: Fri, 20 May 2011 11:25:33 +0200
Message-ID: <20110520092533.GF31426@htj.dyndns.org>
References: <BANLkTi=4oJvigsq7GPMuB8meX0XnDh4VWw@mail.gmail.com>
 <20110519153826.GM627@htj.dyndns.org>
 <BANLkTikrHcnpKZccYMi0+24THZPYP6bRfg@mail.gmail.com>
 <20110520091530.GE31426@htj.dyndns.org>
 <BANLkTinCqzDToLGuQVOY_vTLzDBv02tZuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37131 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935485Ab1ETJZh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2011 05:25:37 -0400
Received: by bwz15 with SMTP id 15so2791049bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2011 02:25:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinCqzDToLGuQVOY_vTLzDBv02tZuA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Suchanek <hramrach@centrum.cz>
Cc: linux-ide@vger.kernel.org

On Fri, May 20, 2011 at 11:20:16AM +0200, Michal Suchanek wrote:
> Hello
>=20
> On 20 May 2011 11:15, Tejun Heo <tj@kernel.org> wrote:
>=20
> >
> >> [ =A0 =A03.080341] ahci 0000:00:1f.2: flags: 64bit ncq sntf led cl=
o pio ems sxs
> >
> > But in this case, the above is enough. =A0Your controller doesn't
> > support port multiplier. =A0It doesn't have "pmp" flag set.
>=20
> So the table at
> https://ata.wiki.kernel.org/index.php/SATA_hardware_features listing
> ICH10 as having CBS PMP support is bogus?

That tables says "ICH10R only".  Maybe some other variants too.  You
need to consult the datasheets to determine exactly which products
enable which features.  It doesn't have much to do with the driver.
It's the hardware controller marked as not supporting port multiplier
mostly thanks to intel's product differentiation.

Thanks.

--=20
tejun
