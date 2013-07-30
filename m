From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2] ATA: sata_mv: Remove unneeded CONFIG_HAVE_CLK ifdefs
Date: Tue, 30 Jul 2013 10:16:28 -0300
Message-ID: <20130730131626.GC2375@localhost>
References: <1375152363-3451-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130730130411.GC12016@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:41584 "EHLO
	mail.free-electrons.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752523Ab3G3NQh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jul 2013 09:16:37 -0400
Content-Disposition: inline
In-Reply-To: <20130730130411.GC12016@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Tue, Jul 30, 2013 at 09:04:11AM -0400, Tejun Heo wrote:
> On Mon, Jul 29, 2013 at 11:46:03PM -0300, Ezequiel Garcia wrote:
> > If CONFIG_HAVE_CLK is not selected, then all the clk API turn out
> > into no-ops. In other words, there's no need to have the ifdefs.
> >=20
> > The only side-effect of this patch is the extra tiny kmalloc,
> > but that's not enough reason to have such ugly ifdefs all around
> > the code.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>=20
> Applied to libata/for-3.12 with Andrew's comment suggestion applied
> and acked-by added.
>=20

Great, thanks for taking care of that.

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
