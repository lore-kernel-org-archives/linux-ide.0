From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Sat, 1 Feb 2014 12:36:05 -0300
Message-ID: <20140201153604.GA20710@localhost>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
 <1391264157-2112-3-git-send-email-andrew@lunn.ch>
 <20140201144457.GA20358@localhost>
 <20140201145659.GF26003@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46836 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933066AbaBAPf4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Feb 2014 10:35:56 -0500
Content-Disposition: inline
In-Reply-To: <20140201145659.GF26003@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: tj@kernel.org, kishon@ti.com, linux-ide@vger.kernel.org

On Sat, Feb 01, 2014 at 03:56:59PM +0100, Andrew Lunn wrote:
> > IMHO, this new series look much better. However, I still think the =
above code
> > is highly confusing (took me some time to see why you don't print t=
he warning
> > on PROBE_DEFER, but do the goto in all cases).
> >=20
> > Would it be too much to ask to add some comments to it? Your previo=
us
> > explanation about why we need to fail on EPROBE_DEFER, to allow the=
 phy
> > driver to load, was great. Adding some of that here would be nice.
>=20
> Anybody writing device drivers should know about EPROBE_DEFER.  If
> they don't they are writing broken drivers. So putting in a comment
> here would be just pointing out the obvious.
>=20

Maybe you're right. It wasn't obvious to me, though.

> What i can however do is add a comment that devm_phy_get_optional()
> returns a valid phy if there is no error. Might that help with the
> confusion?
>=20

Well, In don't think devm_phy_get_optional() brings any confusion.
The name itself is pretty self-explanatory, and in that case you can al=
ways
go look at the function implementation and documentation.

So, I'd say no.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
