From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v12 4/8] ata: libahci: allow to use multiple PHYs
Date: Tue, 29 Jul 2014 10:34:38 -0400
Message-ID: <20140729143438.GB4791@htj.dyndns.org>
References: <1406618447-25499-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:47998 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbaG2Oen (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2014 10:34:43 -0400
Content-Disposition: inline
In-Reply-To: <1406618447-25499-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 29, 2014 at 09:20:47AM +0200, Antoine T=E9nart wrote:
> The current implementation of the libahci does not allow to use multi=
ple
> PHYs. This patch adds the support of multiple PHYs by the libahci whi=
le
> keeping the old bindings valid for device tree compatibility.
>=20
> This introduce a new way of defining SATA ports in the device tree, w=
ith
> one port per sub-node. This as the advantage of allowing a per port
> configuration. Because some ports may be accessible but disabled in t=
he
> device tree, the port_map mask is computed automatically when using
> this.
>=20
> Signed-off-by: Antoine T=E9nart <antoine.tenart@free-electrons.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Patch doesn't apply to libata/for-3.17.  Please refresh.

Thanks.

--=20
tejun
