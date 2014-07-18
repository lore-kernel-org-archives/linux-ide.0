From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v10 0/8] ARM: berlin: add AHCI support
Date: Fri, 18 Jul 2014 09:57:58 -0400
Message-ID: <20140718135758.GB13012@htj.dyndns.org>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:42238 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161152AbaGRN6D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2014 09:58:03 -0400
Content-Disposition: inline
In-Reply-To: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

(cc'ing Hans who's now maintaining libahci-platform.)

On Fri, Jul 18, 2014 at 02:29:59PM +0200, Antoine T=E9nart wrote:
> Tejun, Kishon, Sebastian,
>=20
> I looked into the AHCI framework to see how to map PHYs and ports
> information. I see two ways of doing this:
>   - We can attach the ahci_port_priv to the ahci_host_priv structure,
>     but that would require quite a lot of changes since the
>     ahci_port_priv is initialized at the very end (in port_start()) a=
nd
>     because ahci_port_priv is currently retrieved from the ata_port
>     structure in libahci functions. We do want to parse the dt ports
>     early in the AHCI initialization to be able to generate the right
>     port_map mask. Tests would be needed to ensure nothing is broken.
>   - We can move the PHY handling to where the ports are handled, movi=
ng
>     PHYs from ahci_host_priv to ahci_port_priv. This also would requi=
re
>     to perform some tests as PHY operations would be moved from
>     libahci_platform to libahci.

I don't get the last part.  Why would it have to be moved from
libahci_platform to libahci?  Can't we break up the init steps so that
PHY handling can be put inbetween?  The last time I suggested that,
Hans seemed to agree.

> In both cases we do not have time to do this for the next release, as
> the request popped up quite late.
>=20
> So as of now:
>   - Either the series is merged as is and changes to the AHCI framewo=
rk
>     can be made for 3.18, as it's not particularly linked to this
>     series.
>   - Or you really do not want it. Then that would be great if patches
>     1-2 and 7-8 could be merged so that we do not end up with this bi=
g
>     series going for yet another cycle... I think Kishon already took
>     patches 1-2.

I don't wanna take in code which isn't in the shape that it should be.
Things like this accumulate to become a large maintenance burden over
time.  Sure, urgent things can slip in and then later be fixed up but
who are gonna do that here?  You guys already seem to be under time
pressure as it is.

If you guys can figure something out with Hans regarding how to
proceed on this, I'll be happy take the code as is.

Thanks.

--=20
tejun
