From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
Date: Tue, 8 Jul 2014 19:05:33 +0200
Message-ID: <20140708170533.GB16148@kwain>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134203.GD4979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40117 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753747AbaGHRFh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2014 13:05:37 -0400
Content-Disposition: inline
In-Reply-To: <20140708134203.GD4979@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 08, 2014 at 09:42:03AM -0400, Tejun Heo wrote:
> One more thing.
>=20
> On Mon, Jul 07, 2014 at 12:16:09PM +0200, Antoine T=E9nart wrote:
> > This introduce a new way of defining SATA ports in the device tree,=
 with
> > one port per sub-node. This as the advantage of allowing a per port
> > configuration. Because some ports may be accessible but disabled in=
 the
> > device tree, the default port_map is computed automatically when us=
ing
> > this.
>=20
> Any chance the old one phy config can be moved over to this scheme so
> that we don't have to carry two separate mechanisms?

That would break the DT ABI.


Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
