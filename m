From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v12 4/8] ata: libahci: allow to use multiple PHYs
Date: Wed, 30 Jul 2014 09:38:16 +0200
Message-ID: <20140730073816.GA29900@kwain>
References: <1406618447-25499-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140729143438.GB4791@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53232 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755061AbaG3HiV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2014 03:38:21 -0400
Content-Disposition: inline
In-Reply-To: <20140729143438.GB4791@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 29, 2014 at 10:34:38AM -0400, Tejun Heo wrote:
> On Tue, Jul 29, 2014 at 09:20:47AM +0200, Antoine T=E9nart wrote:
> > The current implementation of the libahci does not allow to use mul=
tiple
> > PHYs. This patch adds the support of multiple PHYs by the libahci w=
hile
> > keeping the old bindings valid for device tree compatibility.
> >=20
> > This introduce a new way of defining SATA ports in the device tree,=
 with
> > one port per sub-node. This as the advantage of allowing a per port
> > configuration. Because some ports may be accessible but disabled in=
 the
> > device tree, the port_map mask is computed automatically when using
> > this.
> >=20
> > Signed-off-by: Antoine T=E9nart <antoine.tenart@free-electrons.com>
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Patch doesn't apply to libata/for-3.17.  Please refresh.

This patch is base on top of v3.16-rc7, taking in account a patch[1]
introduced after rc1 modifying this same file.

[1] https://lkml.org/lkml/2014/6/6/75

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
