From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] ATA: sata_mv: Remove uneeded CONFIG_HAVE_CLK ifdefs
Date: Mon, 29 Jul 2013 13:51:02 -0300
Message-ID: <20130729165101.GC22756@localhost>
References: <1375111282-22624-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1375111282-22624-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130729160016.GC22605@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49167 "EHLO
	mail.free-electrons.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751755Ab3G2Qu6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jul 2013 12:50:58 -0400
Content-Disposition: inline
In-Reply-To: <20130729160016.GC22605@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>

On Mon, Jul 29, 2013 at 12:00:16PM -0400, Tejun Heo wrote:
> On Mon, Jul 29, 2013 at 12:21:22PM -0300, Ezequiel Garcia wrote:
> > If CONFIG_HAVE_CLK is not selected, then all the clk API turn out
> > into stubs, so there's no need to have the ifdefs.
> > The only side-effect of this patch is the extra tiny kmalloc,
> > but that's not enough reason to have such ugly ifdefs all around
> > the code.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>=20
> Can you please add a comment in the hpriv definition explaining what
> that clk is for and how it's optional and becomes noops when not
> needed?
>=20

Sure.

Thanks for the feedback,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
