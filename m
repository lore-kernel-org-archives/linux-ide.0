From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
Date: Tue, 8 Jul 2014 09:42:03 -0400
Message-ID: <20140708134203.GD4979@htj.dyndns.org>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:38829 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbaGHNmH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2014 09:42:07 -0400
Content-Disposition: inline
In-Reply-To: <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

One more thing.

On Mon, Jul 07, 2014 at 12:16:09PM +0200, Antoine T=E9nart wrote:
> This introduce a new way of defining SATA ports in the device tree, w=
ith
> one port per sub-node. This as the advantage of allowing a per port
> configuration. Because some ports may be accessible but disabled in t=
he
> device tree, the default port_map is computed automatically when usin=
g
> this.

Any chance the old one phy config can be moved over to this scheme so
that we don't have to carry two separate mechanisms?

Thanks.

--=20
tejun
