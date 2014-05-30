From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Bad DMA from Marvell 9230
Date: Fri, 30 May 2014 20:37:58 +1000
Message-ID: <1401446278.14938.26.camel@pasglop>
References: <1395903457.5569.89.camel@pasglop>
	 <20140530030618.5ad4f447@Vantage>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37774 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbaE3KiV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2014 06:38:21 -0400
In-Reply-To: <20140530030618.5ad4f447@Vantage>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?J=E9r=F4me?= Carretero <cJ-ko@zougloub.eu>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, 2014-05-30 at 03:06 -0400, J=C3=A9r=C3=B4me Carretero wrote:
> On Thu, 27 Mar 2014 17:57:37 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>=20
> > I've been trying a 9230 on a power box here (a 9235 on the same
> > machine works fine) and it blows up with an IOMMU violation early
> > during init.
>=20
> Hi,
>=20
> That's https://bugzilla.kernel.org/show_bug.cgi?id=3D42679
> if you haven't already found it.

Somewhat... It's not the phantom function, the error I capture in my
IOMMU shows that it's trying to read from address 0 which is unmapped
but with the right initiator.

This device is a pile of crap. We've talked to Marvell support channel,
sent driver traces etc... but they didn't admit anything.

We've switched to a 9235 instead which seems to work fine.

Cheers,
Ben.


